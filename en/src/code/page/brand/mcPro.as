﻿package code.page.brand
{
	
	import code.products.brandNut;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import code.tool.RollTool;
	
	public class mcPro extends MovieClip
	{
		private var _data:brandNut;
		private var _num:int;
		public function mcPro(data:brandNut)
		{	
			_data = data;
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
			_data.x = -(data.width / 2);
			_data.y = -(data.height / 2);
			proFrame.addChild(_data);
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			subInfo.visible = false;
			subInfo.alpha = 0;
			
			this.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			
			RollTool.setRoll(subInfo.btnMore);
			subInfo.btnMore.addEventListener(MouseEvent.CLICK, onShowInfoHandler);
			
			
			subInfo.tilTxt.text = data.data.title;
			subInfo.desTxt.text = data.data.description;
			
		}
		
		private function onShowInfoHandler(e:MouseEvent):void
		{
			e.stopPropagation();
			this.dispatchEvent(new Event("detail"));
		}
		
		public function setState():void {
			subInfo.subBg.gotoAndStop(2);
			subInfo.x = 105;
			subInfo.btnMore.x = 25;
			//subInfo.x = 105;
		}
		
		private function onRollHandler(e:MouseEvent):void
		{
			switch (e.type)
			{
				case "rollOver": 
					TweenMax.to(subInfo, .3, {autoAlpha: 1});
					break;
				case "rollOut": 
					TweenMax.to(subInfo, .3, {autoAlpha: 0});
					break;
			}
		}
		
		public function setScale(sn:Number=1) {
			this.scaleX = sn;
			this.scaleY = sn;
		}
		
		public function get data():brandNut 
		{
			return _data;
		}
		
		public function set data(value:brandNut):void 
		{
			_data = value;
		}
		
		public function get num():int 
		{
			return _num;
		}
		
		public function set num(value:int):void 
		{
			_num = value;
		}
		
		public function clone():mcPro 
		{
			var data:brandNut = _data.clone();
			var sc:mcPro = new mcPro(data);
			return sc;
		}
	}

}
