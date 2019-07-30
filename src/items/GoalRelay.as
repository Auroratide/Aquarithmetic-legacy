package items {
	import flash.text.TextField;
	public class GoalRelay extends BasicRelay {
		private var _goalState:int;
		
		private var _goalField:TextField;
		
		public function GoalRelay(__restState:int = 0, __goalState:int = 1) {
			super(__restState);
			_goalState = __goalState;
			
			_goalField = Main.field(DrawSpecs.TEXT_NODE_SIZE);
			_goalField.width = DrawSpecs.NODE_WIDTH;
			_goalField.x = -DrawSpecs.NODE_WIDTH / 2;
			_goalField.y = DrawSpecs.NODE_GOAL_OFFSET;
			_goalField.text = _goalState.toString();
			
			this.addChild(_goalField);
			draw();
		}
		
		override protected function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(DrawSpecs.FIELD_WINDOW_BACKGROUND);
			this.graphics.lineStyle(DrawSpecs.NODE_BORDER_THICKNESS, DrawSpecs.NODE_BORDER_COLOR);
			var w:Number = DrawSpecs.NODE_WIDTH;
			this.graphics.drawRect( -w / 2, -w / 2, w, w);
			this.graphics.endFill();
		}
		override protected function fieldOffset():Number {
			return DrawSpecs.NODE_GOAL_OFFSET;
		}
		
		override public function isSatisfied():Boolean {
			return _goalState == activeState;
		}
	}
}