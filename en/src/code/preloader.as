package code
{
	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.greensock.TweenNano;
	import flash.display.Loader;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import code.GlobalVars;
	import flash.system.System;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import flash.system.Security;
	
	public class preloader extends MovieClip
	{
		
		private var mcMain:ContentDisplay;
		private var mcNav:ContentDisplay;
		private var mcControl:ContentDisplay;
		private	var mcfoot:ContentDisplay;
		private var _percentage:int;
		private var tracker:AnalyticsTracker;
		private var stateMode:String;
		
		public function preloader()
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
			var domain:String = LoaderInfo(this.root.loaderInfo).parameters.domain;
		
			Security.allowDomain(domain);
			Security.allowInsecureDomain(domain);
			
			//SWFAddress.setValue("11");
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//tracking
			//tracker = new GATracker(this, "UA-35276486-1", "AS3", false);
			//try{
			//tracker.trackPageview("/preloader");
			//}
			//catch (error:Error)
			//{
			//trace(error);
			//}
			
			TweenNano.to(mc_loading, .3, {alpha: 1});
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			mc_loading.x = (stage.stageWidth / 2);
			mc_loading.y = (stage.stageHeight / 2);
			stage.addEventListener(Event.RESIZE, updateStage);
			
			stateMode = "web";
			if (stateMode == "web")
			{
				var ver:String = stage.loaderInfo.parameters["ver"];
				if (ver != null && ver != "")
				{
					GlobalVars.setVer("?ver=" + ver);
				}
			}
			else
			{
				GlobalVars.setVer("");
			}
			
			//swf location
			
			var str:String = stage.loaderInfo.parameters["loc"];
			if (str != null && str != "")
			{
				GlobalVars.setPath(str);
			}
			else
			{
				GlobalVars.setPath("");
			}
			
			/*var mid:String = stage.loaderInfo.parameters["mid"];
			if (mid != null && mid != "")
			{
				GlobalVars.setMid(mid);
			}*/
			
			/*var action:String = stage.loaderInfo.parameters["action"];
			if (action != null && action != "")
			{
				GlobalVars.setAction(action);
			}*/
			
			var queue:LoaderMax = new LoaderMax( { name: "mainQueue", onProgress: progressHandler, onComplete: completeHandler, onError: errorHandler } );
			queue.append(new SWFLoader(GlobalVars.getPath() + "main.swf" + GlobalVars.getVer(), {name: "main", container: this, alpha: 0}));
			//queue.append(new SWFLoader(GlobalVars.getPath() + "nav.swf" + GlobalVars.getVer(), {name: "nav", container: this, alpha: 0}));
			queue.append(new ImageLoader(GlobalVars.getPath() + "images/bg.jpg" + GlobalVars.getVer(), {name: "bg", container: this, alpha: 0}));
			queue.append(new SWFLoader(GlobalVars.getPath() + "control.swf" + GlobalVars.getVer(), {name: "control", container: this, alpha: 0}));
			queue.append(new SWFLoader(GlobalVars.getPath() + "foot.swf" + GlobalVars.getVer(), {name: "foot", container: this, alpha: 0}));
			
			queue.load();
		}
		
		
		private function errorHandler(event:LoaderEvent):void
		{
			trace("error");
		}
		
		private function completeHandler(event:LoaderEvent):void
		{
			stage.removeEventListener(Event.RESIZE, updateStage);
			//remove loading
			TweenNano.to(mc_loading, .3, {alpha: 0});
			
			//backgrond
			var image:ContentDisplay = LoaderMax.getContent("bg");
				bgFrame.addChild(image);
			TweenNano.to(image, 0.5, {alpha: 1});
			stage.addEventListener(Event.RESIZE, updateBgStage);
			bgFrame.width = stage.stageWidth;
			bgFrame.height = stage.stageHeight;
			
			mcMain = LoaderMax.getContent("main");
			mcMain.x = stage.stageWidth / 2 - 500;
			stage.addChild(mcMain);
			TweenNano.to(mcMain, 0.5, {alpha: 1});
			stage.addEventListener(Event.RESIZE, updateMainStage);
			
			//backup for first
			//TweenNano.to(mcMain, 0.5, {alpha: 1, onComplete: function():void
				//{
					//GlobalVars.setState("fir");
				//}});
			
			//mcNav = LoaderMax.getContent("nav");
			mcControl = LoaderMax.getContent("control");
			
			if (stage.stageWidth > 1300)
			{
				//mcNav.x = (stage.stageWidth / 2) - 650;
				mcControl.x = (stage.stageWidth / 2) - 340;
			}
			else
			{
				//mcNav.x = (stage.stageWidth / 2) - 500;
				mcControl.x = (stage.stageWidth / 2) - 580;
			}
			
			//stage.addChild(mcNav);
			stage.addChild(mcControl);
			//TweenNano.to(mcNav, 0.5, { alpha: 1 } );
			TweenNano.to(mcControl, 0.5, { alpha: 1 } );
			stage.addEventListener(Event.RESIZE, updateNavStage);
			
			//
			mcfoot = LoaderMax.getContent("foot");
			fFrame.addChild(mcfoot);
			TweenNano.to(mcfoot, 0.5, {alpha: 1});
			
			trace(event.target + " is complete!");
			
			
		}
		
		private function updateMainStage(e:Event):void
		{
			mcMain.x = stage.stageWidth / 2 - 500;
		}
		
		private function updateNavStage(e:Event):void
		{
			if (stage.stageWidth > 1300)
			{
				//mcNav.x = (stage.stageWidth / 2) - 650;
				mcControl.x = (stage.stageWidth / 2) - 340;
			}
			else
			{
				//mcNav.x = (stage.stageWidth / 2) - 500;
				mcControl.x = (stage.stageWidth / 2) - 580;
			}
		}
		
		private function progressHandler(event:LoaderEvent):void
		{
			_percentage = Math.round(event.target.progress * 100);
			mc_loading.txtFrame.txt_loading.text = String(_percentage) + "%";
		}
		
		private function updateBgStage(e:Event):void
		{
			bgFrame.width = stage.stageWidth;
			bgFrame.height = stage.stageHeight;
		}
		
		private function updateStage(e:Event):void
		{
			mc_loading.x = (stage.stageWidth / 2);
			mc_loading.y = (stage.stageHeight / 2);
		}
	}
}
