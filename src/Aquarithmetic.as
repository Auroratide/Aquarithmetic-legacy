package {
	import flash.display.Sprite;
	import flash.events.Event;
	import windows.GameWindow;
	public class Aquarithmetic extends Sprite {
	//  This is THE primary window of all windowiness
	//  Currently: this is the ENGINE
		/** !TODO
		 * game engine??? Aquarithmetic can itself be the engine!!
		 * game window
		 * menu window
		 * menu window secondary (for animation)
		 * shared object junk
		 */
		
		private var _gameWindow:GameWindow;
		private var _engine:GameEngine;
		
		public function Aquarithmetic() {
			init();
		}
		private function init(__e:Event = null):void {
			_gameWindow = new GameWindow();
			_engine = new GameEngine(_gameWindow);
			
			this.addChild(_gameWindow);
			
			// !TEST
			_engine.load(Levels.T01);
		}
		
		public function get engine():GameEngine {
			return _engine;
		}
	}
}