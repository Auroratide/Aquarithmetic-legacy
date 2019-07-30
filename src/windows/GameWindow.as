package windows{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class GameWindow extends Sprite {
		/** !TODO
		 * field window
		 * item window
		 * menu window
		 * out window
		 */
		
		private var _titleField:TextField;
		private var _fieldWindow:FieldWindow;
		private var _itemWindow:ItemWindow;
		private var _gameOptionsWindow:GameOptionsWindow;
		private var _popupWindow:PopUpWindow;
		
		public function GameWindow() {
			_titleField = new TextField();
			_titleField.selectable = false;
			_titleField.embedFonts = true;
			_titleField.defaultTextFormat = new TextFormat(Main.font().fontName, DrawSpecs.TEXT_TITLE_SIZE, DrawSpecs.TEXT_COLOR,
			                                               null, null, null, null, null, TextFormatAlign.CENTER);
			_titleField.width = DrawSpecs.FIELD_WINDOW_WIDTH;
			_titleField.x = DrawSpecs.FIELD_WINDOW_X;
			_titleField.text = "Test!";
			
			_fieldWindow = new FieldWindow();
			_fieldWindow.x = DrawSpecs.FIELD_WINDOW_X;
			_fieldWindow.y = DrawSpecs.FIELD_WINDOW_Y;
			
			_itemWindow = new ItemWindow();
			_itemWindow.x = DrawSpecs.ITEM_WINDOW_X;
			_itemWindow.y = DrawSpecs.ITEM_WINDOW_Y;
			
			_gameOptionsWindow = new GameOptionsWindow();
			_gameOptionsWindow.x = DrawSpecs.GAME_OPTIONS_WINDOW_X;
			_gameOptionsWindow.y = DrawSpecs.GAME_OPTIONS_WINDOW_Y;
			
			_popupWindow = new PopUpWindow();
			
			this.addChild(_titleField);
			this.addChild(_fieldWindow);
			this.addChild(_itemWindow);
			this.addChild(_gameOptionsWindow);
			this.addChild(_popupWindow);
			hideWinScreen();
		}
		
	//  Got tired of dumb functions doing dumb things
		public function get fieldWindow():FieldWindow {  return _fieldWindow; }
		
		public function setTitle(__title:String):void {
			_titleField.text = __title;
		}
		public function addNodeToField(__node:Node):void {
			_fieldWindow.addNode(__node);
		}
		public function addEdgeToField(__edge:Edge):void {
			_fieldWindow.addEdge(__edge);
		}
		public function removeNode(__node:Node):void {
			_fieldWindow.removeNode(__node);
		}
		public function removeEdge(__edge:Edge):void {
			_fieldWindow.removeEdge(__edge);
		}
		public function addToField(__obj:DisplayObject):void {
			_fieldWindow.addChild(__obj);
		}
		
	//  Yes, I know the below is really dumb, lol.
		public function parseItemAvailability(__items:Object):void {
			_itemWindow.parseItemAvailability(__items);
		}
		public function activateItems():void {
			_itemWindow.activateItems();
		}
		public function deactivateItems():void {
			_itemWindow.deactivateItems();
		}
		public function decrementItem(__item:String):Boolean {
			return _itemWindow.decrementItem(__item);
		}
		
		public function startLevel():void {
			_gameOptionsWindow.startLevel();
		}
		
		public function showWinScreen():void {
			_popupWindow.visible = true;
		}
		public function hideWinScreen():void {
			_popupWindow.visible = false;
		}
	}
}