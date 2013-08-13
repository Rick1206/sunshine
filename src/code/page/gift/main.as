package code.page.gift
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import flash.events.Event;
	
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import code.events.GChangeEvent;
	import code.tool.RollTool;
	import code.GlobalVars;
	import code.tool.LoadXml;
	
	public class main extends MovieClip
	{
		
		private var _urlreq:URLRequest;
		private var _urlvar:URLVariables;
		public var _urlloa:URLLoader;
		private var gGift:MovieClip;
		private var gFrame:Sprite;
		private var scArr:Array;
		private var _num:int;
		private var _xmlDate:XML;
		
		
		private var allPage:int;
		
		
		
		public function main()
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
			
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/gift.xml" + GlobalVars.getVer(), onLoadedHandler);
			
			gDetail.alpha = 0;
			gDetail.visible = false;
			
			gDetail.addEventListener("back", onBackHandler);
			
			gFrame = new Sprite;
			
			gFrame.x = 400;
			gFrame.y = 400;
			
			gList.addChild(gFrame);
			
			TweenMax.from(Bg, .3, { alpha:0 } );
		}
		
		private function onBackHandler(e:Event):void
		{
			TweenMax.to(gList, .3, {autoAlpha: 1});
			TweenMax.to(gDetail, .3, {autoAlpha: 0});
		
		}
		
		private function onLoadedHandler(e:Event):void
		{
			_xmlDate  = e.target.xml;
			
			var num:int = _xmlDate.gift.length();
			
			allPage =  int(_xmlDate.pageNum)-1;
			_num = 0;
			
			if (int(_xmlDate.pageNum) > 1)
			{
				gList.showBtn();
			}
			else
			{
				gList.hideBtn();
			}
			
			scArr = new Array();
			
			for (var i:int = 0; i < 2; i++)
			{
				var sc:mcGift = new mcGift();
				//trace(_xmlDate.gift[i].type);
				switch(String(_xmlDate.gift[i].type)) {
					case "2":
						//trace(3);
						sc.setPicRef(-40, 100);
						break;
					case "3":
						sc.setPicRef(-40, 100);
						break;
				}
				
				sc.loadInfo(_xmlDate.gift[i].title, GlobalVars.getPath() + _xmlDate.gift[i].img + GlobalVars.getVer(), _xmlDate.gift[i].type);
				
				sc.addEventListener(GChangeEvent.DETAIL, onGiftCompleteHandler);
				sc.gid = String(i);
				sc.x = i * 300;
				
				scArr.push(sc);
				
				gFrame.addChild(sc);
				
			}
			
			setBtn();
		}
		
		private function page() {
			
			
			for (var key:String in scArr) {
				gFrame.removeChild(scArr[key]);
			}
			
			var _str:int = _num*2;
			var _end:int = _str + 2;
			var _i:int = 0;
			
			scArr = new Array();
			
			for (var i:int = _str; i < _end; i++)
			{
		
				var sc:mcGift = new mcGift();
				
				switch(String(_xmlDate.gift[i].type)) {
					case "2":
						trace(3);
						sc.setPicRef(-40, 100);
						break;
					case "3":
						sc.y = -20;
						sc.setPicRef(-120, 120,80,120);
						break;
					case "4":
						sc.y = -20;
						sc.setPicRef(-90, 120,80,120);
						break;
				}
				
				
				
				sc.loadInfo(_xmlDate.gift[i].title, GlobalVars.getPath() + _xmlDate.gift[i].img + GlobalVars.getVer(), _xmlDate.gift[i].type);
				sc.gid = String(i);
				
				sc.addEventListener(GChangeEvent.DETAIL, onGiftCompleteHandler);
				
				sc.x = _i * 300;
				_i++;
				
				scArr.push(sc);
				
				gFrame.addChild(sc);
				
			}
		}
		
		
		private function setBtn():void
		{
			gList.btnLast.addEventListener(MouseEvent.CLICK, onClickHandler);
			gList.btnNext.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			RollTool.setRoll(gList.btnLast);
			RollTool.setRoll(gList.btnNext);
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			switch (e.currentTarget.name)
			{
				case "btnLast": 
					if (_num > 0) {
					_num--;
					TweenMax.to(gFrame, .5, {x: "200", alpha: 0, onComplete: function()
						{
							page();
							TweenMax.to(gFrame, .5, { alpha: 1, onInit: function()
								{
									gFrame.x -= 200;

								}});
						
						}});
						
						}
					break;
				case "btnNext": 
					if (_num < allPage) {
						
					_num++;
					
					TweenMax.to(gFrame, .5, {x: "-200", alpha: 0, onComplete: function()
						{
							page();
							TweenMax.to(gFrame, .5, {alpha: 1, onInit: function()
								{
									
									gFrame.x += 200;
								
								}});
						
						}});
						
					}
					break;
			}
		}
		
		private function onPageHandler(page:int):void
		{
			
			TweenMax.to(gList, .3, {x: "200"});
		}
		
		private function onGiftCompleteHandler(e:GChangeEvent):void
		{
			if (e.gtype == "2")
			{
				if (gGift != null) {
					TweenMax.to(gList, .3, {autoAlpha: 0});
					TweenMax.to(gGift, .3, { autoAlpha: 1 } );
				}else {
				
				var swfLoader:SWFLoader = new SWFLoader(GlobalVars.getPath() + "giftGame.swf" + GlobalVars.getVer(), {onComplete: onSubSwfLoaderHandler});
					
				swfLoader.load();
				
				}
				
			}
			else
			{
				TweenMax.to(gList, .3, {autoAlpha: 0});
				
				TweenMax.to(gDetail, .3, {autoAlpha: 1});
				
				gDetail.loadInfo(e.gid, e.gtype);
			}
		}
		
		private function onSubSwfLoaderHandler(e:LoaderEvent):void
		{
			
			TweenMax.to(gList, .3, {autoAlpha: 0});
			
			gGift = e.target.rawContent as MovieClip;
			
			gGift.alpha = 0;
			
			TweenMax.to(gGift, .3, { autoAlpha: 1 } );
			
			gGift.addEventListener("back", onGameBackHandler);
			
			addChild(gGift);
		
		}
		
		private function onGameBackHandler(e:Event):void
		{
			TweenMax.to(gGift, .3, {autoAlpha: 0});
			
			TweenMax.to(gList, .3, {autoAlpha: 1});
		}
	}

}
