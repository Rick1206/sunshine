package code.page
{
	import code.events.PChangeEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	/*
	 * swfaddress control url address 
	 */
	 
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import com.greensock.easing.*;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.TimelineMax;
	
	import code.GlobalVars;
	import code.tool.RollTool;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.net.navigateToURL;
	
	public class nav extends MovieClip
	{
		private var btnArr:Array;
		private var state:String;
		private var myline:TimelineMax;
		private var curName:String;
		private var curMc:MovieClip;
		
		public var subBg:MovieClip;
		public var mcPro:MovieClip;
		
		/*
		 * back up buttons
		 * Singleton 
		 */ 
		
		//public var btnNavDetail:MovieClip;
		//public var btnBrand:MovieClip;
		//public var btnPromotion:MovieClip;
		//public var btnTime:MovieClip;
		//public var btnNews:MovieClip;
		//public var btnAbout:MovieClip;
		//public var btnExpert:MovieClip;
		//public var btnContact:MovieClip;
		
		private var _fir:Boolean = true;
		
		private var oriH:Array;
		private var desH:Array;
		
		public function nav()
		{
			if (stage)
			{
				initAll();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initAll);
			}
		}
		
		private function initAll(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
			
			subBg.alpha = 0;
			
			mcPro.alpha = 0;
			mcPro.visible = false;
			mcPro.addEventListener(MouseEvent.CLICK, onGotoShopHandler);
			RollTool.setRoll(mcPro);
			
			RollTool.setRoll(btnNavDetail);
			btnNavDetail.addEventListener(MouseEvent.CLICK, onShowNavHandler);
			
			RollTool.setRoll(btnLogo);
			btnLogo.addEventListener(MouseEvent.CLICK, onHomePageHandler);
			
			btnArr = [btnBrand, btnPromotion, btnTime, btnExpert, btnNews, btnAbout, btnContact];
			oriH = new Array();
			var h:Number;
			
			for (var key:String in btnArr)
			{
				btnArr[key].alpha = 0;
				
				btnArr[key].visible = false;
				
				h = btnArr[key].y;
				
				oriH.push(h);
				
				btnArr[key].hideSubItem();
				
				RollTool.setRoll(btnArr[key]);
				
				btnArr[key].addEventListener(PChangeEvent.CHANGE, onPageHandler);
			}
			
			state = "close";
			
			curMc = btnBrand;
			
			curMc.cstate();
			
			stage.addEventListener("ShowPro", onShowProHandler);
			
			stage.addEventListener("HidePro", onHideProHandler);
		
		}
		
		private function onGotoShopHandler(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.baidu.com"), "_blank");
		}
		
		private function onHomePageHandler(e:MouseEvent):void
		{
			setAddress("/brand/", "#/brand/", "SunShine - Home");
		}
		
		private function onPageHandler(e:PChangeEvent):void
		{
			
			curName = e.currentTarget.name;
			
			if (curMc.name != curName)
			{
				curMc.dstate();
			}
			else
			{
				curMc = e.currentTarget as MovieClip;
				curMc.cstate();
			}
			
			var pageName:String = e.page;
			switch (pageName)
			{
				case "brand": 
					setAddress("/brand/", "#/brand/", "SunShine - Home");
					break;
				case "fruit": 
					setAddress("/brand/fruit/", "#/brand/fruit/", "SunShine - Brand - Fruit");
					break;
				case "freeze": 
					setAddress("/brand/freeze/", "#/brand/freeze/", "SunShine - Brand - Freeze");
					break;
				case "nut": 
					setAddress("/brand/nut/", "#/brand/nut/", "SunShine - Brand - Nut");
					break;
					
				case "gift": 
					setAddress("/brand/gift/", "#/brand/gift/", "SunShine - Brand - Gift");
					break;
				case "promotion": 
					setAddress("/promotion/", "#/promotion/", "SunShine - Promotion");
					break;
				case "about": 
					setAddress("/about/", "#/about/", "SunShine - Aboutus");
					break;
				case "story": 
					setAddress("/story/", "#/story/", "SunShine - Aboutus");
					break;
				case "vision": 
					setAddress("/vision/", "#/vision/", "SunShine - vision");
					break	
				case "production": 
					setAddress("/production/", "#/production/", "SunShine - production");
					break	
				
				case "contact": 
					setAddress("/contact/", "#/contact/", "SunShine - Contact");
					break;
				case "contactus": 
					setAddress("/contact/contactus/", "#/contact/contactus/", "SunShine - Contact - Contactus");
					break;
				case "joinus": 
					setAddress("/contact/joinus/", "#/contact/joinus/", "SunShine - Contact - Joinus");
					break;
				case "map": 
					setAddress("/contact/map/", "#/contact/map/", "SunShine - Contact - Map");
					break;
				case "time": 
					setAddress("/nutrition/", "#/nutrition/", "SunShine - Nutrition");
					break;
				case "expert": 
					setAddress("/expert/", "#/expert/", "SunShine - Expert");
					break;
				case "news": 
					setAddress("/news/", "#/news/", "SunShine - News");
					break;
				case "brandnews": 
					setAddress("/news/brandnews/", "#/news/brandnews/", "SunShine - Brandnews");
					break;
					
				case "medianews": 
					setAddress("/news/medianews/", "#/news/medianews/", "SunShine - Medianews");
					break;	
				
				case "travel": 
					setAddress("/nutrition/travel/", "#/nutrition/travel/", "SunShine - nutrition - travel");
					break;
				case "network": 
					setAddress("/nutrition/network/", "#/nutrition/network/", "SunShine - nutrition - network");
					break;
				case "office": 
					setAddress("/nutrition/office/", "#/nutrition/office/", "SunShine - nutrition - office");
					break;
				case "friend": 
					setAddress("/nutrition/friend/", "#/nutrition/friend/", "SunShine - nutrition - friend");
					break;
				case "autumn": 
					setAddress("/nutrition/autumn/", "#/nutrition/autumn/", "SunShine - nutrition - autumn");
					break;
			}
		
		}
		
		private function onHideProHandler(e:Event):void
		{
			TweenMax.to(mcPro, .5, {autoAlpha: 0});
		}
		
		private function onShowProHandler(e:Event):void
		{
			TweenMax.to(mcPro, .5, {autoAlpha: 1});
		}
		
		public function onChangeNavHandler(e:Event = null):void
		{
			var curPageName:String = SWFAddress.getValue();
			this.onHideProHandler(null);
			
			switch (curPageName)
			{
				case "/home/": 
					checkState("btnBrand");
					break;
				case "/brand/": 
					checkState("btnBrand");
					break;
				case "/promotion/": 
					checkState("btnPromotion");
					break;
				case "/about/": 
					checkState("btnAbout");
					break;
				case "/contact/": 
					checkState("btnContact");
					break;
				case "/nutrition/": 
					checkState("btnTime");
					break;
				case "/expert/": 
					checkState("btnExpert");
					break;
				case "/news/": 
					checkState("btnNews");
					break;
				case "/": 
					checkState("btnBrand");
					break;
			}
			
			var bolH:Boolean = false;
			desH = new Array;
			
			var creH:Number = 0;
			
			for (var key:String in btnArr)
			{
				if (curMc == btnArr[key])
				{
					bolH = true;
					curMc.showSubItem();
					curMc.y = oriH[key];
					creH = btnArr[key].curHeight;
					trace(creH);
				}
				else
				{
					if (bolH)
					{
						//backup y useful
						//btnArr[key].y = oriH[key] + creH;
						if (state == "open")
						{
							TweenMax.to(btnArr[key], .3, {y: oriH[key] + creH});
						}
						else
						{
							btnArr[key].y = oriH[key] + creH;
						}
					}
					else
					{
						//backup y useful
						//btnArr[key].y = oriH[key];
						if (state == "open")
						{
							TweenMax.to(btnArr[key], .3, {y: oriH[key]});
						}
						else
						{
							btnArr[key].y = oriH[key];
						}
					}
					btnArr[key].hideSubItem();
				}
				desH.push(btnArr[key].y);
			}
		
			//back-up
			//stage addevent and main.swf will load sub swf
			//GlobalVars.setPage(curPageName);
			//stage.dispatchEvent(new Event("change"));
		}
		
		public function checkState(str:String)
		{
			for (var key:String in btnArr)
			{
				if (btnArr[key].name == str)
				{
					btnArr[key].cstate();
					curMc = btnArr[key];
				}
				else
				{
					btnArr[key].dstate();
				}
			}
		}
		
		private function setAddress(v:String, h:String, t:String)
		{
			SWFAddress.setValue(v);
			SWFAddress.href(h);
			SWFAddress.setTitle(t);
		}
		
		//animation by click btn detail
		private function onShowNavHandler(e:MouseEvent):void
		{
			
			btnNavDetail.removeEventListener(MouseEvent.CLICK, onShowNavHandler);
			
			if (state == "close")
			{
				state = "open";
				
				TweenLite.to(btnNavDetail.mcArrow, 0.3, {rotation: 180});
				
				TweenMax.to(subBg, 0.4, {autoAlpha: 1, ease: Bounce.easeOut, onComplete: function()
					{
						var myTimer:Timer = new Timer(1500, 1);
						myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeHandler);
						myTimer.start();
					}});
				
				for (var key:String in btnArr)
				{
					btnArr[key].unBindClick();
					btnArr[key].y = btnArr[key].y - 80;
					TweenMax.to(btnArr[key], 1.2, {autoAlpha: 1, y: desH[key], delay: int(key) * 0.03, ease: Back.easeOut});
				}
			}
			else
			{
				TweenLite.to(btnNavDetail.mcArrow, 0.3, {rotation: 360});
				myline = new TimelineMax();
				
				myline.insert(TweenMax.to(btnContact, 0.35, {autoAlpha: 0}));
				myline.insert(TweenMax.to(btnAbout, 0.35, {autoAlpha: 0}));
				myline.insert(TweenMax.to(btnNews, 0.35, {autoAlpha: 0}));
				myline.insert(TweenMax.to(btnExpert, 0.35, {autoAlpha: 0}));
				myline.insert(TweenMax.to(btnTime, 0.35, {autoAlpha: 0}));
				myline.insert(TweenMax.to(btnPromotion, 0.35, {autoAlpha: 0}));
				myline.insert(TweenMax.to(btnBrand, 0.35, {autoAlpha: 0}));
				myline.insert(TweenMax.to(subBg, 0.35, {autoAlpha: 0, onComplete: function()
					{
						
						var myTimer:Timer = new Timer(400, 1);
						myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeHandler);
						myTimer.start();
					
					}}));
				
				desH = new Array;
				
				for (key in btnArr)
				{
					desH.push(btnArr[key].y);
					btnArr[key].unBindClick();
				}
				
				myline.play();
				state = "close";
			}
		
		}
		
		private function onTimeHandler(e:TimerEvent):void
		{
			e.target.stop();
			e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimeHandler);
			btnNavDetail.addEventListener(MouseEvent.CLICK, onShowNavHandler);
			
			for (var key:String in btnArr)
			{
				btnArr[key].BindClick();
			}
		}
	
	}
}

