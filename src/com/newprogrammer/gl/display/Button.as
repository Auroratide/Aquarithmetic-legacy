package com.newprogrammer.gl.display {
	import flash.events.MouseEvent;
	
	public class Button extends BasicButton {
		public var onHoverAction:Function;
		public var outHoverAction:Function;
		public var onPressAction:Function;
		
		public var onActivateAction:Function;
		public var onDeactivateAction:Function;
		
		public function Button(_action:Function) {
			super(_action);
			
			onHoverAction = BLANK_FUNCTION;
			outHoverAction = BLANK_FUNCTION;
			onPressAction = BLANK_FUNCTION;
			
			onActivateAction = BLANK_FUNCTION;
			onDeactivateAction = BLANK_FUNCTION;
		}
		
		public function get onReleaseAction():Function {
		//  Provided merely for syntactic similarity
			return action;
		}
		public function set onReleaseAction(value:Function):void {
			action = value;
		}
		
		/*  Overriding BasicButton
		================================================*/
		override public function onHover(e:MouseEvent):void {
			super.onHover(e);
			onHoverAction(this);
		}
		override public function outHover(e:MouseEvent):void {
			super.outHover(e);
			outHoverAction(this);
		}
		override public function onPress(e:MouseEvent):void {
			super.onPress(e);
			onPressAction(this);
		}
		override public function activate():void {
			super.activate();
			onActivateAction(this);
		}
		override public function deactivate():void {
			super.deactivate();
			onDeactivateAction(this);
		}
	}
}