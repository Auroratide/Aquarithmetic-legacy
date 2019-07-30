package {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	
	public class PumpElement extends Sprite {
		public static const SPEED_STANDARD:Number = 1.5;
		private var _myParent:Edge;
		
		private var _inPoint:Point;
		private var _outPoint:Point;
		
		protected var _speed:Number;
		private var _count:Number;
		
		public function PumpElement(__edge:Edge, __inNode:Node, __outNode:Node) {
			_myParent = __edge;
			
			_inPoint = new Point(__inNode.x, __inNode.y);
			_outPoint = new Point(__outNode.x, __outNode.y);
			
			_speed = SPEED_STANDARD / Point.distance(_inPoint, _outPoint);;
			_count = 1.0;
			
			this.x = __inNode.x;
			this.y = __inNode.y;
			
			draw();
			
			this.addEventListener(Event.ENTER_FRAME, idleMove);
		}
		
		protected function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(DrawSpecs.EDGE_COLOR);
			this.graphics.drawCircle(0, 0, DrawSpecs.EDGE_WIDTH);
			this.graphics.endFill();
		}
		
		private function idleMove(__e:Event):void {
			var p:Point = Point.interpolate(_inPoint, _outPoint, _count);
			x = p.x;
			y = p.y;
			_count -= _speed;
			if (_count < 0) {
				_myParent.removeChild(this);
				this.removeEventListener(Event.ENTER_FRAME, idleMove);
			}
		}
	}
}