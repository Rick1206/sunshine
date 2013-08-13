package code.page.game
{
	
	import code.tool.Reflection;
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
	import code.GlobalVars;
	import code.tool.LoadXml;
	import code.GlobalVars;
	import code.tool.Reflection;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import code.tool.RollTool;
	
	public class main extends MovieClip
	{
		private var bmd:BitmapData;
		
		private var bitmap:Bitmap;
		
		private var scArr:Array;
		private var hitArr:Array;
		
		private var proF:Sprite;
		
		private var _xmlDate:XML;
		
		private var tArr:Array;
		
		private var curMc:Sprite;
		
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
			
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/product_category.xml" + GlobalVars.getVer(), onLoadedHandler);
			
			hitArr = [hitArea1, hitArea2, hitArea3, hitArea4, hitArea5, hitArea6];
			for (var key:String in hitArr)
			{
				hitArr[key].state = false;
			}
			proF = new Sprite();
			this.addChild(proF);
			
			RollTool.setRoll(btnBuy);
			RollTool.setRoll(btnBack);
			
			btnBack.addEventListener(MouseEvent.CLICK, onBackHanler);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageUpHandler);
		
		}
		
		private function onStageUpHandler(e:MouseEvent):void
		{
			if (curMc != null)
			{
				curMc.stopDrag();
				
				var res:Boolean = false;
				
				for (var key:String in hitArr)
				{
					if (curMc.hitTestObject(hitArr[key]))
					{
						res = true;
						
						break;
					}
				}
				
				if (res)
				{
					
				}
				else
				{
					
					TweenMax.to(curMc, .3, {alpha: 0, onComplete: function()
						{
							delsc(curMc);
							reset(curMc.name);
							proF.removeChild(curMc);
						
						}});
				}
			}
		}
		
		private function onBackHanler(e:MouseEvent):void
		{
			this.dispatchEvent(new Event("back"));
		}
		
		private function onLoadedHandler(e:Event):void
		{
			_xmlDate = e.target.xml;
			tArr = new Array;
			var numT:int = _xmlDate.ptype.length();
			for (var t:int = 0; t < numT; t++)
			{
				
				var mcT:mcCategory = new mcCategory();
				mcT.y = 198;
				mcT.x = 174 + t * 200;
				mcT.txtTitle.text = _xmlDate.ptype[t].title;
				
				if (t == 0)
				{
					mcT.onSelect();
				}
				addChild(mcT);
				tArr.push(mcT);
				mcT.addEventListener(MouseEvent.CLICK, onChangeCategoryHandler);
				
			}
			
			var num:int = _xmlDate.pro.length();
			
			scArr = new Array;
			for (var i:int = 0; i < num; i++)
			{
				var loader:Loader = new Loader();
				loader.load(new URLRequest(GlobalVars.getPath() + "images/game/pro1.png"));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImgLoaderHandler);
				loader.name = String(i);
			}
			
			setChildIndex(proFrame, 0);
		
		}
		
		private function onChangeCategoryHandler(e:MouseEvent):void
		{
			var sc:MovieClip = e.currentTarget as MovieClip;
			for (var key:String in tArr)
			{
				
				if (sc == tArr[key])
				{
					sc.onSelect();
				}
				else
				{
					tArr[key].unSelect();
				}
			}
		}
		
		private function onImgLoaderHandler(e:Event):void
		{
			var i:int = int(e.target.loader.name);
			var sc:gMc = new gMc();
			
			var myBitmap:Bitmap = e.target.content as Bitmap;
			
			var myRef:Reflection = new Reflection(myBitmap, -10, 30);
			
			sc.addChild(myRef);
			sc.name = "pro" + String(i);
			sc.y = 278;
			sc.x = 208 + i * 150;
			sc.loadInfo(_xmlDate.pro[i].title);
			
			proFrame.addChild(sc);
			
			bmd = new BitmapData(myBitmap.width, myBitmap.height, true, 0x00000000);
			sc.imgData = bmd;
			bmd.draw(myBitmap);
			
			bitmap = new Bitmap(bmd);
			
			var _this:Sprite = new Sprite();
			
			_this.addChild(bitmap);
			_this.alpha = 0;
			_this.y = 260;
			_this.x = 208 + i * 150;
			
			_this.addEventListener(MouseEvent.MOUSE_OVER, onRollHandler);
			_this.addEventListener(MouseEvent.MOUSE_OUT, onRollHandler);
			
			_this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			_this.addEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			
			_this.name = "pro" + String(i);
			
			proF.addChild(_this);
			
			scArr.push(_this);
		}
		
		private function onUpHandler(e:MouseEvent):void
		{
			
			Mouse.cursor = MouseCursor.ARROW;
			
			var sc:Sprite = e.target as Sprite;
			trace(sc.name);
			sc.removeEventListener(MouseEvent.MOUSE_UP, onUpHandler);
			
			var res:Boolean = false;
			var des:MovieClip;
			for (var key:String in hitArr)
			{
				if (sc.hitTestObject(hitArr[key]) && hitArr[key].state == false)
				{
					res = true;
					des = hitArr[key];
					break;
				}
			}
			
			if (res)
			{
				reset(sc.name);
				des.state = true;
				TweenLite.to(sc, .3, {x: des.x + des.width / 2 - sc.width / 2, y: des.y + des.height - sc.height});
			}
			else
			{
				
				TweenMax.to(sc, .3, {alpha: 0, onComplete: function()
					{
						delsc(sc);
						reset(sc.name);
						proF.removeChild(sc);
					
					}});
			}
			
			if (sc != null)
			{
				sc.stopDrag();
			}
		
		}
		
		public function delsc(sc:Sprite):void
		{
			for (var key:String in scArr)
			{
				if (sc == scArr[key])
				{
					scArr = scArr.slice(int(key) + 1, 1);
				}
			}
		}
		
		private function onDownHandler(e:MouseEvent):void
		{
			
			Mouse.cursor = MouseCursor.HAND;
			
			var sc:Sprite = e.target as Sprite;
			
			trace(sc.name);
			curMc = sc;
			sc.addEventListener(MouseEvent.MOUSE_UP, onUpHandler);
			
			for (var key:String in hitArr)
			{
				if (sc.hitTestObject(hitArr[key]))
				{
					hitArr[key].state = false;
				}
			}
			
			var len:int = scArr.length;
			
			proF.setChildIndex(sc, len - 1);
			
			sc.startDrag();
			
			TweenLite.to(sc, .3, {alpha: 1});
		
		}
		
		private function mouseMoveHandler(event:MouseEvent):void
		{
			event.updateAfterEvent();
		}
		
		private function onRollHandler(e:MouseEvent):void
		{
			//trace(e.type);
			switch (e.type)
			{
				case "mouseOver": 
					Mouse.cursor = MouseCursor.HAND;
					break;
				case "mouseOut": 
					Mouse.cursor = MouseCursor.ARROW;
					break;
			}
		}
		
		public function reset(name:String):void
		{
			var oriMc:MovieClip = proFrame.getChildByName(name) as MovieClip;
			var bmd:BitmapData = oriMc.imgData;
			bitmap = new Bitmap(bmd);
			
			var _this:Sprite = new Sprite();
			_this.addChild(bitmap);
			
			_this.alpha = 0;
			_this.x = oriMc.x;
			_this.y = oriMc.y;
			
			_this.name = oriMc.name;
			
			_this.addEventListener(MouseEvent.MOUSE_OVER, onRollHandler);
			_this.addEventListener(MouseEvent.MOUSE_OUT, onRollHandler);
			
			_this.addEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
			_this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			
			proF.addChild(_this);
			scArr.push(_this);
		
		}
	
	}

}
