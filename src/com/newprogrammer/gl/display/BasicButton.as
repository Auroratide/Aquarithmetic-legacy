package com.newprogrammer.gl.display {
	import com.newprogrammer.gl.IButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BasicButton extends Sprite implements IButton {
		public static const BLANK_FUNCTION:Function = function(b:BasicButton):void { };
		
		protected var _isActive:Boolean;
		
		public var action:Function;
		
		public function BasicButton(_action:Function) {
			this.action = _action;
			this._isActive = true;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			if(_isActive) activate();
		}
		
		/*  Access Methods
		========================================================*/
		public function get isActive():Boolean {  return _isActive; }
		
		/*  Implementation
		========================================================*/
		public function onHover(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OVER, onHover);
			this.addEventListener(MouseEvent.MOUSE_OUT, outHover);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
		}
		public function outHover(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHover);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onPress);
			this.addEventListener(MouseEvent.MOUSE_OVER, onHover);
		}
		public function onPress(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onPress);
			this.addEventListener(MouseEvent.MOUSE_UP, onRelease);
		}
		public function onRelease(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_UP, onRelease);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
			action(this);
		}
		public function activate():void {
			_isActive = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, onHover);
		}
		public function deactivate():void {
			_isActive = false;
			this.removeEventListener(MouseEvent.MOUSE_OVER, onHover);
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHover);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onPress);
			this.removeEventListener(MouseEvent.MOUSE_UP, onRelease);
		}
		public function toggleActivation():Boolean {
		//  Not part of the actual interface but has similar functionality
		//  Returns new state of the Button
			if (_isActive) deactivate();
			else activate();
			return _isActive;
		}
	}
}