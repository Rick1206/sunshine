package code.page.promotion
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import code.tool.LoadXml;
	import code.GlobalVars;
	import code.tool.RollTool;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	
	import code.events.PChangeEvent;
	
	public class main extends MovieClip
	{
		private var curMc:spProFrame;
		private var curNum:int = 1;
		
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
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/promotion.xml" + GlobalVars.getVer(), onLoadedHandler);
			
			myPage.addEventListener(PChangeEvent.CHANGE, onBottomPageHandle);
		}
		
		private function onBottomPageHandle(e:PChangeEvent):void
		{
			curNum = int(e.page);
			
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/promotion.xml" + GlobalVars.getVer(), onLoadedHandler);
		
		}
		
		private function onLoadedHandler(e:Event):void
		{
			if (curMc != null)
			{
				TweenMax.to(curMc, .5, {x: "-200", alpha:0 ,onComplete: function()
					{
						
						removeChild(curMc);
						
						var _xmlDate:XML = e.target.xml;
						var num:int;
						num = _xmlDate.promotion.length();
						var nowArr:Array = new Array;
						for (var i:int = 0; i < num; i++)
						{
							var obj:Object = new Object;
							obj.imgUrl = _xmlDate.promotion[i].imgurl;
							obj.imgLink = _xmlDate.promotion[i].imglink;
							nowArr.push(obj);
						}
						curMc = new spProFrame(nowArr);
						curMc.x = 158;
						curMc.y = 116;
						addChild(curMc);
						myPage.pageInit(_xmlDate.pageNum, 3, curNum);
						TweenMax.from(curMc, .5, {x: "200", alpha: 0});
					
					}});
				
			}
			else
			{
				
				var _xmlDate:XML = e.target.xml;
				var num:int;
				num = _xmlDate.promotion.length();
				var nowArr:Array = new Array;
				for (var i:int = 0; i < num; i++)
				{
					var obj:Object = new Object;
					obj.imgUrl = _xmlDate.promotion[i].imgurl;
					obj.imgLink = _xmlDate.promotion[i].imglink;
					nowArr.push(obj);
				}
				curMc = new spProFrame(nowArr);
				curMc.x = 158;
				curMc.y = 116;
				addChild(curMc);
				myPage.pageInit(_xmlDate.pageNum, 3, curNum);
				TweenMax.from(curMc, .5, {x: "200", alpha: 0});
			}
		}
		
		private function onChangePageHandler(e:MouseEvent):void
		{
			trace(e.currentTarget.page);
			TweenMax.to(curMc, .5, {x: "-200", alpha: 0, onComplete: loadInfo});
		}
		
		private function loadInfo()
		{
			curMc.x = 358;
			TweenMax.to(curMc, .5, {x: "-200", alpha: 1});
		}
	}

}
