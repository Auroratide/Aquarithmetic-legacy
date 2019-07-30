package items {
	public class BasicLine extends Edge {
		public function BasicLine(__inNode:Node, __outNode:Node) {
			super(__inNode, __outNode);
			draw();
		}
		
		override protected function draw():void {
			this.graphics.clear();
			this.graphics.lineStyle(DrawSpecs.EDGE_WIDTH, DrawSpecs.EDGE_COLOR);
			this.graphics.moveTo(inNode.x, inNode.y);
			this.graphics.lineTo(outNode.x, outNode.y);
		}
		
		/*  For Game Flow
		=====================================================================*/
		override public function receive(__flowCandidates:Vector.<int>):int {
		//  Basic lines only consider the first option
			setActiveState(__flowCandidates[0]);
			return activeState;
		}
	}
}