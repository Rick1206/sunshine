package code.page.gift
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
	
	public class subGiftDetail extends MovieClip
	{
		private var _link:String;
		private var _pos:int = -20;
		private var _hei:int = 80;
		
		public function subGiftDetail()
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
			var reflection:Reflection = new Reflection(myBitmap, _pos, _hei);
			
			reflection.x = -reflection.width / 2;
			addChild(reflection);
			setChildIndex(reflection, 0);
		}
		
		public function setPicRef(pos:int, hei:int):void
		{
			_pos = pos;
			_hei = hei;
		}
		
		private function onUrlHandler(e:MouseEvent):void
		{
			
			navigateToURL(new URLRequest(_link), "_blank");
		}
	}

}
