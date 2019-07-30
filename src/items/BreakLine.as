package items {
	public class BreakLine extends Edge {
		public function BreakLine(__inNode:Node, __outNode:Node) {
			super(__inNode, __outNode);
			draw();
		}
		
		override protected function draw():void {
			this.graphics.clear();
			this.graphics.lineStyle(DrawSpecs.EDGE_WIDTH, DrawSpecs.BREAK_COLOR);
			this.graphics.moveTo(inNode.x, inNode.y);
			this.graphics.lineTo(outNode.x, outNode.y);
		}
		
		public function breakLine():void {
			_valid = false;
			stopPumps();
		}
		
		/*  For Game Flow
		=====================================================================*/
		override public function receive(__flowCandidates:Vector.<int>):int {
		//  Basic lines only consider the first option
			setActiveState(__flowCandidates[0]);
			return activeState;
		}
		override public function dispatch():int {
			if(activeState > 0)
				breakLine();
			return activeState;
		}
	}
}