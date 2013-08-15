package code.page.nav {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.events.PChangeEvent;
	import code.tool.RollTool;
	
	public class btnAbout extends btn{
		
		private var scArr:Array;
		private var _curHeight:Number;
		
		public function btnAbout() {
			super();
			initAll();
		}
		
		private function initAll(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
		
			fbtn.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			RollTool.setRoll(fbtn);
			
			var subText:Array =  [
				["Bag O’ Grins Story","story"],
				["Vision and Mission", "vision"],
				["Manufacturing","production"]
			];
			
			scArr = this.addSubText(subText, -56);
			
			var num:uint = scArr.length;
			var h:Number;
			
			for (var i:uint = 0; i < num; i++) {
				if (i == 0) {
					scArr[i].changeState(false);
				}else {
					scArr[i].changeState(false);
				}
				
				scArr[i].addEventListener(MouseEvent.CLICK, onClickHandler);
				
				RollTool.setRoll(scArr[i]);
			}
		
			_curHeight = num * 20;
		}
		
		private function onClickHandler(e:Event):void
		{
			var myEvent:PChangeEvent = new PChangeEvent("CHANGE");
			switch(e.currentTarget.name) {
				case "fbtn":
					myEvent.page = "about";
					//for (var key:String in scArr) {
						//scArr[key].changeState(false);
					//}
					checkState("story");
					break;
				case "story":
					myEvent.page = "story";
					checkState(e.currentTarget.name);
					break;
				case "vision":
					myEvent.page = "vision";
					checkState(e.currentTarget.name);
					break;
				case "production":
					myEvent.page = "production";
					checkState(e.currentTarget.name);
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
