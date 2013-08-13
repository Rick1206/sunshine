package code.page
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import com.greensock.TweenMax;
	import com.greensock.TweenLite;
	
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	
	import code.GlobalVars;
	import com.greensock.loading.display.*;
	import com.greensock.TweenNano;
	import code.events.PChangeEvent;
	
	
	
	public class main extends MovieClip
	{
		private var _pX:Number;
		private var _pY:Number;
		private var tracker:AnalyticsTracker;
		private var mcMain:ContentDisplay;
		
		//private var loader:SWFLoader;
		private var loader:Loader;
		private var mc:MovieClip;
		private var _percentage:Number;
		
		public function main()
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
			
			if (stage.stageWidth > 1300){
				mcNav.x = -158;
			}
			else{
				mcNav.x = 0;
			}
			
			//mcNav.addEventListener(PChangeEvent.CHANGE, onPageHandler);
			//stage.addEventListener("change", onChangePageHandler);
			stage.addEventListener(Event.RESIZE, updateNavStage);
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onChangePageHandler);
		}
		
		private function onChangePageHandler(e:SWFAddressEvent):void 
		{
			var curPageName:String = SWFAddress.getValue();
			
			switch (curPageName)
			{
				case "/home/": 
					loadSwf("home.swf");
					break;
				case "/brand/nut/": 
					loadSwf("nut.swf");
					break;
				case "/brand/fruit/": 
					loadSwf("coming.swf");
					break;
				case "/brand/freeze/": 
					loadSwf("coming.swf");
					break;
				case "/brand/gift/": 
					loadSwf("gift.swf");
					break;
				case "/promotion/": 
					loadSwf("promotion.swf");
					break;
				case "/about/": 
					loadSwf("about.swf");
					break;
				case "/nutrition/": 
					loadSwf("time.swf");
					break;
				case "/contact/": 
					loadSwf("map.swf");
					break;
				case "/contact/contactus/": 
					loadSwf("contactus.swf");
					break;	
				case "/contact/joinus/": 
					loadSwf("joinus.swf");
					break;
				case "/contact/map/": 
					loadSwf("map.swf");
					break;	
				case "/news/": 
					loadSwf("news.swf");
					break;
				case "/nutrition/travel/": 
					loadSwf("timedetail.swf");
					break;
				case "/nutrition/network/": 
					loadSwf("timedetail.swf");
					break;
				case "/nutrition/office/": 
					
					loadSwf("timedetail.swf");
					break;
				case "/nutrition/friend/": 
					loadSwf("timedetail.swf");
					break;
				case "/nutrition/autumn/": 
					loadSwf("timedetail.swf");
					break;
				case "/story/": 
					loadSwf("about.swf");
					break;
					
				case "/vision/": 
					loadSwf("coming.swf");
					break;
				case "/production/": 
					loadSwf("coming.swf");
					break;
				case "/expert/": 
					loadSwf("coming.swf");
					break;	
				case "/news/medianews/": 
					loadSwf("coming.swf");
					break;	 
				case "/news/brandnews/": 
					loadSwf("news.swf");
					break;	 
					
					
				default: 
					loadSwf("home.swf");
					break;
			}
			mcNav.onChangeNavHandler();
		}
		
		private function updateNavStage(e:Event):void
		{
			if (stage.stageWidth > 1300)
			{
				mcNav.x = -158;
			}
			else
			{
				mcNav.x = 0;
			}
		}
		
		private function loadSwf(str:String):void
		{
			if (loader != null)
			{
				mcPhase.removeChild(loader);
				loader.unloadAndStop();
			}
			
			loader = new Loader();
			loader.load(new URLRequest(GlobalVars.getPath() + str + GlobalVars.getVer()));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function progressHandler(e:ProgressEvent):void
		{
			subLoading.visible = true;
			_percentage = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			//subLoading.loadBand.gotoAndStop(_percentage);
			subLoading.txt_loading.text = String(_percentage)+"%";
		}
		private function completeHandler(e:Event):void
		{
			loader.alpha = 0;
			TweenNano.to(loader, 0.5, {alpha: 1});
			mcPhase.addChild(loader);
			subLoading.visible = false;
		}
		
		private function errorHandler(event:LoaderEvent):void
		{
			trace("error");
		}
	
	}

}
