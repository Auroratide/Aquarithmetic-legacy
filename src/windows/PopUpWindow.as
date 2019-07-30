package windows {
	import com.newprogrammer.gl.display.Button;
	import flash.display.Sprite;
	import flash.text.TextField;
	public class PopUpWindow extends Sprite {
	//  for the sake of time, this is now just a win screen
		private var _nextLevel:StandardButton;
		private var _winText:TextField;
		
		public function PopUpWindow() {
			_nextLevel = new StandardButton(nextLevelClicked, DrawSpecs.BUTTON_RESET_WIDTH, DrawSpecs.BUTTON_RESET_HEIGHT, "Next >", DrawSpecs.TEXT_BUTTON_SIZE);
			_winText = Main.field(40);
			_winText.width = DrawSpecs.POPUP_WINDOW_WIDTH;
			_winText.x = DrawSpecs.STAGE_WIDTH / 2 - _winText.width / 2;
			_winText.y = 225;
			_winText.text = "Level Complete!";
			
			draw();
			
			_nextLevel.x = DrawSpecs.STAGE_WIDTH / 2 - DrawSpecs.BUTTON_RESET_WIDTH / 2;
			_nextLevel.y = 350;
			_nextLevel.activate();
			this.addChild(_winText);
			this.addChild(_nextLevel);
		}
		
		private function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(0, .5);
			this.graphics.drawRect(0, 0, DrawSpecs.STAGE_WIDTH, DrawSpecs.STAGE_HEIGHT);
			this.graphics.endFill();
			this.graphics.lineStyle(DrawSpecs.GENERAL_BORDER_WIDTH, DrawSpecs.GENERAL_BORDER_COLOR);
			this.graphics.beginFill(DrawSpecs.GENERAL_BACKGROUND);
			this.graphics.drawRect(DrawSpecs.POPUP_WINDOW_WIDTH / 2, DrawSpecs.POPUP_WINDOW_HEIGHT / 2, DrawSpecs.POPUP_WINDOW_WIDTH, DrawSpecs.POPUP_WINDOW_HEIGHT);
			this.graphics.endFill();
		}
		
		private function nextLevelClicked(__b:Button):void {
			Main.aquarithmetic.engine.nextLevel();
		}
		
	}
}