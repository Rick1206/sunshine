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
		/*
		 * xml data
		 */
		private var xmlData:XML;
		private var _urlreq:URLRequest;
		private var _urlvar:URLVariables;
		public var _urlloa:URLLoader;
		/*
		 * store product
		 */
		private var proArr:Array;
		private var proArrL:Array;
		private var proArrR:Array;
		/*
		 * location
		 */
		//private var desArr:Array;
		//private var desArrB:Array;
		
		private var posArrL:Array;
		private var posArrR:Array;
		//private var posArrR:Array;
		
		private var _state:String = "A";
		private var myTimer:Timer;
		
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
			
			loadXml(GlobalVars.getPath() + "xml/product.xml" + GlobalVars.getVer());
		}
		
		private function onTimerHandler(e:TimerEvent):void
		{
			onClickHandler(null);
		}
		
		private function onClickHandler(e:Event):void
		{
			//var num:int = proArr.length;
			if (_state == "A")
			{
				runL();
				runR();
				_state = "B";
			}
			else
			{
				runL();
				runR();
				_state = "A";
			}	
		}
		
		public function runR():void {
			//var num:int = 
			for ( var i:int = 0; i < proArrR.length; i++) {
				if (proArrR[i].num == 7) {
					TweenMax.to(proArrR[i], .5, { 
						x:posArrR[proArrR[i].num+1].x,
						y:posArrR[proArrR[i].num+1].y,
						scaleX:posArrR[proArrR[i].num+1].s,
						scaleY:posArrR[proArrR[i].num + 1].s,
						alpha:0,
						onComplete: resetR,
						onCompleteParams: [proArrR[i], i]
					} );
				}else {
					TweenMax.to(proArrR[i], .5, { 
						x:posArrR[proArrR[i].num+1].x,
						y:posArrR[proArrR[i].num+1].y,
						scaleX:posArrR[proArrR[i].num+1].s,
						scaleY:posArrR[proArrR[i].num + 1].s,
						alpha:posArrR[proArrR[i].num + 1].a,
						onComplete: changeNum,
						onCompleteParams: [proArrR[i]]
					} );
				}	
			}
			if (_state == "B") {
			var sc:mcPro = proArrR[2].clone();
				
			sc.y = posArrR[0].y;
			sc.x = posArrR[0].x;
			sc.alpha = 0;
			sc.num = 1;
			sc.scaleX = posArrR[0].s;
			sc.scaleY = posArrR[0].s;
				
			sc.addEventListener(MouseEvent.CLICK, onClickHandler);
			sc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			sc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			sc.addEventListener("detail", onShowDetailHandler);
				
			pList.addChild(sc);
				
			pList.setChildIndex(sc, 0);
				
			TweenMax.to(sc, .8, { x: posArrR[1].x, 
								  y: posArrR[1].y, 
								  scaleX: posArrR[1].s, 
								  scaleY: posArrR[1].s,
								  alpha: posArrR[1].a } );
			proArrR.unshift(sc);
			}
			
			
			
		}
		private function runL():void 
		{
			
			for (var i:int = 0; i < proArrL.length; i++) {
				if (proArrL[i].num == 7) {
					TweenMax.to(proArrL[i], .5, { 
						x:posArrL[proArrL[i].num+1].x,
						y:posArrL[proArrL[i].num+1].y,
						scaleX:posArrL[proArrL[i].num+1].s,
						scaleY:posArrL[proArrL[i].num + 1].s,
						alpha:0,
						onComplete: resetL,
						onCompleteParams: [proArrL[i],i]
					} );
				}else {
					TweenMax.to(proArrL[i], .5, { 
						x:posArrL[proArrL[i].num+1].x,
						y:posArrL[proArrL[i].num+1].y,
						scaleX:posArrL[proArrL[i].num+1].s,
						scaleY:posArrL[proArrL[i].num + 1].s,
						alpha:posArrL[proArrL[i].num + 1].a,
						onComplete: changeNum,
						onCompleteParams: [proArrL[i]]
					} );
				}
			}
			
			if (_state == "A") {
			var sc:mcPro = proArrL[2].clone();
			sc.y = posArrL[0].y;
			sc.x = posArrL[0].x;
			sc.alpha = 0;
			sc.num = 1;
			sc.scaleX = posArrL[0].s;
			sc.scaleY = posArrL[0].s;
				
			sc.setState();
			sc.addEventListener(MouseEvent.CLICK, onClickHandler);
			sc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			sc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			sc.addEventListener("detail", onShowDetailHandler);
				
			pList.addChild(sc);
				
			pList.setChildIndex(sc, 0);
				
			TweenMax.to(sc, .8, { x: posArrL[1].x, 
								  y: posArrL[1].y, 
								  scaleX: posArrL[1].s, 
								  scaleY: posArrL[1].s,
								  alpha: posArrL[1].a } );
								  
				proArrL.unshift(sc);				  			  
			}
		}
		
		private function changeNum(e:mcPro):void
		{
			e.num += 1;
		}
		
		private function resetL(e:mcPro, key:int):void
		{
			pList.removeChild(e);
			proArrL.pop();
		}
		private function resetR(e:mcPro, key:int):void
		{
			/*
			 * delete mc
			 */
			pList.removeChild(e);
			proArrR.pop();
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
			//proArr = new Array;
			proArrL = new Array;
			proArrR = new Array;
			/*
			 * position
			 */
			posArrL = new Array;
			posArrR = new Array;
			//desArr = new Array;
			
			var _len:int = xmlData.pro.length();
			
			
			var _oriX:Number = 500;
			var _oriY:Number = 350;
			var _oriS:Number = 0.1;
			var _oriA:Number = 0.1;
			
			
			var _x:Number = 500;
			var _y:Number = 350;
			var _s:Number = 0.1;
			var _a:Number = 0.1;
			var delayInterval:Number = 0.2;
			
			for (var i:int = 0; i < 9; i++) {
				
				_x -= 40;
				_y += 25;
				_s += .14;
				_a += .2;
				if (_a > 1) {
					_a = 1;
				}
				var posObj:Object = new Object;
				posObj.a = _a;
				posObj.x = _x;
				posObj.y = _y;
				posObj.s = _s;
				posArrL.push(posObj);
				
				if (i % 2 == 0 && i > 1 && i < 8)
				{
					var myNut:mpro = new mpro(xmlData.pro[i].type, xmlData.pro[i].title, xmlData.pro[i].descrption, xmlData.pro[i].link, xmlData.pro[i].img);
					var sc:brandNut = new brandNut(myNut);
					var mc:mcPro = new mcPro(sc);
					
					mc.x = _oriX;
					mc.y = _oriY;
					mc.setScale(_oriS);
					mc.alpha = 0;
					mc.num = i;
					mc.setState();
					delayInterval += .2;
					
					TweenMax.to(mc, .8, { x:_x, y:_y, scaleX:_s, scaleY:_s, alpha:_a, delay:delayInterval } );
					
					
					trace(delayInterval);
					
					mc.addEventListener(MouseEvent.CLICK, onClickHandler);
					mc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
					mc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
					mc.addEventListener("detail", onShowDetailHandler);
					
					pList.addChild(mc);
					proArrL.push(mc);
					
				}
			}
			
			_x = 500;
			_y = 350;
			_s = 0.1;
			_a = 0.1;
			delayInterval = .2;
			
			for (i = 0; i < 9; i++)
			{
				
				_x += 40;
				_y += 25;
				_s += .14;
				_a += .2;
				
				if (_a > 1) {
					_a = 1;
				}
				
				posObj = new Object;
				posObj.a = _a
				posObj.x = _x;
				posObj.y = _y;
				posObj.s = _s;
				
				posArrR.push(posObj);
				
				if (i % 2 != 0 && i > 0)
				{
					
					myNut = new mpro(xmlData.pro[i].type, xmlData.pro[i].title, xmlData.pro[i].descrption, xmlData.pro[i].link, xmlData.pro[i].img);
					sc = new brandNut(myNut);
					mc = new mcPro(sc);
					
					mc.x = _oriX;
					mc.y = _oriY;
					mc.setScale(_oriS);
					mc.alpha = 0;
					mc.num = i;
					
					delayInterval += .2;
					TweenMax.to(mc, .8, { x:_x, y:_y, scaleX:_s, scaleY:_s, alpha:_a,delay:delayInterval } );

					//blurFilter
					//blur = new BlurFilter();
					
					mc.addEventListener(MouseEvent.CLICK, onClickHandler);
					mc.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
					mc.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
					mc.addEventListener("detail", onShowDetailHandler);
					
					pList.addChild(mc);
					proArrR.push(mc);
					
				}
				
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
			
			TweenMax.to(pList, .3, { autoAlpha: 0 } );
			
			TweenMax.to(pDetail, .3, { autoAlpha: 1 } );
			
			pDetail.loadInfo(sc.data.data.type);
		}
		
		private function onBackHandler(e:Event):void
		{
			TweenMax.to(pList, .3, {autoAlpha: 1});
			TweenMax.to(pDetail, .3, {autoAlpha: 0});
		}
	
	}

}

