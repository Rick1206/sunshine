package code.page.time
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
	
	public class main extends MovieClip
	{
		private var TimeArr:Array;
		private var PosArr:Array;
		private var TimeFrame:Sprite;
		//private var TimeArr:Vector.<Sprite>;
		private var TimeDetail:Sprite;
		private var sc:MovieClip;
		
		private var strName:String;
		
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
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/time.xml" + GlobalVars.getVer(), onLoadedHandler);
		
		}
		
		private function onLoadedHandler(e:Event):void
		{
			var _xmlDate:XML = e.target.xml;
			
			TimeFrame = new Sprite();
			addChild(TimeFrame);
			
			TimeArr = new Array();
			
			//TimeArr = new Vector.<Sprite>;
			
			PosArr = new Array();
			
			var obj:Object = new Object;
			
			obj.x = Number(_xmlDate.time[i].x) - 100;
			obj.y = Number(_xmlDate.time[i].y);
			obj.sx = Number(_xmlDate.time[i].sx - .2);
			obj.sy = Number(_xmlDate.time[i].sy - .2);
			obj.a = 0;
			PosArr.push(obj);
			
			var num:int = _xmlDate.time.length();
			for (var i:int = 0; i < num; i++)
			{
				
				var mc:mcTime = new mcTime();
				
				
				if (i == 2) {
					mc.showInfo();
				}
				
				TimeFrame.addChild(mc);
				
				mc.name = String(i);
				mc.num = i;
				
				obj = new Object;
				
				obj.x = Number(_xmlDate.time[i].x);
				obj.y = Number(_xmlDate.time[i].y);
				obj.sx = Number(_xmlDate.time[i].sx);
				obj.sy = Number(_xmlDate.time[i].sy);
				obj.a = Number(_xmlDate.time[i].alp);
				
				mc.x = _xmlDate.time[i].x;
				mc.y = _xmlDate.time[i].y;
				mc.scaleX = _xmlDate.time[i].sx;
				mc.scaleY = _xmlDate.time[i].sy;
				mc.alpha = _xmlDate.time[i].alp;
				
				//trace(_xmlDate.time[i].alp);
				
				
				mc.loadInfo(_xmlDate.time[i].title, _xmlDate.time[i].description,_xmlDate.time[i].img);
				
				mc.addEventListener(MouseEvent.CLICK, onAniHandler);
				
				mc.mcInfo.addEventListener("showDetail", onShowDetailHandler);
				
				PosArr.push(obj);
				
				TimeArr.push(mc);
				
			}
			
			obj = new Object;
			
			obj.x = Number(_xmlDate.time[num - 1].x) + 100;
			obj.y = Number(_xmlDate.time[num - 1].y);
			obj.sx = Number(_xmlDate.time[num - 1].sx) - .2;
			obj.sy = Number(_xmlDate.time[num - 1].sy) - .2;
			obj.a = 0;
			PosArr.push(obj);
			
			sortTime();
		}
		
		private function onShowDetailHandler(e:Event):void
		{
			//trace("detail");
			//trace();
			strName = String(e.currentTarget.title);
			
			TweenMax.to(TimeFrame, .3, { autoAlpha: 0 } );
			
			if (TimeDetail != null)
			{
				TimeDetail.removeChild(sc);
					var loader:SWFLoader = new SWFLoader(GlobalVars.getPath() + "timedetail.swf" + GlobalVars.getVer(), {onComplete: onCompleteHandler});
					loader.load();
				//TweenMax.to(sc, .3, { autoAlpha: 1, onComplete:function() {}});
			}
			else
			{
				
				loader = new SWFLoader(GlobalVars.getPath() + "timedetail.swf" + GlobalVars.getVer(), {onComplete: onCompleteHandler});
				loader.load();
			}
		
		}
		
		private function onCompleteHandler(e:LoaderEvent):void
		{
			
			sc = e.target.rawContent as MovieClip;
			GlobalVars.setTime("");
			switch(strName) {
				case "春节欢庆时刻":
					sc.num = 0;
					break;
				case "朋友欢庆时刻":
					sc.num = 1;
					break;
				case "旅游休闲时刻":
					sc.num = 2;
					break;
				case "办公室小憩时刻":
					sc.num = 3;
					break;
				case "网上享乐时刻":
					sc.num = 4;
					break;
			}
			
			sc.addEventListener("back", onBackHandler);
			
			TimeDetail = new Sprite;
			TimeDetail.addChild(sc);
			
			addChild(TimeDetail);
			TweenMax.from(sc, .3, {autoAlpha: 0});
		
		}
		
		private function onBackHandler(e:Event):void
		{
			GlobalVars.setTime("");
			TweenMax.to(TimeFrame, .5, {autoAlpha: 1});
		}
		
		private function onAniHandler(e:MouseEvent):void
		{
			TimeArr.sortOn("num");
			
			var num:int = TimeArr.length;
			
			var lc:MovieClip = TimeArr[num - 1].clone();
			
			lc.x = PosArr[0].x;
			lc.y = PosArr[0].y;
			lc.scaleX = PosArr[0].sx;
			lc.scaleY = PosArr[0].sy;
			lc.alpha = 0;
			lc.num = 0;
			lc.mcInfo.addEventListener("showDetail", onShowDetailHandler);
			
			TimeFrame.addChild(lc);
			lc.addEventListener(MouseEvent.CLICK, onAniHandler);
			TweenMax.to(lc, .5, {x: PosArr[1].x, y: PosArr[1].y, scaleX: PosArr[1].sy, scaleY: PosArr[1].sx, alpha:PosArr[1].a});
			
			for (var i:int = 0; i < num; i++)
			{
				var n:int = TimeArr[i].num + 2;
				if (i == (num - 1))
				{
					TweenMax.to(TimeArr[i], .3, {x: PosArr[n].x, y: PosArr[n].y, scaleX: PosArr[n].sy, scaleY: PosArr[n].sx, alpha: 0, onComplete: function()
						{
							TimeFrame.removeChild(TimeArr[num - 1]);
							TimeArr.splice((num - 1), 1);
							
							TimeArr.unshift(lc);
							sortTime();
						}});
				}
				else if (i == 1) {
					
					TimeArr[i].num = i + 1;
					TimeArr[i].showInfo();
					TweenMax.to(TimeArr[i], .5, { x: PosArr[n].x, y: PosArr[n].y, scaleX: PosArr[n].sy, scaleY: PosArr[n].sx,alpha:PosArr[n].a} );
				}else {
					
					TimeArr[i].num = i + 1;
					TimeArr[i].hideInfo();
					TweenMax.to(TimeArr[i], .5, {x: PosArr[n].x, y: PosArr[n].y, scaleX: PosArr[n].sy, scaleY: PosArr[n].sx,alpha:PosArr[n].a});
				}
			}
		
		}
		public function changeTime():void {
			
			
			
			
		}
		private function sortTime():void
		{
			TimeArr.sortOn(y);
			TimeArr.reverse();
			var tLen:int = TimeArr.length;
			for (var i:int = 0; i < tLen; i++)
			{
				TimeFrame.setChildIndex(TimeArr[i], i);
			}
		}
	}

}
