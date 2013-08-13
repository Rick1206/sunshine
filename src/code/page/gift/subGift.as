package code.page.gift {
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import code.tool.RollTool;
	
	import code.tool.Reflection;
	
	import code.GlobalVars;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.TweenLite;

	
	public class subGift extends MovieClip {
		
		private var myBitmap:Bitmap;
		private var scImg:Sprite;
		private var subThumbnail:Sprite;
		private var _thumbNail:String;
		
		public function subGift() {
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
		public function loadInfo(title:String,weight:String,imgUrl:String,thumbNail:String=null):void {
			
			txtTitle.text = title;
			txtWeight.text = weight;
			_thumbNail =  thumbNail;
			
			var imgLoader:ImageLoader = new ImageLoader(GlobalVars.getPath() + imgUrl + GlobalVars.getVer(), {onComplete: onImgLoaderHandler});
			imgLoader.load();
			
			
		}
		
		private function onImgLoaderHandler(e:LoaderEvent):void 
		{
			myBitmap = e.target.rawContent as Bitmap;
			myBitmap.smoothing = true;
			
			scImg = new Sprite();
			
			scImg.addChild(myBitmap);
			
			
			scImg.x = - scImg.width / 2;
			addChild(scImg);
			scImg.alpha = 0;
			
		    TweenLite.to(scImg, .3, { alpha:1 } );
			
			//trace(_thumbNail);
			var imgLoader:ImageLoader = new ImageLoader(GlobalVars.getPath() + _thumbNail + GlobalVars.getVer(), {onComplete: onSubImgHandler});
			
			imgLoader.load();
			
		}
		private function onSubImgHandler(e:LoaderEvent):void 
		{
			myBitmap = e.target.rawContent as Bitmap;
			myBitmap.smoothing = true;
			
			subThumbnail = new Sprite;
			subThumbnail.addChild(myBitmap);
			addChild(subThumbnail);
			
			subThumbnail.alpha = 0;
			
			subThumbnail.y = - scImg.height / 2 - 10;
			subThumbnail.x = - subThumbnail.width / 2;
			
			scImg.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			scImg.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			

		}
		
		private function onRollHandler(e:MouseEvent):void 
		{
				switch(e.type) {
					case "rollOver":
							//trace(3);
						   TweenLite.to(subThumbnail, .3, { alpha:1 } );
						break;
					case "rollOut":
						   TweenLite.to(subThumbnail, .3, { alpha:0 } );
						break;
				}
		}
	}
	
}
