package {
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	public class BigPumpElement extends PumpElement {
		private var _stateText:TextField;
		
		public function BigPumpElement(__edge:Edge, __inNode:Node, __outNode:Node) {
			super(__edge, __inNode, __outNode);
			_speed = 1.0 / (GameEngine.NODE_RECEIVE - GameEngine.EDGE_TRANSFER);
			
			_stateText = Main.field();
			var tf:TextFormat = new TextFormat(Main.font().fontName, 24, 0xFFFFFF, null, null, null, null, TextFormatAlign.CENTER);
			_stateText.defaultTextFormat = tf;
			_stateText.width = DrawSpecs.EDGE_WIDTH * 6;
			_stateText.x = -15;
			_stateText.y = -15;
			_stateText.text = __edge.activeState.toString();
			
			this.addChild(_stateText);
		}
		
		override protected function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(DrawSpecs.EDGE_COLOR);
			this.graphics.drawCircle(0, 0, DrawSpecs.EDGE_WIDTH * 3);
			this.graphics.endFill();
		}
	}
}