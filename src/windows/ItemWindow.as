package windows {
	import com.newprogrammer.gl.display.Button;
	import flash.display.Sprite;
	import items.*;
	
	public class ItemWindow extends Sprite {
		private var basicLine:ItemButton;
		private var breakLine:ItemButton;
		private var basicRelay:ItemButton;
		private var multiplyRelay:ItemButton;
		
		private var allButtons:Vector.<ItemButton>;
		
		public function ItemWindow() {
			allButtons = new Vector.<ItemButton>();
			this.addChild(initBasicLine());
			this.addChild(initBreakLine());
			this.addChild(initBasicRelay());
			this.addChild(initMultiplyRelay());
			positionButtons();
		}
		
		private function initBasicLine():ItemButton {
			var n1:Node = new Node();
			n1.x = DrawSpecs.ITEM_BUTTON_EDGE_X1;
			n1.y = DrawSpecs.ITEM_BUTTON_EDGE_Y1;
			var n2:Node = new Node();
			n2.x = DrawSpecs.ITEM_BUTTON_EDGE_X2;
			n2.y = DrawSpecs.ITEM_BUTTON_EDGE_Y2;
			var basicLineSprite:Edge = new BasicLine(n1, n2);
			basicLine = new ItemButton(basicLineSelected, basicLineSprite);
			allButtons.push(basicLine);
			return basicLine;
		}
		private function initBreakLine():ItemButton {
			var n1:Node = new Node();
			n1.x = DrawSpecs.ITEM_BUTTON_EDGE_X1;
			n1.y = DrawSpecs.ITEM_BUTTON_EDGE_Y1;
			var n2:Node = new Node();
			n2.x = DrawSpecs.ITEM_BUTTON_EDGE_X2;
			n2.y = DrawSpecs.ITEM_BUTTON_EDGE_Y2;
			var breakLineSprite:Edge = new BreakLine(n1, n2);
			breakLine = new ItemButton(breakLineSelected, breakLineSprite);
			allButtons.push(breakLine);
			return breakLine;
		}
		private function initBasicRelay():ItemButton {
			var n:Node = new BasicRelay(-1);
			n.x = DrawSpecs.ITEM_BUTTON_WIDTH / 2;
			n.y = DrawSpecs.ITEM_BUTTON_WIDTH / 2;
			scaleItemSprite(n);
			basicRelay = new ItemButton(basicRelaySelected, n);
			allButtons.push(basicRelay);
			return basicRelay;
		}
		private function initMultiplyRelay():ItemButton {
			var n:Node = new MultiplyRelay( -1);
			n.x = DrawSpecs.ITEM_BUTTON_WIDTH / 2;
			n.y = DrawSpecs.ITEM_BUTTON_WIDTH / 2;
			scaleItemSprite(n);
			multiplyRelay = new ItemButton(multiplyRelaySelected, n);
			allButtons.push(multiplyRelay);
			return multiplyRelay;
		}
		private function scaleItemSprite(__sprite:Sprite):void {
			__sprite.scaleX = DrawSpecs.ITEM_BUTTON_SCALE;
			__sprite.scaleY = DrawSpecs.ITEM_BUTTON_SCALE;
		}
		
		private function anySelected(__b:Button = null):void {
			Main.aquarithmetic.engine.cancelPlayerEdit();
		}
		private function basicLineSelected(__b:Button):void {
			anySelected();
			Main.aquarithmetic.engine.prepareLineInNode(Edge.BASIC_LINE);
		}
		private function breakLineSelected(__b:Button):void {
			anySelected();
			Main.aquarithmetic.engine.prepareLineInNode(Edge.BREAK_LINE);
		}
		private function basicRelaySelected(__b:Button):void {
			anySelected();
			Main.aquarithmetic.engine.prepareNode(Node.BASIC_RELAY);
		}
		private function multiplyRelaySelected(__b:Button):void {
			anySelected();
			Main.aquarithmetic.engine.prepareNode(Node.MULTIPLY_RELAY);
		}
		
		private function positionButtons():void {
			for (var i:int = 0; i < allButtons.length; ++i) {
				allButtons[i].x = DrawSpecs.ITEM_BUTTON_WIDTH * (i % 2);
				allButtons[i].y = DrawSpecs.ITEM_BUTTON_WIDTH * Math.floor(i / 2);
			}
		}
		
		public function parseItemAvailability(__items:Object):void {
			basicLine.setItemInventory(__items.basicLine);
			basicRelay.setItemInventory(__items.basicRelay);
			multiplyRelay.setItemInventory(__items.multiplyRelay);
			breakLine.setItemInventory(__items.breakLine);
		}
		
		public function activateItems():void {
		//  Activate activatable items
			for (var i:int = 0; i < allButtons.length; ++i) {
				if (allButtons[i].available && !allButtons[i].empty())
					allButtons[i].activate();
			}
		}
		public function deactivateItems():void {
		//  Activate activatable items
			for (var i:int = 0; i < allButtons.length; ++i)
				allButtons[i].deactivate();
		}
		
		public function decrementItem(__item:String):Boolean {
			if (__item == Edge.BASIC_LINE)
				return basicLine.decrementInventory();
			else if (__item == Node.BASIC_RELAY)
				return basicRelay.decrementInventory();
			else if (__item == Node.MULTIPLY_RELAY)
				return multiplyRelay.decrementInventory();
			else if (__item == Edge.BREAK_LINE)
				return breakLine.decrementInventory();
			return false;
		}
	}
}