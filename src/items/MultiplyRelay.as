package items {
	public class MultiplyRelay extends Node {
		public function MultiplyRelay(__restState:int = 1) {
			super(__restState);
			draw();
		}
		
		override protected function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(DrawSpecs.FIELD_WINDOW_BACKGROUND);
			this.graphics.lineStyle(DrawSpecs.NODE_BORDER_THICKNESS, DrawSpecs.NODE_BORDER_COLOR);
			var w:Number = DrawSpecs.NODE_WIDTH;
			this.graphics.moveTo( -w / 4, -w / 2);
			this.graphics.lineTo(w / 4, -w / 2);
			this.graphics.lineTo(w / 2, 0);
			this.graphics.lineTo(w / 4, w / 2);
			this.graphics.lineTo(-w / 4, w / 2);
			this.graphics.lineTo(-w / 2, 0);
			this.graphics.lineTo(-w / 4, -w / 2);
			this.graphics.endFill();
		}
		override protected function fieldOffset():Number {
			return DrawSpecs.NODE_BASIC_OFFSET;
		}
		
		/*  For Game Flow
		=====================================================================*/
		override public function dispatch():void {
			var sumToSend:int = 0;
			var i:int;
		//  Determine sendable values
			var sendableValues:Vector.<int> = new Vector.<int>();
			for (i = validEdges.length; i > 0; --i) {
				if (activeState % (i + 1) > 0)
					sendableValues.push(0);
				else {
					sendableValues.push(activeState / (i + 1));
				}
			}
			
			for (i = 0; i < validEdges.length; ++i)
				sumToSend += validEdges[i].receive(sendableValues);
				
			setActiveState(activeState - sumToSend);
		}
		
		override public function receive():void {
			var prodToAdd:int = 1;
			for (var i:int = 0; i < inEdges.length; ++i) {
				if (inEdges[i].valid)
					prodToAdd *= inEdges[i].dispatch();
			}
			setActiveState(activeState * prodToAdd);
		}
	}
}