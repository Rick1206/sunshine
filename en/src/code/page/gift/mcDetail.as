package code.page.gift
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
		private var _gid:String;
		private var _type:String;
		private var _urlreq:URLRequest;
		private var _urlvar:URLVariables;
		public var _urlloa:URLLoader;
		
		private var _xmlUrl:String = "xml/gift_detail.xml";
		
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
			TweenMax.to(gFrame, .5, {x: "-100", autoAlpha: 0, onComplete: function()
				{
					gFrame.clear();
					var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + _xmlUrl + GlobalVars.getVer(), onLoadedHandler);
					TweenMax.to(gFrame, .5, {x: "-100", autoAlpha: 1, onInit: function()
						{
							gFrame.x += 200;
						}});
				
				}});
		}
		
		private function onLPageHandler(e:MouseEvent):void
		{
			TweenMax.to(gFrame, .5, {x: "100", autoAlpha: 0, onComplete: function()
				{
					gFrame.clear();
					var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + _xmlUrl + GlobalVars.getVer(), onLoadedHandler);
					TweenMax.to(gFrame, .5, {x: "100", autoAlpha: 1, onInit: function()
						{
							gFrame.x -= 200;
						}});
				
				}});
		}
		
		private function onBackHandler(e:MouseEvent):void
		{
			TweenMax.to(this, .3, {autoAlpha: 0});
			this.dispatchEvent(new Event("back"));
		}
		
		public function loadInfo(gid:String, type:String):void
		{
			_gid = gid;
			_type = type;
			//trace(_gid);
			loadXml(_gid, _type);
		}
		
		public function loadXml(gid:String, gtype:String):void
		{
			//t//race(gid);
			
			_urlvar = new URLVariables();
			_urlreq = new URLRequest();
			_urlloa = new URLLoader();
			
			_urlvar.fun_type = "gift";
			_urlvar.giftype = gtype;
			_urlvar.gid = gid;
			
			_urlloa.addEventListener(Event.COMPLETE, onProDetailCompInfoHandle);
			_urlloa.addEventListener(IOErrorEvent.IO_ERROR, onProDetailErrorHandler);
			_urlreq.data = _urlvar;
			_urlreq.url = GlobalVars.WEBHOST;
			
			_urlloa.dataFormat = URLLoaderDataFormat.BINARY;
			_urlloa.load(_urlreq);
		
		}
		
		private function onProDetailErrorHandler(e:Event):void
		{
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + _xmlUrl + GlobalVars.getVer(), onLoadedHandler);
		}
		
		private function onLoadedHandler(e:Event):void
		{
			var _xmlDate:XML = e.target.xml;
			gFrame.loadXml(_xmlDate,int(_gid));
		
		}
		
		private function onProDetailCompInfoHandle(e:Event):void
		{
			//trace("complete");
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + _xmlUrl + GlobalVars.getVer(), onLoadedHandler);

		}
	
	}

}
