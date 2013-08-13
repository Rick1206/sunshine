package code.page.brand {
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import code.tool.Reflection;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import code.GlobalVars;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import code.page.brand.thumbnail;
	import code.tool.RollTool;
	import com.greensock.TweenMax;
	
	public class nut extends MovieClip {
		
		public static const IMG_PATH:String = "images/pro.png";
		private var _reflection:Reflection;
	    private var xmlData:XML;
		
		private var _urlreq:URLRequest;
		private var _urlvar:URLVariables;
		public var _urlloa:URLLoader; 
		private var proArr:Array;
		private var desArr:Array;
		public function nut() {
			if (stage)
			{
				initAll();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initAll);
			}
		}
		
		private function initAll(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
					
			loadXml(GlobalVars.getPath() + "xml/pro.xml" + GlobalVars.getVer());
			
			btnDown.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			RollTool.setRoll(btnDown);
		}
		
		private function onClickHandler(e:MouseEvent):void 
		{	
			for (var key:String in proArr) {
				
				if(int(key)>1){
					TweenMax.to(proArr[int(key) - 2], .3, { x:desArr[key].x,
															y:desArr[key].y ,
															scaleX:desArr[key].sx ,
															scaleY:desArr[key].sy ,
															alpha:desArr[key].a
														  });
				}
			}
			
		}
		
		private function loadXml(str:String):void 
		{
			_urlreq = new URLRequest();
			_urlreq.url = str;
			_urlloa = new URLLoader();
			_urlloa.load(_urlreq);
			_urlloa.addEventListener(Event.COMPLETE,onCompInfoHandle);
		}
		// complete handler by load xml
		private function onCompInfoHandle(e:Event):void 
		{
			xmlData = new XML(e.target.data);
			proArr = new Array;
			desArr = new Array;
			
			var _len:int = xmlData.pro.length();
			
			var h:Number = 200;
			var w:Number= 400;
			var dis:Number = 20;
			var a:Number = 0;
			var sx:Number = 0.4;
			var sy:Number = 0.4;
			
			for ( var i:int = 0; i < _len; i++) {
				trace(xmlData.pro[i].img);
				var pos:Object = new Object;
				var sc:thumbnail = new thumbnail();
					sc.loadPic(xmlData.pro[i].img)
					
					if (i%2 == 0) {
						h += 50;
						w -= 110;
						a += .35;
						sx += .2;
						sy += .2;
						sc.x = w;
					}else{
						dis += 200;
						sc.x = w + dis;
					}
 					
					sc.scaleX = sx;
					sc.scaleY = sy;
					sc.alpha = a;
					sc.y = h;
					
					pos.a = sc.alpha;
					pos.x = sc.x;
					pos.y = sc.y;
					pos.sx = sc.scaleX;
					pos.sy = sc.scaleY;
					
					desArr.push(pos);
					proArr.push(sc);
				addChild(sc);
			}
		}
		
	}
	
}

