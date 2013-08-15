package code.page
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	import com.greensock.TweenNano;
	import code.GlobalVars;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import com.greensock.TweenMax;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.display.Loader;
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	
	public class home extends MovieClip
	{
		
		private var mcMain:MovieClip;
		private var bannerArr:Array;
		private var bannerSc:Array;
		private var bannerUrl:Array;
		private var swfLoader:Loader;
		private var curNum:int;
		private var Num:int;
		private var curMc:MovieClip;
		private var curSc:MovieClip;
		private var _percentage:Number;
		
		public function home()
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
			sc1.gotoAndStop(2);
			
			bannerArr = new Array;
			curNum = 0;
			Num = 0;
			bannerSc = [sc1, sc2, sc3, sc4, sc5];
			curSc = bannerSc[0];
			
			bannerUrl = ["banner1.swf", "banner2.swf", "banner3.swf", "banner4.swf", "banner5.swf"];
			loadSwf(GlobalVars.getPath() + bannerUrl[curNum] + GlobalVars.getVer());
		}
		
		private function onChangeHandler(e:MouseEvent):void
		{
			var sc:MovieClip = e.currentTarget as MovieClip;
			
			stage.dispatchEvent(new Event("HidePro"));
			
			curMc.stop();
			TweenLite.to(curMc, .3, {alpha: 0});
			curSc.gotoAndStop(1);
			
			switch (e.currentTarget.name)
			{
				case "sc1": 
					curNum = 0;
					break;
				case "sc2": 
					curNum = 1;
					break;
				case "sc3": 
					curNum = 2;
					break;
				case "sc4": 
					curNum = 3;
					break;
				case "sc5": 
					curNum = 4;
					break;
			}
			
			curMc = bannerArr[curNum];
			TweenLite.to(curMc, .3, {alpha: 1});
			bannerArr[curNum].gotoAndPlay(2);
			
			curSc = sc;
			sc.gotoAndStop(2);
		}
		
		private function loadSwf(str:String):void
		{
			swfLoader = new Loader;
			swfLoader.load(new URLRequest(str));
			swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProssHandle);
			swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSwfCompleteHandle);
		}
		
		private function onSwfCompleteHandle(e:Event):void
		{
			subLoading.visible = false;
			bannerSc[Num].addEventListener(MouseEvent.CLICK, onChangeHandler);
			RollTool.setRoll(bannerSc[Num]);
			
			var mc:MovieClip = e.target.content as MovieClip;
			
			bannerFrame.addChild(mc);
			bannerArr.push(mc);
			
			mc.addEventListener("playover", onPlayHandler);
			mc.addEventListener("showPro", onShowProHandler);
			
			
			if (Num == curNum)
			{
				mc.play();
				curMc = mc;
				trace("play");
			}
			else
			{
				mc.stop();
				trace("stop");
			}
			
			Num++;
			
			if (Num < 5)
			{
				loadSwf(GlobalVars.getPath() + bannerUrl[Num] + GlobalVars.getVer());
			}
		
		}

	
		private function onShowProHandler(e:Event):void
		{
			trace("showPro");
			stage.dispatchEvent(new Event("ShowPro"));
		}
		
		private function onProssHandle(e:ProgressEvent):void
		{
			_percentage = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			subLoading.txt_loading.text = String(_percentage) + "%";
		}
		
		private function errorHandler(event:LoaderEvent):void
		{
			trace("error");
		}
		
		private function onPlayHandler(e:Event):void
		{
			
			
			stage.dispatchEvent(new Event("HidePro"));
			
			curNum++;
			
			if (curNum == 5)
			{
				curNum = 0;
				bannerSc[4].gotoAndStop(1);
			}
			else
			{
				bannerSc[curNum - 1].gotoAndStop(1);
			}
			
			if (bannerArr[curNum] != null)
			{
				curMc = bannerArr[curNum];
				TweenLite.to(curMc, .3, {alpha: 1});
				bannerArr[curNum].gotoAndPlay(2);
			}
			else
			{
				subLoading.visible = true;
				
			}
			
			curSc = bannerSc[curNum];
			bannerSc[curNum].gotoAndStop(2);
		}
	}

}
