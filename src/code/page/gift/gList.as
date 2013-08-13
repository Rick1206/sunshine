package code.page.gift {
	
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import flash.events.Event;
	
	public class gList extends MovieClip {
		
		
		public function gList() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			btnNext.alpha = 0;
			btnLast.alpha = 0;
			
		}
		public function hideBtn():void {
			TweenLite.to(btnNext, .3, { alpha:0 } );
			TweenLite.to(btnLast, .3, { alpha:0 } );
		}
		
		public function showBtn():void {
			TweenLite.to(btnNext, .3, { alpha:1 } );
			TweenLite.to(btnLast, .3, { alpha:1 } );
		}
	}
	
}
