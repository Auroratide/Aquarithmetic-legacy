package com.newprogrammer.gl {
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	public interface IButton extends IEventDispatcher{
		function get isActive():Boolean;
		
		function onHover(e:MouseEvent):void;
		function outHover(e:MouseEvent):void;
		function onPress(e:MouseEvent):void;
		function onRelease(e:MouseEvent):void;
		
		function activate():void;
		function deactivate():void;
	}
}