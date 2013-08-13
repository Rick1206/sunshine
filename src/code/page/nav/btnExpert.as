package code.page.nav {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.events.PChangeEvent;
	import code.tool.RollTool;
	
	public class btnExpert extends btn {
		
		private var _curHeight:Number;
		public function btnExpert() {
			initAll();
		}
		
		private function initAll(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
			_curHeight = 0;
			
			fbtn.addEventListener(MouseEvent.CLICK, onClickHandler);
			RollTool.setRoll(fbtn);
		}
		
		private function onClickHandler(e:MouseEvent):void 
		{
			var myEvent:PChangeEvent = new PChangeEvent("CHANGE");
			switch(e.currentTarget.name) {
				case "fbtn":
					myEvent.page = "expert";
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
