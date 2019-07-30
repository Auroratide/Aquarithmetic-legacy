package {
	import com.newprogrammer.gl.display.Button;
	import flash.text.TextField;
	
	public class StandardButton extends Button {
		private var _btnWidth:Number;
		private var _btnHeight:Number;
		private var _color:uint;
		private var _hoverColor:uint;
		private var _field:TextField;
		
		public function StandardButton(__action:Function, __width:Number, __height:Number, __text:String,
		                               __textSize:Object = DrawSpecs.TEXT_BUTTON_SIZE,
									   __color:uint = DrawSpecs.BUTTON_BACKGROUND,
									   __hoverColor:uint = DrawSpecs.BUTTON_HOVER_BACKGROUND) {
			super(__action);
			_btnWidth = __width;
			_btnHeight = __height;
			_color = __color;
			_hoverColor = __hoverColor;
			
			_field = Main.field(__textSize);
			_field.width = __width;
			_field.text = __text;
			
			draw(null);
			deactivate();
			
			onHoverAction = drawHover
			outHoverAction = draw;
			
			// !TODO : Mask Button
			
			this.addChild(_field);
		}
		
		private function drawBegin():void {
			this.graphics.clear();
			this.graphics.lineStyle(DrawSpecs.GENERAL_BORDER_WIDTH, DrawSpecs.GENERAL_BORDER_COLOR);
			this.graphics.beginFill(_color);
		}
		private function drawEnd():void {
			this.graphics.endFill();
		}
		private function draw(__b:Button):void {
			drawBegin();
			this.graphics.drawRect(0, 0, _btnWidth, _btnHeight);
			drawEnd();
		}
		private function drawHover(__b:Button):void {
			drawBegin();
			this.graphics.beginFill(_hoverColor);
			this.graphics.drawRect(0, 0, _btnWidth, _btnHeight);
			drawEnd();
		}
	}
}