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
		
		private var _state:String="A";
		
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
		
		private function initAll(e:Event = null):void{
			
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
			
			//desArr = new Array;
			//var blurArr:Array = [10, 10, 8, 5, 3, 0, 0, 0, 0, 0, 0];
			//desArrB = new Array;
			
			var _x:Number = 480;
			var _dis:Number = 48;
			var _x2:Number = 480;
			var _dis2:Number = 48;
			var _y:Number = 320;
			var _disY:Number = 56;
			for (var i:int = 0; i < 12; i++) {
				var pos:Object = new Object;
				if (i > 1 && i < 11) {
					pos.a = 0.3 + .1 * (i - 1);
				}else{
					//pos.a = 0;
				}
				
				//pos.b = blurArr[i];
				
				if (i % 2 == 0) {
					_dis *= 1.15;
					_x +=_dis;
					pos.x = _x; 
					_disY *= 0.8;
					_y += _disY;
					pos.y = _y;
				}else {
					_dis2 *= 1.15;
					_x2 -= _dis2;
					pos.x = _x2;
					_y -= 2;
					pos.y = _y;
				}
				
				
				pos.sx = 0.19 + .13 * (i - 1);
				pos.sy = 0.19 + .13 * (i - 1);
					
				//trace(_y);
				//if (i < 2){
					//pos.sx = 0.16;
					//pos.sy = 0.16;
				//}else{
					//pos.sx = 0.09 + .13 * (i - 1);
					//pos.sy = 0.09 + .13 * (i - 1);
				//}
				
				//trace(pos.sx);
				
				desArr.push(pos);
			}
			
			
			loadXml(GlobalVars.getPath() + "xml/product.xml" + GlobalVars.getVer());
		}
		
		private function onTimerHandler(e:TimerEvent):void
		{
			
		}
		
		private function onClickHandler(e:Event):void
		{
			var num:int = proArr.length;
			if (_state=="A") {
				
				_state = "B";
				runA();
			}else {
				runB();
				_state = "A";
			}
		}
		private function runB():void {
			var step:int = 3;

			
			for (var i:int = 0; i < 7;i++ )
			{
				if (i < 6) {
					
					if (i % 2 != 0) { 
						TweenMax.to(proArr[i], .8, { x: desArr[i + step].x, 
											   y: desArr[i + step].y, 
											   scaleX: desArr[i + step].sx, 
											   scaleY: desArr[i + step].sy, 
											   alpha: desArr[i + step].a,
											   blurFilter: {
													blurX:desArr[i + step].b,
													blurY:desArr[i + step].b},
											   delay:1.4 - i * .2 } );
					}
				
											   
				}else {
			
					TweenMax.to(proArr[i], .8, { x: desArr[i + step].x, 
												 y: desArr[i + step].y, 
											     scaleX: desArr[i + step].sx, 
											     scaleY: desArr[i + step].sy, 
											   alpha: desArr[i + step].a,
											   blurFilter: {
													blurX:desArr[i + step].b,
													blurY:desArr[i + step].b},
											   delay:1.4 - i * .2,
											   onComplete: reset, 
											   onCompleteParams: [proArr[i], i]
											   });
				}
			}
			
			for ( i = 0; i < 1; i++)
			{
				var sc:mcPro = proArr[i].clone();
				
				sc.y = desArr[0].y;
				sc.x = desArr[0].x;
				sc.alpha = desArr[0].a;
				sc.scaleX = desArr[0].sx;
				sc.scaleY = desArr[0].sy;
				
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
									  delay:1.6 - i * .2} );
					proArr.unshift(sc);
			}
			
			
		}
		private function runA():void {
			var step:int = 4;
			
			for (var i:int = 0; i < 7;i++ )
			{
				if (i < 6) {
					if(i%2 != 0){ 
						TweenMax.to(proArr[i], .8, { x: desArr[i + step].x, 
											   y: desArr[i + step].y, 
											   scaleX: desArr[i + step-1].sx, 
											   scaleY: desArr[i + step-1].sy, 
											   alpha: desArr[i + step].a,
											   blurFilter: {
													blurX:desArr[i + step].b,
													blurY:desArr[i + step].b},
											   delay:1.4 - i * .2 } );
					}else {
						TweenMax.to(proArr[i], .8, {
											   scaleX: desArr[i + step-1].sx, 
											   scaleY: desArr[i + step-1].sy, 
												blurFilter: {
													blurX:desArr[i + step-1].b,
													blurY:desArr[i + step-1].b},
											   delay:1.4 - i * .2 } );
					}
					
				}else{
					TweenMax.to(proArr[i], .8, { x: desArr[i + step].x, 
												 y: desArr[i + step].y, 
											     scaleX: desArr[i + step].sx, 
											     scaleY: desArr[i + step].sy, 
												 alpha: desArr[i + step].a,
											     blurFilter: {
													blurX:desArr[i + step].b,
													blurY:desArr[i + step].b},
											   delay:1.4 - i * .2,
											   onComplete: reset, 
											   onCompleteParams: [proArr[i], i]
											   });
				}
			}
			
			for ( i = 0; i < 1; i++)
			{
				var sc:mcPro = proArr[i].clone();
		
				sc.y = desArr[1].y;
				sc.x = desArr[1].x;
				sc.alpha = desArr[1].a;
				sc.scaleX = desArr[1].sx;
				sc.scaleY = desArr[1].sy;
				
				sc.addEventListener(MouseEvent.CLICK, onClickHandler);
				sc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
				sc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
				sc.addEventListener("detail", onShowDetailHandler);
				
				pList.addChild(sc);
				
				pList.setChildIndex(sc, 0);
				
				TweenMax.to(sc, .8, { 
									  x: desArr[i + 3].x,
									  y: desArr[i + 3].y, 
									  scaleX: desArr[i + 3].sx, 
									  scaleY: desArr[i + 3].sy, 
									  alpha: desArr[i + 3].a , 
									  delay:1.6 - i * .2 
									  } );
					proArr.unshift(sc);
			}
			
		}
		
		private function reset(e:mcPro, key:int):void
		{
			/*
			 * delete mc
			 */ 
			pList.removeChild(e);
			proArr.pop();		
		}
		
		private function loadXml(str:String):void{
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
			
			for (var i:int = 0; i < 7; i++) {
				
				var myNut:mpro = new mpro(xmlData.pro[i].type, xmlData.pro[i].title, xmlData.pro[i].descrption, xmlData.pro[i].link, xmlData.pro[i].img);
				var sc:brandNut = new brandNut(myNut);
				var mc:mcPro = new mcPro(sc);
				
				//mc.alpha = desArr[i].a;
				//mc.x = 
				//mc.y = desArr[i].y;
				//mc.num  = i+1;
				
				var blur:BlurFilter = new BlurFilter(); 
				//mc.setScale(desArr[i].sx);
				
				mc.addEventListener(MouseEvent.CLICK, onClickHandler);
				mc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
				mc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
					
				pList.addChild(mc);
				proArr.push(mc);
			}
		}
		
		private function onRollHandler(e:MouseEvent):void
		{
			switch (e.type)
			{
				case "rollOver": 
					trace(e.currentTarget.scaleY);
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

