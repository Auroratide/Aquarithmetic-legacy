package {
	import flash.display.Sprite;
	import flash.events.Event;
	import items.*;
	
	public class Edge extends Sprite {
		public static const BASIC_LINE:String = "basicL";
		public static const BREAK_LINE:String = "breakL";
		
		private var _restState:int;
		private var _activeState:int;
		private var _inNode:Node;  // the butt of arrow
		private var _outNode:Node; // the point of arrow
		
		private var _count:uint;
		
		protected var _valid:Boolean;
		
		public function Edge(__inNode:Node, __outNode:Node) {
			_inNode = __inNode;
			_outNode = __outNode;
			//_inNode.addInEdge(this);
			//_outNode.addOutEdge(this);
			_inNode.addOutEdge(this);
			_outNode.addInEdge(this);
			
			_count = 20;
			idleAnim();
			
			valid = true;
		}
		
		protected function get inNode():Node {  return _inNode; }
		protected function get outNode():Node {  return _outNode; }
		
		public function get valid():Boolean {  return _valid; }
		public function set valid(__value:Boolean):void {  _valid = __value; }
		
		public function hasNode(__node:Node):Boolean {
			return _inNode == __node || _outNode == __node;
		}
		public function otherNode(__node:Node):Node {
			if (__node == _inNode)
				return _outNode;
			else if (__node == _outNode)
				return _inNode;
			throw new Error("ERROR in Edge otherNode: Node not in edge");
		}
		
		public function remove():void {
			_inNode.removeOutEdge(this);
			_outNode.removeInEdge(this);
			destroy();
		}
		
	//  Note that edges do not have location themselves!
		protected function draw():void { }
		protected function idleAnim():void {
			this.addEventListener(Event.ENTER_FRAME, addPumps);
		}
		
		public function get activeState():int {  return _activeState; }
		protected function setActiveState(__value:int):void {
			_activeState = __value;
		}
		
		private function destroy():void {
			_inNode = null;
			_outNode = null;
			/*
			while (this.numChildren > 0)
				this.removeChildAt(0);*/
			this.removeEventListener(Event.ENTER_FRAME, addPumps);
		}
		
		public static function parseEdge(__edge:Object, __nodes:Vector.<Node>):Edge {
			var e:Edge;
			var eType:String = __edge.type;
			var inNode:Node = __nodes[__edge.begin];
			var outNode:Node = __nodes[__edge.end];
			if (eType == Edge.BASIC_LINE)
				e = new BasicLine(inNode, outNode);
			else if (eType == Edge.BREAK_LINE)
				e = new BreakLine(inNode, outNode);
			else // unknown
				throw new Error("ERROR in Edge parseEdge: Unknown Edge Type");
			return e;
		}
		
		private function addPumps(__e:Event):void {
			if (_count >= 30){
				this.addChild(new PumpElement(this, _inNode, _outNode));
				_count = 0;
			}
			++_count;
		}
		public function stopPumps():void {
			this.removeEventListener(Event.ENTER_FRAME, addPumps);
		}
		public function startPumps():void {
			idleAnim();
		}
		
		/*  For Game Flow
		=====================================================================*/
		public function prepareForFlow():void {
			_activeState = 0;
			_valid = true;
			if (!hasEventListener(Event.ENTER_FRAME))
				idleAnim();
		}
		public function receive(__flowCandidates:Vector.<int>):int {
		//  Returns the candidate selected
			return 0;
		}
		public function transfer():void {
		//  Animation for moving the transfered value
			this.addChild(new BigPumpElement(this, _inNode, _outNode));
		}
		public function predispatch():void {
		//  Call stuff?  Might not use?
		}
		public function dispatch():int {
		//  Return state to send to node
			return _activeState;
		}
	}
}