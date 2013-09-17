package code.page.fruit
{
	import com.greensock.events.LoaderEvent;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import code.tool.Reflection;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.ImageLoader;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	import code.events.GChangeEvent;
	import code.GlobalVars;
	import code.ui.subLoader;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	public class mcFruit extends MovieClip
	{
		private var _pos:int = -10;
		private var _hei:int = 80;
		
		private var _imgurl:String;
		private var _type:String;
		private var _title:String;
		private var _gid:String;
		
		public function mcFruit()
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
			
			txtTitle.alpha = 0;
			btnMore.alpha = 0;
		}
		
		public function setPicRef(pos:int, hei:int,txtH:int=30,txtB=71):void
		{
			_pos = pos;
			_hei = hei;
			
			txtTitle.y = txtH;
			btnMore.y = txtB;
		}
		
		public function loadInfo(title:String, imgurl:String, type:String):void
		{
			
			_imgurl = imgurl;
			
			_title = title;
			
			_type = type;
			
			txtTitle.text = _title;
				
			var loader:ImageLoader = new ImageLoader(_imgurl, {onComplete: onImageLoad});
			
			loader.load();
			
			btnMore.addEventListener(MouseEvent.CLICK, onMoreHandler);
			btnMore.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			btnMore.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			RollTool.setRoll(btnMore);
		}
		
		private function onRollHandler(e:MouseEvent):void 
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			switch(e.type) {
				case "rollOver":
					TweenLite.to(mc.txtCopy, .3, { colorTransform: { tint:0xC74A28, tintAmount:1 } } );
					TweenLite.to(mc.Bg, .3, { colorTransform: { tint:0xFFFFFF, tintAmount:1}} );
					TweenLite.to(mc.mcArr,.3, { x:35.75,colorTransform: { tint:0xC74A28, tintAmount:1 }} );
					
					break;
				case "rollOut":
					TweenLite.to(mc.txtCopy, .3, { colorTransform: { tint:0xFFFFFF, tintAmount:1 } } );
					TweenLite.to(mc.Bg, .3, { colorTransform: { tint:0xC74A28, tintAmount:1} });
					TweenLite.to(mc.mcArr,.3, { x:33.75,colorTransform: { tint:0xFFFFFF, tintAmount:1 }} );
					break;
			}
		}
		
		private function onMoreHandler(e:MouseEvent):void
		{
			//var myEvent:GChangeEvent = new GChangeEvent("DETAIL");
			
			//myEvent.gtype = _type;
			//myEvent.gid = _gid;
			//this.dispatchEvent(myEvent);
		}
		
		private function onImageLoad(e:LoaderEvent):void
		{
			var bitmap:Bitmap = e.currentTarget.rawContent as Bitmap;
			
			bitmap.smoothing = true;
			
			var _reflection:Reflection = new Reflection(bitmap, _pos, _hei);
			
			_reflection.x = -_reflection.width / 2;
			
			_reflection.y = -_reflection.height / 2;
			
			_reflection.alpha = 0;
			addChild(_reflection);
			_reflection.y -= 30;
			
			TweenLite.to(_reflection, .5, {y:"30",alpha:1 } );
			TweenLite.to(txtTitle, .3, {alpha:1, delay:0.2 } );
			TweenLite.to(btnMore, .3, {alpha:1 ,delay:0.5 } );
			
			this.setChildIndex(btnMore, this.numChildren-1);
			
			
		}
		
		public function get gid():String 
		{
			return _gid;
		}
		
		public function set gid(value:String):void 
		{
			_gid = value;
		}
	}

}
