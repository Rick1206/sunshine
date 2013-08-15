package code.page.control
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import code.events.PChangeEvent;
	
	public class page extends Sprite
	{
		
		private var _pageTotalCount:uint;
		private var _dataTotalCount:uint;
		private var _dataPerCount:uint;
		private var _curPage:uint = 1;
		private var _curNum:uint = 1;
		private var _curRealPage:uint;
		private var _txtPage:String;
		private var _mcArr:Array;
		private var btnArr:Array;
		
		public function page()
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
			
			btnArr = [mcLeft.btn_first, mcLeft.btn_last, mcLeft.btn_before, mcRight.btn_final, mcRight.btn_next, mcRight.btn_after];
			
			for (var key:String in btnArr)
			{
				btnArr[key].addEventListener(MouseEvent.CLICK, onClickHandle);
				btnArr[key].addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
				btnArr[key].addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
			}
			mcLeft.visible = false;
			mcRight.visible = false;
		}
		
		private function onClickHandle(e:MouseEvent):void
		{
			var myEvent:PChangeEvent = new PChangeEvent("CHANGE");
			
			switch (e.currentTarget.name)
			{
				case "btn_next": 
					if (_curNum < _dataTotalCount)
					{
						_curNum++;
						if ((_curNum % _dataPerCount) == 1)
						{
							_curPage++;
						}
						else
						{
							setNum(_curNum);
						}
						myEvent.page = String(_curNum);
						this.dispatchEvent(myEvent);
					}
					break;
				case "btn_last": 
					if (_curNum > 1)
					{
						_curNum--;
						if ((_curNum % _dataPerCount) == 0)
						{
							_curPage--;
						}
						else
						{
							setNum(_curNum);
						}
						myEvent.page = String(_curNum);
						this.dispatchEvent(myEvent);
					}
					break;
				case "btn_first": 
					_curNum = 1;
					_curPage = 1;
					myEvent.page = String(_curNum);
					this.dispatchEvent(myEvent);
					break;
				case "btn_final": 
					_curNum = _dataTotalCount;
					_curPage = _pageTotalCount
					myEvent.page = String(_curNum);
					this.dispatchEvent(myEvent);
					break;
				case "btn_before": 
					if (_curPage > 1)
					{
						_curPage--;
						_curNum = (_curPage * _dataPerCount) - (_dataPerCount - 1);
						myEvent.page = String(_curNum);
						this.dispatchEvent(myEvent);
					}
					break;
				case "btn_after": 
					if (_curPage < _pageTotalCount)
					{
						_curPage++;
						_curNum = (_curPage * _dataPerCount) - (_dataPerCount - 1);
						myEvent.page = String(_curNum);
						this.dispatchEvent(myEvent);
					}
					break;
			}
		}
		
		public function pageInit(total:int, count:int, cnum:int):void
		{
			if (_mcArr != null)
			{
				for (var key:String in _mcArr)
				{
					removeChild(_mcArr[key]);
				}
			}
			
			_dataPerCount = count;
			_dataTotalCount = total;
			_pageTotalCount = uint(Math.ceil(Number(_dataTotalCount) / Number(_dataPerCount)));
			
			_curNum = cnum;
			if (Math.floor(cnum / _dataPerCount) == 0)
			{
				_curPage = 1;
				mcLeft.visible = false;
				mcRight.visible = true;
			}
			else
			{
				_curPage = Math.ceil(cnum / _dataPerCount);
				if (_curPage == 1)
				{
					mcLeft.visible = false;
				}
				else
				{
					mcLeft.visible = true;
				}
				mcRight.visible = true;
			}
			
			var num:int;
			_mcArr = new Array();
			
			if (_dataTotalCount > 3)
			{
				if ((_curPage * _dataPerCount) > _dataTotalCount)
				{
					num = _dataTotalCount % _dataPerCount;
					mcRight.visible = false;
				}
				else
				{
					num = 3;
					if (_curPage == (_dataTotalCount / _dataPerCount))
					{
						mcRight.visible = false;
					}
				}
			}
			else
			{
				num = total;
				mcLeft.visible = false;
				mcRight.visible = false;
			}
			
			var _i:int = (_curPage * _dataPerCount) - (_dataPerCount - 1);
			
			for (var i:int = 0; i < num; i++)
			{
				var mc:iconNum = new iconNum();
				
				mc.x = i * (mc.width + 12);
				mc.txtNum.text = String(_i);
				mc.id = _i;
				if (_curNum != _i)
				{
					mc.addEventListener(MouseEvent.CLICK, onCurNumHandle);
					mc.addEventListener(MouseEvent.ROLL_OUT, onRollHandle);
					mc.addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
				}
				else
				{
					trans(mc, -80, -80, -80);
				}
				_i++;
				addChild(mc);
				_mcArr.push(mc);
				
			}
		}
		
		private function onCurNumHandle(e:MouseEvent):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			_curNum = mc.id;
			var myEvent:PChangeEvent = new PChangeEvent("CHANGE");
			myEvent.page = String(_curNum);
			this.dispatchEvent(myEvent);
			
			for (var key:String in _mcArr)
			{
				if (_mcArr[key].id == _curNum)
				{
					_mcArr[key].removeEventListener(MouseEvent.CLICK, onCurNumHandle);
					_mcArr[key].removeEventListener(MouseEvent.ROLL_OVER, onRollHandle);
					trans(_mcArr[key], -80, -80, -80);
				}
				else
				{
					_mcArr[key].addEventListener(MouseEvent.CLICK, onCurNumHandle);
					_mcArr[key].addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
					trans(_mcArr[key], 0, 0, 0);
				}
			}
		}
		
		private function setNum(num:int):void
		{
			var curNum:int = num;
			
			for (var key:String in _mcArr)
			{
				if (_mcArr[key].id == curNum)
				{
					_mcArr[key].removeEventListener(MouseEvent.CLICK, onCurNumHandle);
					_mcArr[key].removeEventListener(MouseEvent.ROLL_OVER, onRollHandle);
					trans(_mcArr[key], -80, -80, -80);
				}
				else
				{
					_mcArr[key].addEventListener(MouseEvent.CLICK, onCurNumHandle);
					_mcArr[key].addEventListener(MouseEvent.ROLL_OVER, onRollHandle);
					trans(_mcArr[key], 0, 0, 0);
				}
			}
		}
		
		private function trans(mc:MovieClip, red:Number, green:Number, blue:Number):void
		{
			var trans:ColorTransform = new ColorTransform(1, 1, 1, 1, red, green, blue, 0);
			mc.transform.colorTransform = trans;
		}
		
		private static function onRollHandle(e:MouseEvent):void
		{
			switch (e.type)
			{
				case "rollOut": 
					Mouse.cursor = MouseCursor.ARROW;
					break;
				case "rollOver": 
					Mouse.cursor = MouseCursor.BUTTON;
					break;
			}
		}
	}
}
