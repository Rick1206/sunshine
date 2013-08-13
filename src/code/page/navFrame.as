package code.page {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import code.page.nav;
	
	public class navFrame extends MovieClip {
		
		
		public function navFrame() {
			if (stage)
			{
				initAll();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initAll);
			}
		}
		
		private function initAll(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
			
			//addChild(nav.getInstance());
		}
	}
	
}
