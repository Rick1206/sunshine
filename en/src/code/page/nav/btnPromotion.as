package code.page.nav
{
	
	import code.events.PChangeEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	
	public class btnPromotion extends btn
	{
		
		private var _curHeight:Number;
		
		public function btnPromotion()
		{
			super();
			initAll();
		}
		
		private function initAll(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
			_curHeight = 0;
			
			fbtn.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			RollTool.setRoll(fbtn);
		}
		
		private function onClickHandler(e:Event):void
		{
			var myEvent:PChangeEvent = new PChangeEvent("CHANGE");
			switch(e.currentTarget.name) {
				case "fbtn":
					myEvent.page = "promotion";
					break;
			}
			this.dispatchEvent(myEvent);
		}
		
		public function get curHeight():Number
		{
			return _curHeight;
		}
		
		public function set curHeight(value:Number):void
		{
			_curHeight = value;
		}
	}

}
