package code.page.brand
{
	
	import code.tool.LoadXml;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import flash.net.navigateToURL;
	import code.tool.RollTool;
	
	import code.tool.Reflection;
	
	import code.GlobalVars;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	
	public class subProDetail extends MovieClip
	{
		private var _link:String;
		
		public function subProDetail()
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
			
			RollTool.setRoll(btnUrl);
		}
		
		public function loadInfo(title:String, weight:String, link:String, imgUrl:String):void
		{
			
			txtTitle.text = title;
			txtWeight.text = weight;
			_link = link;
			btnUrl.addEventListener(MouseEvent.CLICK, onUrlHandler);
			var imgLoader:ImageLoader = new ImageLoader(GlobalVars.getPath() + imgUrl + GlobalVars.getVer(), {onComplete: onImgLoaderHandler});
			imgLoader.load();
		
		}
		
		private function onImgLoaderHandler(e:LoaderEvent):void
		{
			var myBitmap:Bitmap = e.target.rawContent as Bitmap;
			myBitmap.smoothing = true;
			var reflection:Reflection = new Reflection(myBitmap, -20, 80);
			reflection.x = -reflection.width / 2;
			addChild(reflection);
			setChildIndex(reflection, 0);
		}
		
		private function onUrlHandler(e:MouseEvent):void
		{
			
			navigateToURL(new URLRequest(_link), "_blank");
		}
	}

}
