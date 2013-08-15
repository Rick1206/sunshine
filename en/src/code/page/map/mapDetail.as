package code.page.map
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import code.tool.LoadXml;
	import code.GlobalVars;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	import code.tool.RollTool;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import code.tool.ScrollBar
	
	public class mapDetail extends MovieClip
	{
		
		private var _urlreq:URLRequest;
		
		private var _urlvar:URLVariables;
		
		public var _urlloa:URLLoader;
		
		private var storeArr:Array;
		
		private var pointArr:Array;
		
		private var Masked:Sprite;
		
		public function mapDetail()
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
			this.visible = false;
			this.alpha = 0;
			
			btnBack.addEventListener(MouseEvent.CLICK, onHideDetailHandle);
			
			RollTool.setRoll(btnBack);
		}
		
		private function onHideDetailHandle(e:MouseEvent):void
		{
			TweenMax.to(this, .3, {autoAlpha: 0, onComplete: function()
				{
					
					for (var key:String in storeArr)
					{
						
						removeChild(storeArr[key]);
						
					}
					
					storeArr = null;
					
					for (key in pointArr)
					{
						
						Masked.removeChild(pointArr[key]);
						
					}
					pointArr = null;
				}});
			this.dispatchEvent(new Event("back"));
		
		}
		
		public function loadInfo(area:String):void
		{
			
			_urlvar = new URLVariables();
			_urlreq = new URLRequest();
			_urlloa = new URLLoader();
			
			_urlvar.fun_type = "Store";
			_urlvar.area = area;
			
			_urlloa.addEventListener(Event.COMPLETE, onCompInfoHandle);
			_urlloa.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			_urlreq.data = _urlvar;
			_urlreq.url = GlobalVars.WEBHOST;
			
			_urlloa.dataFormat = URLLoaderDataFormat.BINARY;
			_urlloa.load(_urlreq);
		
		}
		
		private function onCompInfoHandle(e:Event):void
		{
			
			if (storeArr != null)
			{
				for (var key:String in storeArr)
				{
					removeChild(storeArr[key]);
				}
			}
			
			var _xmlDate:XML = XML(e.target.data);
			var num:int = _xmlDate.list.length();
			storeArr = new Array();
			for (var i:int = 0; i < num; i++)
			{
				
				var sc:mcStore = new mcStore();
				
				sc.x = 369;
				sc.y = 190 + i * 40;
				
				sc.txtTitle.text = _xmlDate.list[i].title;
				
				sc.sid = _xmlDate.list[i].store_id;
				
				sc.addEventListener(MouseEvent.CLICK, onClickHandle);
				
				if (i == 0)
				{
					sc.onSelect();
				}
				
				addChild(sc);
				
				storeArr.push(sc);
			}
			loadPoint(_xmlDate.list[0].store_id);
		
		}
		
		private function onErrorHandler(e:IOErrorEvent):void
		{
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/store.xml" + GlobalVars.getVer(), onLoadedHandler);
		}
		
		private function onLoadedHandler(e:Event):void
		{
			
			var _xmlDate:XML = e.target.xml;
			//trace(_xmlDate);
			var num:int = _xmlDate.list.length();
			storeArr = new Array();
			for (var i:int = 0; i < num; i++)
			{
				
				var sc:mcStore = new mcStore();
				
				sc.x = 369;
				sc.y = 190 + i * 40;
				
				sc.txtTitle.text = _xmlDate.list[i].title;
				
				sc.sid = _xmlDate.list[i].store_id;
				
				sc.addEventListener(MouseEvent.CLICK, onClickHandle);
				
				if (i == 0)
				{
					sc.onSelect();
				}
				
				addChild(sc);
				
				storeArr.push(sc);
			}
			loadPoint(_xmlDate.list[0].store_id);
		}
		
		private function onClickHandle(e:MouseEvent):void
		{
			for (var key:String in storeArr)
			{
				if (storeArr[key].sid == e.currentTarget.sid)
				{
					storeArr[key].onSelect();
				}
				else
				{
					storeArr[key].unSelect();
				}
			}
			loadPoint(e.currentTarget.sid);
		}
		
		//-- load point Handler --//
		public function loadPoint(Point:String):void
		{
			
			_urlvar = new URLVariables();
			_urlreq = new URLRequest();
			_urlloa = new URLLoader();
			
			_urlvar.fun_type = "Point";
			_urlvar.store = Point;
			
			_urlloa.addEventListener(Event.COMPLETE, onPointCompInfoHandle);
			_urlloa.addEventListener(IOErrorEvent.IO_ERROR, onPointErrorHandler);
			_urlreq.data = _urlvar;
			_urlreq.url = GlobalVars.WEBHOST;
			
			_urlloa.dataFormat = URLLoaderDataFormat.BINARY;
			_urlloa.load(_urlreq);
		
		}
		
		private function onPointCompInfoHandle(e:Event):void
		{
			//trace(e.target.data);
			
			if (pointArr != null)
			{
				for (var key:String in pointArr)
				{
					Masked.removeChild(pointArr[key]);
				}
			}
			var _xmlDate:XML = XML(e.target.data);
			
			var num:int = _xmlDate.list.length();
			
			Masked = new Sprite;
			
			Masked.x = 539;
			Masked.y = 106;
			
			pointArr = new Array;
			
			for (var i:int = 0; i < num; i++)
			{
				var sc:mcPoint = new mcPoint();
				
				sc.y = i * 90;
				sc.x = 0;
				sc.loadInfo(_xmlDate.list[i].title, _xmlDate.list[i].tel, _xmlDate.list[i].address);
				Masked.addChild(sc);
				
				pointArr.push(sc);
			}
			
			addChild(Masked);
			
			RollTool.setRoll(upControl);
			
			RollTool.setRoll(downControl);
			
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
		
		private function onPointErrorHandler(e:IOErrorEvent):void
		{
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/point.xml" + GlobalVars.getVer(), onPointLoadedHandler);
		}
		
		/* example
		   <title>华堂大前门</title>
		   <tel>13962345678</tel>
		 <address>北京市大前门外大街99号</address>*/
		private function onPointLoadedHandler(e:Event):void
		{
			
			if (pointArr != null)
			{
				for (var key:String in pointArr)
				{
					Masked.removeChild(pointArr[key]);
				}
			}
			
			var _xmlDate:XML = e.target.xml;
			var num:int = _xmlDate.list.length();
			Masked = new Sprite;
			
			Masked.x = 539;
			Masked.y = 106;
			
			pointArr = new Array;
			
			for (var i:int = 0; i < num; i++)
			{
				var sc:mcPoint = new mcPoint();
				
				sc.y = i * 90;
				sc.x = 0;
				sc.loadInfo(_xmlDate.list[i].title, _xmlDate.list[i].tel, _xmlDate.list[i].address);
				Masked.addChild(sc);
				
				pointArr.push(sc);
			}
			
			addChild(Masked);
			
			RollTool.setRoll(upControl);
			RollTool.setRoll(downControl);
			
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
	}
}
