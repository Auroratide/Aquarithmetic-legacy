package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.text.Font;
	
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	import items.*;

	/**
	 * ...
	 * @author Ardeol
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite {
		
		public static var aquarithmetic:Aquarithmetic;
		
		[Embed(source = "../lib/SnigletExtraBold.otf",
			   fontName = "SnigletExtraBold",
			   embedAsCFF = "false")]
		private static const SnigletExtraBold:Class;
		
		/* */
		[Embed(source = "../lib/Pamgaea.mp3")]
		private static const Pamgaea:Class;
		private var music:Sound;
		/*  */

		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			aquarithmetic = new Aquarithmetic();
			this.addChild(aquarithmetic);
			
			/*   */
			music = new Pamgaea();
			music.play(0, 999);
			/*  */
		}

		public static function font():Font {  return new SnigletExtraBold(); }
		public static function fontFormat(_size:Object = 24):TextFormat {
			return new TextFormat(font().fontName, _size);
		}
		
		public static function field(__size:Object = 0):TextField {
			var t:TextField = new TextField();
			t.selectable = false;
			t.embedFonts = true;
			t.defaultTextFormat = new TextFormat(Main.font().fontName, __size, DrawSpecs.TEXT_COLOR,
			                                               null, null, null, null, null, TextFormatAlign.CENTER);
			return t;
		}
	}

}