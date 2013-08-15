package code.page.nav
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import code.page.nav.subItem;
	
	import com.greensock.TweenMax;
	
	public class btn extends MovieClip
	{
		
		private var subArr:Array;
		
		public function btn()
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
		}
		
		public function addSubText(arr:Array, x:Number):Array
		{
			subArr = new Array;
			var num:uint = arr.length;
			for (var i:int = 0; i < num; i++)
			{
				
				var scItem:subItem = new subItem();
				scItem.addSubText(arr[i][0], arr[i][1]);
				scItem.name = arr[i][1];
				scItem.x = x;
				scItem.y = 20 + i * 20;
				
				addChild(scItem);
				subArr.push(scItem);
			}
			return subArr;
		}
		
		public function cstate():void
		{
			var sc = this.getChildByName("fbtn") as MovieClip;
			sc.gotoAndStop(2);
		}
		
		public function dstate():void
		{
			var sc = this.getChildByName("fbtn") as MovieClip;
			sc.gotoAndStop(1);
		
		}
		
		public function hideSubItem():void
		{
			if (subArr != null)
			{
				for (var key:String in subArr)
				{
					TweenMax.to(subArr[key], .3, {autoAlpha: 0});
				}
			}
		}
		
		public function checkState(str:String)
		{
			for (var key:String in subArr)
			{
				if (subArr[key].name == str)
				{
					subArr[key].changeState(true);
				}
				else
				{
					subArr[key].changeState(false);
				}
			}
		}
		
		public function showSubItem():void
		{
			if (subArr != null)
			{
				for (var key:String in subArr)
				{
					TweenMax.to(subArr[key], .5, {autoAlpha: 1, delay: int(key) * .15});
				}
			}
		}
		
		public function BindClick() {
			this.mouseChildren = true;
			this.buttonMode = true;
			
		}
		
		public function unBindClick() {
			this.mouseChildren = false;
			this.buttonMode = false;
		}
	
	}

}
