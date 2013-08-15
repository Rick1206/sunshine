package code.page {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class about extends MovieClip {
		
		
		public function about() {
			
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//trace(3);
			
		}
	}
	
}
