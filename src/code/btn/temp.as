package code.btn {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class temp extends MovieClip {
		public var _state:int;
		
		public function temp() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
			this.addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
			
			addFrameScript(10,playState);
		}
		private function playState() {
			if (_state == 0) {
				this.play();
			}else {
				this.stop();
			}
		}
		private function onRollHandle(e:Event):void 
		{
			switch(e.type) {
				case "rollOut":
					_state = 0;	
					this.play();
					break;
				case "rollOver":
					_state = 1;
					this.play();
					break;
			}
		}
	}
	
}
