package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import items.BasicLine;
	import items.BasicRelay;
	import items.BreakLine;
	import items.GoalRelay;
	import windows.GameWindow;
	import windows.FieldWindow;
	
	import com.newprogrammer.gl.display.Button;
	
	public class GameEngine extends Sprite {
	//  Game Flow Constants for Timing
		public static const NODE_PREDISPATCH:uint = 0;
		public static const NODE_DISPATCH:uint = 1;
		public static const EDGE_TRANSFER:uint = 3;
		public static const NODE_RECEIVE:uint = 90;
		public static const CYCLE_END:uint = 120;
		public static const CYCLE_WIN:uint = 160;
		
		private var _gameWindow:GameWindow;
		private var _levelNodes:Vector.<Node>;
		private var _levelEdges:Vector.<Edge>;
		private var _playerNodes:Vector.<Node>;
		private var _playerEdges:Vector.<Edge>;
		
		private var _editMode:Boolean;
		
	//  The following are holders for engine actions
	    private var _candidateEdgeType:String;
		private var _candidateNodeType:String;
		private var _candidateInNode:Node;
		private var _candidateOutNode:Node;
		private var _candidateNode:Node;
		private var _continueLine:Boolean;
		
		private var _gameFlowCounter:uint;
		
		private var _levels:Vector.<Object>;
		private var _curLevel:Object;
		private var _curLevelIndex:int;
		
		public function GameEngine(__gameWindow:GameWindow) {
			_gameWindow = __gameWindow;
			_levelNodes = new Vector.<Node>();
			_levelEdges = new Vector.<Edge>();
			_playerNodes = new Vector.<Node>();
			_playerEdges = new Vector.<Edge>();
			
			_editMode = false;
			
			_gameFlowCounter = 0;
			_levels = Vector.<Object>([Levels.T01, Levels.T02, Levels.T03, Levels.T04, Levels.T05, Levels.T06,
			                           Levels.N01, Levels.N02, Levels.N03, Levels.N04, Levels.N05, Levels.A01, Levels.A02, Levels.A03]);
			_curLevelIndex = 0;
			_continueLine = false;
		}
		
		public function nextLevel():void {
			++_curLevelIndex;
			if (_curLevelIndex >= _levels.length)
				_curLevelIndex = 0; // loop back for demo
			load(_levels[_curLevelIndex]);
			_gameWindow.hideWinScreen();
		}
		
		public function load(__level:Object):void {
			_curLevel = __level;
			deactivateEditMode();
			clearAll();
			parse(__level);
			for (var i:int = 0; i < _levelNodes.length; ++i)
				_gameWindow.addNodeToField(_levelNodes[i]);
			for (var j:int = 0; j < _levelEdges.length; ++j)
				_gameWindow.addEdgeToField(_levelEdges[j]);
				
			startLevel();
		}
		
		private function parse(__level:Object):void {
		/*  Order:
			 * Get Level Title
			 * Level Difficulty is unneeded for now
			 * Star data (?) !TODO
			 * create nodes
			 * create edges
			 * item availability
		*/
			_gameWindow.setTitle(__level.name);
			
			var levelNodes:Array = __level.nodes;
			for (var i:int = 0; i < levelNodes.length; ++i)
				_levelNodes.push(Node.parseNode(levelNodes[i]));
			
			var levelEdges:Array = __level.edges;
			for (var j:int = 0; j < levelEdges.length; ++j) 
				_levelEdges.push(Edge.parseEdge(levelEdges[j], _levelNodes));
				
			_gameWindow.parseItemAvailability(__level.items);
		}
		
		public function clearPlayerGraph():void {
			clearSubGraph(_playerNodes, _playerEdges);
		}
		private function clearLevelGraph():void {
			clearSubGraph(_levelNodes, _levelEdges);
		}
		private function clearSubGraph(__nodes:Vector.<Node>, __edges:Vector.<Edge>):void {
			while (__edges.length > 0) {
				var edge:Edge = __edges.pop();
				edge.remove();
			//  RemoveChild
				_gameWindow.removeEdge(edge);
			}
			while (__nodes.length > 0) {
				var node:Node = __nodes.pop();
				node.remove();
			//  RemoveChild
				_gameWindow.removeNode(node);
			}
		}
		
		public function clearAll():void {
			clearPlayerGraph();
			clearLevelGraph();
		}
		
		public function startLevel():void {
			_gameWindow.startLevel();
			activateEditMode();
		}
		
		/*  THE MAIN FLOW FUNCTION
		=====================================================================*/
		public function runFlow():void {
		//  Called when user presses Run!
			deactivateEditMode();
			_gameFlowCounter = 0;
			prepareFlow();
			this.addEventListener(Event.ENTER_FRAME, flowFrame);
		}
		public function prepareFlow():void {
			var i:int = 0;
			for (i = 0; i < _levelNodes.length; ++i)
				_levelNodes[i].prepareForFlow();
			for (i = 0; i < _playerNodes.length; ++i)
				_playerNodes[i].prepareForFlow();
				
			for (i = 0; i < _levelEdges.length; ++i)
				_levelEdges[i].prepareForFlow();
			for (i = 0; i < _playerEdges.length; ++i)
				_playerEdges[i].prepareForFlow();
		}
		public function stopFromButton():void {
			stopFlow();
			prepareFlow();
			activateEditMode();
		}
		public function stopFlow():void {
			this.removeEventListener(Event.ENTER_FRAME, flowFrame);
		}
		private function flowFrame(__e:Event):void {
			var i:int = 0;
			switch(_gameFlowCounter) {
				case NODE_PREDISPATCH:
				//  Predispatch on all nodes
					for (i = 0; i < _levelNodes.length; ++i)
						_levelNodes[i].predispatch();
					for (i = 0; i < _playerNodes.length; ++i)
						_playerNodes[i].predispatch();
					break;
				case NODE_DISPATCH:
				//  Dispatch on all nodes
					for (i = 0; i < _levelNodes.length; ++i)
						_levelNodes[i].dispatch();
					for (i = 0; i < _playerNodes.length; ++i)
						_playerNodes[i].dispatch();
					break;
				case EDGE_TRANSFER:
				//  Transfer on all edges
					for (i = 0; i < _levelEdges.length; ++i)
						_levelEdges[i].transfer();
					for (i = 0; i < _playerEdges.length; ++i)
						_playerEdges[i].transfer();
					break;
				case NODE_RECEIVE:
				//  Receive on all nodes
					for (i = 0; i < _levelNodes.length; ++i)
						_levelNodes[i].receive();
					for (i = 0; i < _playerNodes.length; ++i)
						_playerNodes[i].receive();
					break;
				case CYCLE_END:
				//  Start next cycle
					if(!allNodesSatisfied()){
						_gameFlowCounter = 0;
						return;
					}
					break;
				case CYCLE_WIN:
				//  Level won!
					trace("win!");
					_gameWindow.showWinScreen();
					break;
				default: break;
			}
			++_gameFlowCounter;
		}
		
		public function allNodesSatisfied():Boolean {
		//  Only check level nodes, as players cannot make goal nodes
			for (var i:int = 0; i < _levelNodes.length; ++i){
				if (!_levelNodes[i].isSatisfied())
					return false;
			}
			return true;
		}
		
		/*  Player Actions (Edit Mode Stuff)
		=====================================================================*/
		public function resetLevel():void {
			clearPlayerGraph();
			_gameWindow.parseItemAvailability(_curLevel.items);
			activateEditMode();
		}
		public function activateEditMode():void {
			_editMode = true;
			_gameWindow.activateItems();
		}
		public function deactivateEditMode():void {
			_editMode = false;
			cancelPlayerEdit(); // cancel current edits
			_gameWindow.deactivateItems();
		}
		
	/*  Create Lines */
		public function prepareLineInNode(__type:String):void {
			_candidateEdgeType = __type;
			var i:int;
			for (i = 0; i < _levelNodes.length; ++i)
				_levelNodes[i].activateForInNode();
			for (i = 0; i < _playerNodes.length; ++i)
				_playerNodes[i].activateForInNode();
		}
		public function prepareLineForCancel():void {
		// !DEPRECATED
			_gameWindow.addEventListener(MouseEvent.MOUSE_UP, cancelLine);
		}
		public function prepareLineOutNode(__node:Node):void {
		/*  Set the potential inNode for new Edge
		 *  Deactivate all nodes
		 *  Activate only appropriate nodes
		 */
			_candidateInNode = __node;
			
			var i:int;
			deactivateAllNodes();
				
		//  Activate everything, then deactivate those connected to candidate innode; O(v+e)
			for (i = 0; i < _levelNodes.length; ++i)
				_levelNodes[i].activateForOutNode();
			for (i = 0; i < _playerNodes.length; ++i)
				_playerNodes[i].activateForOutNode();
			
			_candidateInNode.deactivate();
			_candidateInNode.deactivateConnectedNodes();
			
			_gameWindow.addEventListener(MouseEvent.MOUSE_UP, cancelLine);
		}
		public function cancelLine(__e:MouseEvent = null):void {
			deactivateAllNodes();
			
			_gameWindow.removeEventListener(MouseEvent.MOUSE_UP, cancelLine);
			_candidateInNode = null;
			_candidateOutNode = null;
			
			if(_continueLine){
				prepareLineInNode(_candidateEdgeType);
				_continueLine = false;
			}
			
			trace("line canceled");
		}
		public function confirmEdgeCreation(__node:Node):void {
		//  Creates an edge if valid
			_candidateOutNode = __node;
			if (_candidateInNode != _candidateOutNode)
				createEdge();
		}
		
		public function createEdge():Edge {
		//  NOT addEdge; this uses the candidates and updates the item list
			var e:Edge;
			if (_candidateEdgeType == Edge.BASIC_LINE)
				e = new BasicLine(_candidateInNode, _candidateOutNode);
			else if (_candidateEdgeType == Edge.BREAK_LINE)
				e = new BreakLine(_candidateInNode, _candidateOutNode);
			else
				throw new Error("ERROR in GameEngine createEdge: Not an edge type");
			
			if (_gameWindow.decrementItem(_candidateEdgeType))
			    _continueLine = true;
			_playerEdges.push(e);
			_gameWindow.addEdgeToField(e);
			
			trace("Line Created");
			
			//prepareLineInNode(_candidateEdgeType);
			
			return e;
		}
	/*  End Create Lines */
	
	/*  Create Nodes */
		public function prepareNode(__type:String):void {
			_candidateNodeType = __type;
			_candidateNode = Node.nodeFromType(__type);
			_candidateNode.alpha = DrawSpecs.NODE_CANDIDATE_ALPHA;
			_gameWindow.addNodeToField(_candidateNode);
			_candidateNode.startFollowMouse();
			_gameWindow.fieldWindow.addEventListener(MouseEvent.MOUSE_UP, confirmNodeCreation);
		}
		public function confirmNodeCreation(__e:MouseEvent):void {
		//  Is it valid?  Valid if not intersecting node, edge, or boundary
		//  !TODO : just did nodes and boundary for now; edges are hard
			if (_candidateNode == null)
				throw new Error("ERROR in GameEngine confirmNodeCreation: Candidate Node null");
			if (!isNodeColliding(_candidateNode)) {
				_gameWindow.fieldWindow.removeEventListener(MouseEvent.MOUSE_UP, confirmNodeCreation);
				_candidateNode.endFollowMouse();
				_candidateNode.alpha = 1;
				
				_gameWindow.decrementItem(_candidateNodeType);
				_playerNodes.push(_candidateNode);
				_candidateNode = null;
				
				//prepareNode(_candidateNodeType);  // allow for next one
				
				trace("NODE PLACED");
			}
		}
		public function cancelNode(__e:MouseEvent = null):void {
			if (_candidateNode == null)
				return; // possible, not error
			_gameWindow.fieldWindow.removeEventListener(MouseEvent.MOUSE_UP, confirmNodeCreation);
			_candidateNode.endFollowMouse();
			_gameWindow.removeNode(_candidateNode);
			_candidateNode = null;
		}
		public function isNodeColliding(__node:Node):Boolean {
		//  true if given node is touching another node
		//  !TODO : Bugged heavily; use geometric test instead, or set HitTestArea
			var i:int;
			for (i = 0; i < _levelNodes.length; ++i) {
				if (_levelNodes[i].hitting(__node))
					return true;
			}
			for (i = 0; i < _playerNodes.length; ++i) {
				if (_playerNodes[i].hitting(__node))
					return true;
			}
			return false;
		}
		
	/*  End Create Nodes */
	
		public function cancelPlayerEdit():void {
			cancelLine();
			cancelNode();
		}
		
		public function deactivateAllNodes():void {
			var i:int;
		    for (i = 0; i < _levelNodes.length; ++i)
				_levelNodes[i].deactivate();
			for (i = 0; i < _playerNodes.length; ++i)
				_playerNodes[i].deactivate();
		}
	}
}