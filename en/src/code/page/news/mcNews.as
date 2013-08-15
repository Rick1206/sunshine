package code.page.news {
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	import com.greensock.TweenMax;
	import code.events.NChangeEvent;
	import code.GlobalVars;
	public class mcNews extends MovieClip {
		private var _nid:String;
		private var _imgurl:String;
		public function mcNews() {
			
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
			nBg.visible = false;
			nBg.alpha = 0;
			
			this.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
		}
		
		public function loadInfo(title:String, imgurl:String, time:String,newsid:String):void {
		
			txtTitle.text = title;
			txtTime.text = time;
			_nid = newsid;
			_imgurl = imgurl;
			
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
			RollTool.setRoll(this);
			
			
			var imgLoader:ImageLoader =  new ImageLoader(GlobalVars.getPath() +
														 _imgurl + 
														 GlobalVars.getVer()
														, { onComplete:onImgLoaderHandler } );
			imgLoader.load();
		}
		
		private function onImgLoaderHandler(event:LoaderEvent):void 
		{
			 var myBitmap:Bitmap = event.target.rawContent as Bitmap;
			 addChild(myBitmap);
		}
		
		private function onRollHandler(e:MouseEvent):void 
		{
			switch(e.type) {
				case "rollOver":
					TweenMax.to(nBg, .3, { autoAlpha:.2} );
					break;
				case "rollOut":
					TweenMax.to(nBg, .3, { autoAlpha:0} );
					break;
			}
		}
		
		private function onClickHandler(e:MouseEvent):void 
		{
			var myEvent:NChangeEvent = new NChangeEvent("CHANGE");
			myEvent.nid = _nid;
			this.dispatchEvent(myEvent);
		}
	}
	
}
