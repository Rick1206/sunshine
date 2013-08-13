package code.page.time {
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	//import 
	import com.greensock.TweenMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.events.LoaderEvent;
	
	public class mcDtime extends MovieClip {
		
		public function mcDtime() {
			// constructor code
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
			
			
		}
		public function loadInfo(link:String):void {
			var loader:ImageLoader = new ImageLoader(link, { onComplete:onImageLoad } );
			 loader.load();    
		}
		private function onImageLoad(event:LoaderEvent):void {
				//trace(3);
				
				//TweenLite.from(event.target.content, 1, { alpha:0 } );
				
				var bitmap:Bitmap =  event.target.rawContent as Bitmap;
				
				
				
				picLoader.addChild(bitmap);
				
				this.dispatchEvent(new Event("imgLoaded"));
				
		}
	}
	
}
