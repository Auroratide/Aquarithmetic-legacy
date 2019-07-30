package items {
	import com.newprogrammer.gl.display.Button;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	public class ItemButton extends Button {
		private var _itemImage:Sprite; // Node or Edge, I suppose
		private var _inventoryField:TextField;
		
	//  Data used in the game
		private var _available:Boolean; // can it be used
		private var _maxInventory:int;  // max possible, if I implement erasing...
		private var _inventory:int; // number you have to use
		
		public function ItemButton(__action:Function, __itemImage:Sprite) {
			super(__action);
			_itemImage = __itemImage;
			_inventoryField = Main.field(DrawSpecs.TEXT_BUTTON_SIZE);
			_inventoryField.width = DrawSpecs.ITEM_BUTTON_WIDTH;
			_inventoryField.defaultTextFormat.align = TextFormatAlign.RIGHT;
			_inventoryField.text = "0";
			
			makeUnavailable();
			_inventory = 0;
			
			draw();
			
			_itemImage.alpha = DrawSpecs.ITEM_BUTTON_ITEM_ALPHA;
			this.addChild(_itemImage);
			this.addChild(_inventoryField);
		}
		
		public function get available():Boolean {  return _available; }
		public function empty():Boolean {  return _inventory <= 0; }
		public function decrementInventory(__n:int = 1):Boolean {
			_inventory -= __n;
			if (_inventory <= 0) {
				_inventory = 0;
				deactivate();
				updateInventoryField();
				return false;
			}
			updateInventoryField();
			return true;
		}
		public function incrementInventory(__n:int = 1):void {
			_inventory += __n;
			if (_inventory > _maxInventory)
				_inventory = _maxInventory;
			updateInventoryField();
		}
		
		public function draw():void {
			this.graphics.clear();
			this.graphics.lineStyle(DrawSpecs.GENERAL_BORDER_WIDTH, DrawSpecs.GENERAL_BORDER_COLOR);
			this.graphics.beginFill(DrawSpecs.ITEM_BUTTON_BACKGROUND);
			this.graphics.drawRect(0, 0, DrawSpecs.ITEM_BUTTON_WIDTH, DrawSpecs.ITEM_BUTTON_HEIGHT);
			this.graphics.endFill();
		}
		
		public function makeUnavailable():void {
			_available = false;
			_itemImage.visible = false;
			_inventoryField.visible = false;
			deactivate();
		}
		public function makeAvailable():void {
			_available = true;
			_itemImage.visible = true;
			_inventoryField.visible = true;
			//activate();
		}
		public function setItemInventory(__n:int):void {
			_maxInventory = __n;
			_inventory = __n;
			if (__n <= 0)
				makeUnavailable();
			else
				makeAvailable();
			updateInventoryField();
		}
		public function updateInventoryField():void {
			if (_inventory > 20)
				_inventoryField.text = "";
			else
				_inventoryField.text = _inventory.toString();
		}
	}
}