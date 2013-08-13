package code.page.brand
{
	import code.products.mpro;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import code.page.brand.thumbnail;
	
	import com.greensock.TweenMax;
	import flash.utils.Timer;
	import flash.net.URLLoaderDataFormat;
	import code.products.mpro;
	import code.products.brandNut;
	import code.GlobalVars;
	import code.tool.Reflection;
	import code.tool.RollTool;
	
	public class nutMain extends MovieClip
	{
		
		private var _reflection:Reflection;
		private var xmlData:XML;
		private var _urlreq:URLRequest;
		private var _urlvar:URLVariables;
		public var _urlloa:URLLoader;
		private var proArr:Array;
		private var desArr:Array;
		private var desArrB:Array;
		
		private var myTimer:Timer;
		
		private var posArr:Array;
		private var posArrB:Array;
		
		private var _state:String;
		
		public function nutMain()
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
			
			pList.btnDown.addEventListener(MouseEvent.CLICK, onClickHandler);
			pList.btnDown.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			pList.btnDown.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			
			RollTool.setRoll(pList.btnDown);
			
			pDetail.alpha = 0;
			pDetail.visible = false;
			
			pDetail.addEventListener("back", onBackHandler);
			
			myTimer = new Timer(2500, 0);
			myTimer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			myTimer.start();
			
			posArr = [pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8, pos9, pos10, pos11];
			
			posArrB = [posB1, posB2, posB3, posB4, posB5, posB6, posB7, posB8, posB9, posB10, posB11];
			
			desArr = new Array;
			var blurArr:Array = [10, 10, 8, 5, 3, 0, 0, 0, 0, 0, 0];
			desArrB = new Array;
			
			for (var i:int = 0; i < 11; i++) {
				
				var pos:Object = new Object;
				var posB:Object = new Object;
				
				if (i > 1 && i < 9) {
					pos.a = 0.3 + .1 * (i - 1);
					posB.a = 0.3 + .1 * (i - 1);
				}else{
					pos.a = 0;
					posB.a = 0;
				}
				
				pos.b = blurArr[i];
				pos.x = posArr[i].x;
				pos.y = posArr[i].y;
				
				
				posB.b = blurArr[i];
				posB.x = posArrB[i].x;
				posB.y = posArrB[i].y;
				
				if (i > 1) {
					pos.sx = 0.09 + .13 * (i - 1);
					pos.sy = 0.09 + .13 * (i - 1);
					
					posB.sx = 0.09 + .13 * (i - 1);
					posB.sy = 0.09 + .13 * (i - 1);
				}else {
					pos.sx = 0.16;
					pos.sy = 0.16;
					
					posB.sx = 0.16;
					posB.sy = 0.16;
				}
				
				desArr.push(pos);
				
				desArrB.push(posB);
				
			}
			
			loadXml(GlobalVars.getPath() + "xml/product.xml" + GlobalVars.getVer());
		}
		
		private function onTimerHandler(e:TimerEvent):void
		{
			//onPageHandler();
			//onClickHandler(null);
		
		}
		
		private function onPageHandler():void
		{
			var num:int = proArr.length;
			for (var key:String in proArr)
			{
				if (int(key) < (num - 2))
				{
					//trace(key);
					TweenMax.to(proArr[key], .7, {x: desArr[int(key) + 2].x, y: desArr[int(key) + 2].y, scaleX: desArr[int(key) + 2].sx, scaleY: desArr[int(key) + 2].sy, alpha: desArr[int(key) + 2].a});
				}
				else
				{
					TweenMax.to(proArr[key], .3, {alpha: 0, onComplete: reset, onCompleteParams: [proArr[key], int(key)]});
				}
			}
		}
		
		private function onClickHandler(e:Event):void
		{
			var num:int = proArr.length;
			var des:Array; 
			if (_state=="A") {
				_state = "B";
			}else {
				_state = "A";
			}
			
			
			for (i = 0; i < 7;i++ )
			{
				if (int(i)<5) {
				TweenMax.to(proArr[i], .8, { x: desArr[i + 4].x, 
											   y: desArr[i + 4].y, 
											   scaleX: desArr[i + 4].sx, 
											   scaleY: desArr[i + 4].sy, 
											   alpha: desArr[i + 4].a,
											   blurFilter: {
													blurX:desArr[i + 4].b,
													blurY:desArr[i + 4].b},
											   delay:1.4-i*.2});
				}else {
				TweenMax.to(proArr[i], .8, { x: desArr[i + 4].x, 
												 y: desArr[i + 4].y, 
											     scaleX: desArr[i + 4].sx, 
											     scaleY: desArr[i + 4].sy, 
											   alpha: desArr[i + 4].a,
											   blurFilter: {
													blurX:desArr[i + 4].b,
													blurY:desArr[i + 4].b},
											   delay:1.4 - i * .2,
											   onComplete: reset, 
											   onCompleteParams: [proArr[i], i]
											   });
				}
			}
			
			
			//for (var key:String in proArr)
			//{
				//
				//if (int(key) < (6 - 2))
				//{
					//TweenMax.to(proArr[key], .8, {x: desArr[int(key) + 2].x, y: desArr[int(key) + 2].y, scaleX: desArr[int(key) + 2].sx, scaleY: desArr[int(key) + 2].sy, alpha: desArr[int(key) + 2].a});
				//}
				//else
				//{
					//TweenMax.to(proArr[key], .8, {x: desArr[int(key) + 2].x, y: desArr[int(key) + 2].y, scaleX: desArr[int(key) + 2].sx, scaleY: desArr[int(key) + 2].sy, alpha: desArr[int(key) + 2].a, onComplete: reset, onCompleteParams: [proArr[key], int(key)]});
				//}
			//}
			//
			//for (var i:int = 2; i > 0; i--)
			//{
				//var sc:mcPro = proArr[i].clone();
				//
				//sc.y = 200;
				//sc.x = 200 + i * 150;
				//sc.alpha = 0;
				//sc.scaleX = 0.4;
				//sc.scaleY = 0.4;
				//
				//sc.addEventListener(MouseEvent.CLICK, onClickHandler);
				//sc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
				//sc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
				//sc.addEventListener("detail", onShowDetailHandler);
				//
				//pList.addChild(sc);
				//
				//pList.setChildIndex(sc, 0);
				//
				//TweenMax.to(sc, .8, {x: desArr[int(i - 1)].x, y: desArr[int(i - 1)].y, scaleX: desArr[int(i - 1)].sx, scaleY: desArr[int(i - 1)].sy, alpha: desArr[int(i - 1)].a});
				//
				//proArr.unshift(sc);
			//}
				
			
			for (var i:int = 0; i < 2; i++)
			{
				var sc:mcPro = proArr[i].clone();
				
				sc.y = desArr[i].y;
				sc.x = desArr[i].x;
				sc.alpha = desArr[i].a;
				sc.scaleX = desArr[i].sx;
				sc.scaleY = desArr[i].sy;
				
				sc.addEventListener(MouseEvent.CLICK, onClickHandler);
				sc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
				sc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
				sc.addEventListener("detail", onShowDetailHandler);
				
				pList.addChild(sc);
				
				pList.setChildIndex(sc, 0);
				
				TweenMax.to(sc, .8, { x: desArr[i + 2].x,
									  y: desArr[i + 2].y, 
									  scaleX: desArr[i + 2].sx, 
									  scaleY: desArr[i + 2].sy, 
									  alpha: desArr[i + 2].a , 
									  delay:1.8 - i * .2} );
				if (i == 1) {
					proArr.splice(1, 0, sc);
				}else {
					proArr.unshift(sc);
				}
			}
			
		}
		
		private function reset(e:mcPro, key:int):void
		{
			
			pList.removeChild(e);
			proArr.pop();
		
			//e.x = desArr[5 - key].x;
			//e.y = desArr[5 - key].y;
			//e.scaleX = desArr[5 - key].sx;
			//e.scaleY = desArr[5 - key].sy;
			//e.alpha = 0;
			//
			//pList.addChild(e);
			//pList.setChildIndex(e, 0);
			//
			//proArr.unshift(e);
			//
			//TweenMax.to(e, .3, {alpha: desArr[5 - key].a});
			
			
		
		}
		
		private function loadXml(str:String):void
		{
			_urlreq = new URLRequest();
			_urlreq.url = str;
			_urlloa = new URLLoader();
			_urlloa.load(_urlreq);
			_urlloa.addEventListener(Event.COMPLETE, onCompInfoHandle);
			
		}
		
		// complete handler by load xml
		private function onCompInfoHandle(e:Event):void
		{
			xmlData = new XML(e.target.data);
			proArr = new Array;
			//desArr = new Array;
			
			var _len:int = xmlData.pro.length();
			
			for (var i:int = 0; i < 7; i++)
			{
				var myNut:mpro = new mpro(xmlData.pro[i].type, xmlData.pro[i].title, xmlData.pro[i].descrption, xmlData.pro[i].link, xmlData.pro[i].img);
				var sc:brandNut = new brandNut(myNut);
				var mc:mcPro = new mcPro(sc);
				
				mc.alpha = desArr[i+2].a;
				
				mc.x = desArr[i+2].x;
				mc.y = desArr[i+2].y;
				
				mc.num  = i+1;
				mc.addEventListener(MouseEvent.CLICK, onClickHandler);
				
				var blur:BlurFilter = new BlurFilter();  
				
　　			blur.blurX = desArr[i+2].b;
　　			blur.blurY = desArr[i].b;

　　			mc.filters = [blur]; 
				
				mc.setScale(desArr[i+2].sx);
				
				pList.addChild(mc);
				proArr.push(mc);
			}
			
			//var h:Number = 200;
			//var w:Number = 400;
			//var dis:Number = 20;
			//var a:Number = 0;
			//var sx:Number = 0.4;
			//var sy:Number = 0.4;
			//var _w:Number;
			
			//for (var i:int = 0; i < 6; i++)
			//{
				//
				//var pos:Object = new Object;
				//var myNut:mpro = new mpro(xmlData.pro[i].type, xmlData.pro[i].title, xmlData.pro[i].descrption, xmlData.pro[i].link, xmlData.pro[i].img);
				//
				//var sc:brandNut = new brandNut(myNut);
				//
				//var mc:mcPro = new mcPro(sc);
				//
				//if (i % 2 == 0)
				//{
					//h += 50;
					//w -= 110;
					//a += .35;
					//sx += .2;
					//sy += .2;
					//_w = w;
					//
				//}
				//else
				//{
					//dis += 200;
					//_w = w + dis;
				//}
				//
				//mc.x = _w;
				//mc.scaleX = sx;
				//mc.scaleY = sy;
				//mc.alpha = a;
				//mc.y = h;
				//
				//pos.a = a;
				//pos.x = _w;
				//pos.y = h;
				//pos.sx = sx;
				//pos.sy = sy;
				//
				//mc.addEventListener(MouseEvent.CLICK, onClickHandler);
				//mc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
				//mc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
				//
				//desArr.push(pos);
				//proArr.push(mc);
				//
				//mc.addEventListener("detail", onShowDetailHandler);
				//pList.addChild(mc);
			//}
			
			//for (i = 0; i < 2; i++)
			//{
				//pos = new Object;
				//if (i % 2 == 0)
				//{
					//h += 50;
					//w -= 110;
					//sx += .2;
					//sy += .2;
					//_w = w;
				//}
				//else
				//{
					//dis += 200;
					//_w = w + dis;
				//}
				//
				//pos.a = 0;
				//pos.x = _w;
				//pos.y = h;
				//pos.sx = sx;
				//pos.sy = sy;
				//
				//desArr.push(pos);
			//}
		
		}
		
		private function onRollHandler(e:MouseEvent):void
		{
			switch (e.type)
			{
				case "rollOver": 
					myTimer.stop();
					break;
				case "rollOut": 
					myTimer.start();
					break;
			}
		}
		
		private function onShowDetailHandler(e:Event):void
		{
			
			var sc:mcPro = e.target as mcPro;
			
			trace(sc.data.data.type);
			
			TweenMax.to(pList, .3, {autoAlpha: 0});
			
			TweenMax.to(pDetail, .3, {autoAlpha: 1});
			
			pDetail.loadInfo(sc.data.data.type);
		
		}
		
		private function onBackHandler(e:Event):void
		{
			
			TweenMax.to(pList, .3, {autoAlpha: 1});
			
			TweenMax.to(pDetail, .3, {autoAlpha: 0});
		}
	
	}

}

