package code.page.time
{
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import code.products.mpro;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import com.greensock.loading.ImageLoader;
	import com.greensock.events.LoaderEvent;
	import code.tool.Reflection;
	
	public class mcProduct extends MovieClip
	{
		private var _mp:mpro;
		private var _reflection:Reflection;
		
		public function mcProduct()
		{
			
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function loadInfo(type:String, title:String, link:String, img:String):void
		{
			
			_mp = new mpro(type, title, "", link, img);
			
			btnBuy.addEventListener(MouseEvent.CLICK, onGotoEcshopHandler);
			
			RollTool.setRoll(btnBuy);
			
			var loader:ImageLoader = new ImageLoader(_mp.imgurl, {onComplete: onImageLoad});
			
			loader.load();
		}
		
		private function onGotoEcshopHandler(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(_mp.link), "_blank");
		}
		
		private function onImageLoad(event:LoaderEvent):void
		{
			
			var bitmap:Bitmap = event.currentTarget.rawContent as Bitmap;
			bitmap.smoothing = true;
			_reflection = new Reflection(bitmap, -20, 80);
			
			_reflection.x = -_reflection.width / 2;
			_reflection.y = -_reflection.height / 2;
			
			addChild(_reflection);
			btnBuy.y = bitmap.height / 4;
			this.dispatchEvent(new Event("imgLoaded"));
			
			this.setChildIndex(btnBuy, 1);
		
		}
	}

}
