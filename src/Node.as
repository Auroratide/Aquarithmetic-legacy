package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.MouseEvent;
	import items.*;
	
	public class Node extends Sprite {
		public static const BASIC_RELAY:String = "basic";
		public static const GOAL_RELAY:String = "goal";
		public static const MULTIPLY_RELAY:String = "multiply";
		
		private var _restState:int;
		private var _activeState:int;
		private var _inEdges:Vector.<Edge>;
		private var _outEdges:Vector.<Edge>;
		
		private var _stateField:TextField;
		
	//  For Game Flow
		private var _validEdges:Vector.<Edge>;
		
		private var _hitBox:Sprite;
		
		public function Node(__restState:int = 0) {
			_restState = __restState;
			_activeState = _restState;
			_inEdges = new Vector.<Edge>();
			_outEdges = new Vector.<Edge>();
			
			_stateField = Main.field(DrawSpecs.TEXT_NODE_SIZE);
			_stateField.width = DrawSpecs.NODE_WIDTH;
			_stateField.x = -DrawSpecs.NODE_WIDTH / 2;
			_stateField.y = -DrawSpecs.NODE_WIDTH / 2 + fieldOffset();
			_stateField.text = _restState.toString();
			if (__restState < 0)
				_stateField.text = ""; // for itembuttons
			this.addChild(_stateField);
			
			_validEdges = new Vector.<Edge>();
			
			_hitBox = new Sprite();
			_hitBox.graphics.beginFill(0, 0);
			var w:Number = DrawSpecs.NODE_WIDTH;
			_hitBox.graphics.drawRect( -w / 2, -w / 2, w, w);
			_hitBox.graphics.endFill();
			this.addChild(_hitBox);
		}
		
		
		public function addInEdge(__edge:Edge):void {
			_inEdges.push(__edge);
		}
		public function addOutEdge(__edge:Edge):void {
			_outEdges.push(__edge);
		}
		public function remove():void {
		//  Assume that all edges are removed already!!!
			if (_inEdges.length > 0 || _outEdges.length > 0)
			    throw new Error("ERROR in Node remove: Edges exist");
			destroy();
		}
		public function removeInEdge(__inEdge:Edge):void {
		//  Call from Edge.remove()
			removeEdge(_inEdges, __inEdge);
		}
		public function removeOutEdge(__outEdge:Edge):void {
		//  Call from Edge.remove()
			removeEdge(_outEdges, __outEdge);
		}
		
		private function removeEdge(__edgeList:Vector.<Edge>, __edge:Edge):void {
			for (var i:int = 0; i < __edgeList.length; ++i) {
				if (__edgeList[i] == __edge){
					__edgeList.splice(i, 1);
					return;
				}
			}
			throw new Error("ERROR in Node removeEdge: Not an edge");
		}
		
		private function destroy():void {
			_inEdges = null;
			_outEdges = null;
			this.removeChild(_stateField);
		}
		
		protected function draw():void { }
		public function isSatisfied():Boolean {
		//  Returns if it satisfies a win condition; useable for multiple kinds of goal nodes
			return true;
		}
		protected function fieldOffset():Number {  return 0; }
		public function idleAnim():void { }
		
		protected function get validEdges():Vector.<Edge> {  return _validEdges; }
		protected function get inEdges():Vector.<Edge> {  return _inEdges; }
		
		public function get activeState():int {  return _activeState; }
		public function get restState():int {  return _restState; }
		protected function setActiveState(__value:int):void {
			_activeState = __value;
			updateStateField();
		}
		private function updateStateField():void {
			_stateField.text = _activeState.toString();
		}
		
		public static function parseNode(__node:Object):Node {
		//  Create Nodes
			var n:Node;
			var s:int = __node.state;
			var nType:String = __node.type;
			if (nType == Node.BASIC_RELAY)
				n = new BasicRelay(s);
			else if (nType == Node.GOAL_RELAY)
				n = new GoalRelay(s, __node.goalState);
			else if (nType == Node.MULTIPLY_RELAY)
				n = new MultiplyRelay(s);
			else //unknown!!
				throw new Error("ERROR in Node parseNode: Unknown Node Type");
			
			n.x = __node.x;
			n.y = __node.y;
			return n;
		}
		
		/*  For Line Creation
		=====================================================================*/
		public function activateForInNode():void {
		//  Turns the node into a button that when clicked will set this as
		//  an in node.  An outnode must be released on to confirm.
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownInNode);
		//  Add Listener to FieldWindow
		//	Main.aquarithmetic.engine.prepareLineForCancel();
		}
		public function activateForOutNode():void {
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpOutNode);
			//Main.aquarithmetic.engine.prepareLineForCancel();
		}
		public function deactivate():void {
			this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownInNode);
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpOutNode);
		}
		public function deactivateConnectedNodes():void {
			var i:int;
			for (i = 0; i < _inEdges.length; ++i) 
				_inEdges[i].otherNode(this).deactivate();
			for (i = 0; i < _outEdges.length; ++i) 
				_outEdges[i].otherNode(this).deactivate();
		}
		
		public function mouseDownInNode(__e:MouseEvent):void {
			Main.aquarithmetic.engine.prepareLineOutNode(this);
			trace("in down");
		}
		public function mouseUpOutNode(__e:MouseEvent):void {
			Main.aquarithmetic.engine.confirmEdgeCreation(this);
		}
		
		/*  For Node Creation
		=====================================================================*/
		public function startFollowMouse():void {
			this.addEventListener(Event.ENTER_FRAME, followMouseFrame);
		}
		public function endFollowMouse():void {
			this.removeEventListener(Event.ENTER_FRAME, followMouseFrame);
		}
		private function followMouseFrame(__e:Event):void {
			this.x = parent.mouseX;
			this.y = parent.mouseY;
		}
		public static function nodeFromType(__type:String):Node {
			if (__type == Node.BASIC_RELAY)
				return new BasicRelay();
			else if (__type == Node.GOAL_RELAY)
				return new GoalRelay();
			else if (__type == Node.MULTIPLY_RELAY)
				return new MultiplyRelay();
			else
				throw new Error("ERROR in Node nodeFromType: Invalid node type");
		}
		
		/*  For Game Flow
		=====================================================================*/
		public function prepareForFlow():void {
		//  Prepare for game flow; called at Run, not each cycle!!
			setActiveState(_restState);
		}
		public function predispatch():void {
		//  Gather valid edges
			_validEdges = new Vector.<Edge>();
			for (var i:int = 0; i < _outEdges.length; ++i) {
				if (_outEdges[i].valid)
					_validEdges.push(_outEdges[i]);
			}
		}
		public function dispatch():void {
		//  Call receive for all out edges
		//  Update active state if necessary
		}
		public function receive():void {
		//  call each inedge dispatch
		}
		
		
		// meh
		public function hitting(__node:Node):Boolean {
			return this._hitBox.hitTestObject(__node._hitBox);
		}
	}
}