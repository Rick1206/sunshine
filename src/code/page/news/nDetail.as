package code.page.news
{
	
	import com.greensock.loading.ImageLoader;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import code.tool.LoadXml;
	import code.GlobalVars;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	import code.tool.RollTool;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import code.tool.ScrollBar;
	import flash.events.IOErrorEvent;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class nDetail extends MovieClip
	{
		
		private var _imgurl:String;
		
		private var _urlreq:URLRequest;
		
		private var _urlvar:URLVariables;
		
		public var _urlloa:URLLoader;
		
		private var Masked:Sprite;
		
		private var curTxt:TextField; 
		
		public function nDetail()
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
		
		public function loadInfo(nid:String):void
		{
			
			_urlvar = new URLVariables();
			_urlreq = new URLRequest();
			_urlloa = new URLLoader();
			
			_urlvar.fun_type = "News";
			_urlvar.newsid = nid;
			
			_urlloa.addEventListener(Event.COMPLETE, onNewsDetailCompInfoHandle);
			_urlloa.addEventListener(IOErrorEvent.IO_ERROR, onNewsDetailErrorHandler);
			_urlreq.data = _urlvar;
			_urlreq.url = GlobalVars.WEBHOST;
			
			_urlloa.dataFormat = URLLoaderDataFormat.BINARY;
			_urlloa.load(_urlreq);
			
			btnBack.addEventListener(MouseEvent.CLICK, onBackHandler);
			
			RollTool.setRoll(btnBack);
		}
		
		private function onNewsDetailErrorHandler(e:Event):void
		{
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/news_detail.xml" + GlobalVars.getVer(), onLoadedHandler);

		}
		
		private function onNewsDetailCompInfoHandle(e:Event):void
		{
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/news_detail.xml" + GlobalVars.getVer(), onLoadedHandler);

		}
		
		private function onBackHandler(e:MouseEvent):void
		{
			TweenMax.to(this, .3, {autoAlpha: 0});
			this.dispatchEvent(new Event("back"));
			
			if (Masked != null) {
				Masked.removeChild(curTxt);
			}
			
			Masked = null;
		}
		
		private function onLoadedHandler(e:Event):void
		{
			
			if (Masked != null) {
				Masked.removeChild(curTxt);
			}
			
			var _xmlDate:XML = e.target.xml;
			
			_imgurl = _xmlDate.news[0].img;
			
			txtTitle.text = _xmlDate.news[0].title;
			txtTime.text = _xmlDate.news[0].time;
			//txtDes.text = _xmlDate.news[0].description;
			
			var imgLoader:ImageLoader = new ImageLoader(GlobalVars.getPath() + _imgurl + GlobalVars.getVer(), {onComplete: onImgLoaderHandler});
			imgLoader.load();
			
			Masked = new Sprite();
			Masked.x = 504;
			Masked.y = 208;
			
			curTxt = new TextField;
			curTxt.text = _xmlDate.news[0].description;
			
			var txtFormat:TextFormat = new TextFormat;
			txtFormat.size = 14;
			curTxt.setTextFormat(txtFormat);
			
			curTxt.autoSize = TextFieldAutoSize.NONE;
			curTxt.width = 280;
			curTxt.multiline = true;
			curTxt.wordWrap = true;
			curTxt.textColor = 0x99783F;
			curTxt.height = curTxt.textHeight+20;
			
			Masked.addChild(curTxt);
			
			addChild(Masked);
			
			
			var myScroll:ScrollBar = new ScrollBar(Masked, Mask, slider, scroll_bg);
			
			myScroll.direction = "L";
			
			myScroll.tween = 5;
			
			myScroll.elastic = false;
			
			myScroll.lineAbleClick = true;
			
			myScroll.mouseWheel = true;
			
			myScroll.UP = upControl;
			
			myScroll.DOWN = downControl;
			
			myScroll.stepNumber = 15;
			
			myScroll.refresh();
		}
		
		private function onImgLoaderHandler(e:LoaderEvent):void
		{
			var myBitmap:Bitmap = e.target.rawContent as Bitmap;
			myBitmap.y = 167;
			myBitmap.x = 200;
			addChild(myBitmap);
		
		}
	
	}

}
