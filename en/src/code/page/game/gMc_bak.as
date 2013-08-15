package code.page.game
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import code.GlobalVars;
	import code.tool.Reflection;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	public class gMc extends MovieClip
	{
		//private var _this:gMc;
		//public var _this:Reflection;
		//public var _this:Sprite;
		
		private var bmd:BitmapData;
		
		private var bitmap:Bitmap;
		
		private var subArr:Array;
		
		private var _imgData:BitmapData;
		
		public function gMc()
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
			var loader:Loader = new Loader();
			
			//loader.load(new URLRequest(GlobalVars.getPath() + "images/game/pro1.png"));
			
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImgLoaderHandler);
		
		}
		
		public function loadInfo(title:String):void
		{
			txtTitle.text = title;
		}
		
		private function onImgLoaderHandler(e:Event):void
		{
			var myBitmap:Bitmap = e.target.content as Bitmap;
			
			var myRef:Reflection = new Reflection(myBitmap, -10, 30);
			addChild(myRef);
			
			//_this = new Reflection(bitMap, -10, 30);
			subArr = new Array;
			bmd = new BitmapData(myBitmap.width, myBitmap.height, true, 0x00000000);
			
			bmd.draw(myBitmap);
			
			bitmap = new Bitmap(bmd);
			
			var _this:Sprite = new Sprite();
			_this.addChild(bitmap);
			
			_this.alpha = 0;
			addChild(_this);
			subArr.push(_this);
			
			_this.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			_this.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			_this.addEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			
			_this.addEventListener(MouseEvent.MOUSE_UP, onUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUpHandler);
			
			this.dispatchEvent(new Event("addArea"));
		}
		
		private function onRollHandler(e:MouseEvent):void
		{
			switch (e.type)
			{
				case "rollOver": 
					Mouse.cursor = MouseCursor.HAND;
					break;
				case "rollOut": 
					Mouse.cursor = MouseCursor.ARROW;
					break;
			}
		}
		
		private function onDownHandler(e:MouseEvent):void
		{
			
			Mouse.cursor = MouseCursor.HAND;
			
			var sc:Sprite = e.target as Sprite;
			
			//sort(sc);
			
			sc.startDrag();
			
			e.updateAfterEvent();
			
			TweenLite.to(sc, .3, {alpha: 1});
		
		}
		
		public function gclear(sc:Sprite):void
		{
			TweenMax.to(sc, .3, {alpha: 0, onComplete: function()
				{
					//delsc(sc);
					removeChild(sc);
					reset();
				}});
		
		}
		//public function delsc(sc:Sprite):void {
			//
			//for (var key:String in subArr) {
				//if (sc == subArr[key]) {
					//trace(3);
					//subArr = subArr.slice(int(key)+1, 1);
				//}
			//}
		//}
		//
		//public function sort(sc:Sprite):void {
			//for (var key:String in subArr) {
				//if (sc != subArr[key]) {
					//setChildIndex(subArr[key], 0);
				//}
			//}
		//}
		
		public function reset():void
		{
			trace("parent");
			bitmap = new Bitmap(bmd);
			
			var _this:Sprite = new Sprite();
			_this.addChild(bitmap);
			
			_this.alpha = 0;
			this.parent.addChild(_this);
			subArr.push(_this);
			
			_this.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			_this.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			_this.addEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			
			_this.addEventListener(MouseEvent.MOUSE_UP, onUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUpHandler);
			
			dispatchEvent(new Event("addArea"));
		}
		
		private function onUpHandler(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.ARROW;
			var mc:Sprite = e.target as Sprite;
			if (mc != null)
			{
				mc.stopDrag();
			}
		}
		
		
		public function get imgData():BitmapData 
		{
			return _imgData;
		}
		
		public function set imgData(value:BitmapData):void 
		{
			_imgData = value;
		}
		
	}

}
