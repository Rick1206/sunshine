package code.page.brand
{
	import code.products.mpro;
	import flash.display.MovieClip;
	import code.products.brandNut;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import code.tool.RollTool;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import code.products.mpro;
	import code.products.brandNut;
	
	import code.GlobalVars;
	import flash.net.URLLoaderDataFormat;
	
	import code.tool.LoadXml;
	
	public class mcDetail extends MovieClip
	{
		private var _data:String;
		private var _urlreq:URLRequest;
		private var _urlvar:URLVariables;
		public var _urlloa:URLLoader;
		
		public function mcDetail()
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
			btnBack.addEventListener(MouseEvent.CLICK, onBackHandler);
			RollTool.setRoll(btnBack);
			
			btnLast.addEventListener(MouseEvent.CLICK, onLPageHandler);
			btnNext.addEventListener(MouseEvent.CLICK, onNPageHandler);
			
			RollTool.setRoll(btnLast);
			RollTool.setRoll(btnNext);
		
		}
		
		private function onNPageHandler(e:MouseEvent):void
		{
			TweenMax.to(dFrame, .5, {x: "-100", autoAlpha: 0, onComplete: function()
				{
					dFrame.clear();
					var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/product_detail.xml" + GlobalVars.getVer(), onLoadedHandler);
					TweenMax.to(dFrame, .5, {x: "-100", autoAlpha: 1, onInit: function()
						{
							dFrame.x += 200;
						}});
				
				}});
		}
		
		private function onLPageHandler(e:MouseEvent):void
		{
			TweenMax.to(dFrame, .5, {x: "100", autoAlpha: 0, onComplete: function()
				{
					dFrame.clear();
					var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/product_detail.xml" + GlobalVars.getVer(), onLoadedHandler);
					TweenMax.to(dFrame, .5, {x: "100", autoAlpha: 1, onInit: function()
						{
							dFrame.x -= 200;
						}});
				
				}});
		}
		
		private function onBackHandler(e:MouseEvent):void
		{
			TweenMax.to(this, .3, {autoAlpha: 0});
			this.dispatchEvent(new Event("back"));
		}
		
		public function loadInfo(data:String):void
		{
			_data = data;
			loadXml(_data);
		}
		
		public function loadXml(ptype:String):void
		{
			
			_urlvar = new URLVariables();
			_urlreq = new URLRequest();
			_urlloa = new URLLoader();
			
			_urlvar.fun_type = "Products";
			_urlvar.protype = ptype;
			
			_urlloa.addEventListener(Event.COMPLETE, onProDetailCompInfoHandle);
			_urlloa.addEventListener(IOErrorEvent.IO_ERROR, onProDetailErrorHandler);
			_urlreq.data = _urlvar;
			_urlreq.url = GlobalVars.WEBHOST;
			
			_urlloa.dataFormat = URLLoaderDataFormat.BINARY;
			_urlloa.load(_urlreq);
		
		}
		
		private function onProDetailErrorHandler(e:Event):void
		{
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/product_detail.xml" + GlobalVars.getVer(), onLoadedHandler);
		}
		
		private function onLoadedHandler(e:Event):void
		{
			var _xmlDate:XML = e.target.xml;
			
			dFrame.loadXml(_xmlDate);
		
		}
		
		private function onProDetailCompInfoHandle(e:Event):void
		{
			trace("complete");
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/product_detail.xml" + GlobalVars.getVer(), onLoadedHandler);
		}
	
	}

}
