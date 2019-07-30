package windows {
	import flash.display.Sprite;
	
	public class FieldWindow extends Sprite {
		private var _nodeWindow:Sprite;
		private var _edgeWindow:Sprite;
		
		
		public function FieldWindow() {
			_nodeWindow = new Sprite();
			_edgeWindow = new Sprite();
			
			this.addChild(_edgeWindow);
			this.addChild(_nodeWindow);
			
			draw();
			initMask();
		}
		
		private function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(DrawSpecs.FIELD_WINDOW_BACKGROUND, 1);
			this.graphics.lineStyle(DrawSpecs.GENERAL_BORDER_WIDTH, DrawSpecs.GENERAL_BORDER_COLOR);
			this.graphics.drawRect(0, 0, DrawSpecs.FIELD_WINDOW_WIDTH, DrawSpecs.FIELD_WINDOW_HEIGHT);
			this.graphics.endFill();
		}
		private function initMask():void {
			var maskSprite:Sprite = new Sprite();
			maskSprite.graphics.beginFill(0);
			var w:Number = DrawSpecs.GENERAL_BORDER_WIDTH;
			maskSprite.graphics.drawRect(-w/2, -w/2, DrawSpecs.FIELD_WINDOW_WIDTH + w, DrawSpecs.FIELD_WINDOW_HEIGHT + w);
			maskSprite.graphics.endFill();
			this.mask = maskSprite;
			this.addChild(mask);
			this.addChild(maskSprite);
		}
		
		public function addNode(__node:Node):void {
			_nodeWindow.addChild(__node);
		}
		public function removeNode(__node:Node):void {
			_nodeWindow.removeChild(__node);
		}
		public function addEdge(__edge:Edge):void {
			_edgeWindow.addChild(__edge);
		}
		public function removeEdge(__edge:Edge):void {
			_edgeWindow.removeChild(__edge);
		}
	}
}