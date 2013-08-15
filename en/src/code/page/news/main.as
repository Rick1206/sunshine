package code.page.news
{
	
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
	import code.page.mcControl;
	import code.events.NChangeEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import code.events.PChangeEvent;
	
	public class main extends MovieClip
	{
		
		private var curNum:int = 1;
		
		private var newsArr:Array;
		
		private var newsFrame:Sprite;
		
		private var _urlreq:URLRequest;
		
		private var _urlvar:URLVariables;
		
		public var _urlloa:URLLoader;
		
		private var allNum:int;
		
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
			
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/news.xml" + GlobalVars.getVer(), onLoadedHandler);
			
			setBtn();
			
			newsDetail.visible = false;
			newsDetail.alpha = 0;
			//--test--//
			//newsDetail.loadInfo("1");
			newsDetail.addEventListener("back", onHideNewsDetailHandler);
			
			newsFrame = new Sprite;
		}
		
		private function setBtn():void
		{
			nList.btnLast.addEventListener(MouseEvent.CLICK, onClickHandler);
			nList.btnNext.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			RollTool.setRoll(nList.btnLast);
			RollTool.setRoll(nList.btnNext);
			
			myPage.addEventListener(PChangeEvent.CHANGE, onBottomPageHandle);
		}
		
		private function onBottomPageHandle(e:PChangeEvent):void
		{
			curNum = int(e.page);
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/news.xml" + GlobalVars.getVer(), onLoadedHandler);
		
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			switch (e.currentTarget.name)
			{
				case "btnLast": 
					if (curNum > 1)
					{
						curNum--;
						
						TweenMax.to(newsFrame, .5, {x: 406, autoAlpha: 0, onComplete: function()
							{
								var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/news.xml" + GlobalVars.getVer(), onLoadedHandler);
								
								TweenMax.to(newsFrame, .5, {x: 206, autoAlpha: 1, onInit: function()
									{
										newsFrame.x = -6;
									
									}});
							}});
					}
					break;
				case "btnNext": 
					if (curNum < allNum)
					{
						curNum++;
						
						TweenMax.to(newsFrame, .5, {x: -6, autoAlpha: 0, onComplete: function()
							{
								var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/news.xml" + GlobalVars.getVer(), onLoadedHandler);
								
								TweenMax.to(newsFrame, .5, {x: 206, autoAlpha: 1, onInit: function()
									{
										newsFrame.x = 406;
									
									}});
							}});
					}
					break;
			}
		}
		
		private function onLoadedHandler(e:Event):void
		{
			
			if (newsArr != null)
			{
				for (var key:String in newsArr)
				{
					newsFrame.removeChild(newsArr[key]);
				}
				newsArr = null;
			}
			
			var _xmlDate:XML = e.target.xml;
			
			newsArr = new Array();
			var num:int = _xmlDate.news.length();
			var rnum:int = Math.round(_xmlDate.news.length() / 2);
			var cnum:int = 2;
			var n:int = 0;
			
			newsFrame.x = 206;
			newsFrame.y = 164;
			
			for (var i:int = 0; i < rnum; i++)
			{
				for (var t:int = 0; t < cnum; t++)
				{
					if (n != num)
					{
						var sc:mcNews = new mcNews();
						
						sc.y = i * 130;
						
						sc.x = t * 350;
						
						sc.loadInfo(_xmlDate.news[n].title, _xmlDate.news[n].img, _xmlDate.news[n].time, _xmlDate.news[n].newsid);
						
						newsFrame.addChild(sc);
						
						sc.addEventListener(NChangeEvent.CHANGE, onShowNewsDetailHandler);
						
						newsArr.push(sc);
						
						n++;
					}
					else
					{
						break;
					}
				}
			}
			
			nList.addChild(newsFrame);
			
			allNum = _xmlDate.pageNum;
			
			myPage.pageInit(allNum, 3, curNum);
		
		}
		
		private function onShowNewsDetailHandler(e:NChangeEvent):void
		{
			TweenMax.to(nList, .3, {autoAlpha: 0});
			
			TweenMax.to(myPage, .3, {autoAlpha: 0});
			
			TweenMax.to(newsDetail, .3, {autoAlpha: 1});
			
			newsDetail.loadInfo(e.nid);
		}
		
		private function onHideNewsDetailHandler(e:Event):void
		{
			TweenMax.to(nList, .3, {autoAlpha: 1});
			
			TweenMax.to(myPage, .3, {autoAlpha: 1});
		}
	}

}
