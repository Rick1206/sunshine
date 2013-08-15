package code.page.promotion {
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import com.greensock.loading.ImageLoader;
	import flash.display.Loader;
	import com.greensock.events.LoaderEvent;
	import code.tool.RollTool;
	import code.GlobalVars;
	
	public class mcPro extends MovieClip {
		
		private var _imgurl:String;
		private var _link:String;
		private var _loader:Loader;
		
		public function mcPro( ) {
			
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function loadInfo(imageUrl:String, imgLink:String):void {
			_imgurl = imageUrl;
			_link = imgLink;
			var imgLoader:ImageLoader =  new ImageLoader(GlobalVars.getPath() +
														 _imgurl + 
														 GlobalVars.getVer()
														, { onComplete:onImgLoaderHandler } );
			imgLoader.load();
		
		}
		private function onImgLoaderHandler(event:LoaderEvent):void {
			 //trace(event.target.rawContent);
			 var myBitmap:Bitmap = event.target.rawContent as Bitmap;
			 var sc:Sprite = new Sprite();
			 sc.addChild(myBitmap);
			 addChild(sc);
			 sc.addEventListener(MouseEvent.CLICK, onClickHandler);
			 RollTool.setRoll(sc);
		}
		private function loadPic():void {
			
		}
		private function onClickHandler(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest(_link), "_blank");
		}
		
	}
	
}

