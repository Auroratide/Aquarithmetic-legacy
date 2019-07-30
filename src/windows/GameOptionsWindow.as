package windows {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.newprogrammer.gl.display.Button;
	
	public class GameOptionsWindow extends Sprite {
		private var _runButton:StandardButton;
		private var _stopButton:StandardButton;
		private var _resetButton:StandardButton;
		
		public function GameOptionsWindow() {
			_runButton = new StandardButton(runClicked, DrawSpecs.BUTTON_RUN_WIDTH, DrawSpecs.BUTTON_RUN_HEIGHT, "Run!", DrawSpecs.TEXT_BUTTON_LG_SIZE);
			_stopButton = new StandardButton(stopClicked, DrawSpecs.BUTTON_RUN_WIDTH, DrawSpecs.BUTTON_RUN_HEIGHT, "Stop", DrawSpecs.TEXT_BUTTON_LG_SIZE,
			                                 DrawSpecs.BUTTON_STOP_BACKGROUND, DrawSpecs.BUTTON_STOP_HOVER_BACKGROUND);
			_resetButton = new StandardButton(resetClicked, DrawSpecs.BUTTON_RESET_WIDTH, DrawSpecs.BUTTON_RESET_HEIGHT, "Reset", DrawSpecs.TEXT_BUTTON_SIZE);
			_resetButton.y = DrawSpecs.BUTTON_RESET_Y;
			_stopButton.visible = false;
			this.addChild(_stopButton);
			this.addChild(_runButton);
			this.addChild(_resetButton);
		}
		
		public function startLevel():void {
			_runButton.activate();
			_stopButton.deactivate();
			_stopButton.visible = false;
			_runButton.visible = true;
			_resetButton.activate();
		}
		
		private function runClicked(__b:Button):void {
		/*  Run flow
		 *  Deactivate run btton
		 *  make run btn invis
		 *  make stop btn vis
		 *  activate stop btn
		 *  proceed to watch chaos.
		 */
			_runButton.deactivate();
			_runButton.visible = false;
			_stopButton.visible = true;
			_stopButton.activate();
			
			_resetButton.deactivate();
			
			Main.aquarithmetic.engine.runFlow();
		}
		private function stopClicked(__b:Button):void {
			_stopButton.deactivate();
			_stopButton.visible = false;
			_runButton.visible = true;
			_runButton.activate();
			_resetButton.activate();
			// !TODO stop thingy
			Main.aquarithmetic.engine.stopFromButton();
		}
		
		private function resetClicked(__b:Button):void {
			Main.aquarithmetic.engine.resetLevel();
		}
	}
}