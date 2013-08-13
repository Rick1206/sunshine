package code.page.nav {
	
	import code.events.PChangeEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	public class btnBrand extends btn {
		
		private var scArr:Array;
		private var _curHeight:Number;
		public function btnBrand() {
			super();
			initAll();
		}
		
		private function initAll(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
			
			fbtn.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			RollTool.setRoll(fbtn);
			
			var subText:Array =  [
				["坚果系列","nut"],
				["果干系列", "fruit"],
				["冻干系列", "freeze"],
				["礼盒包装", "gift"]
			];
			
			scArr = this.addSubText(subText, -32);
			
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
		
		private function onClickHandler(e:MouseEvent):void 
		{
			var myEvent:PChangeEvent = new PChangeEvent("CHANGE");
			switch(e.currentTarget.name) {
				case "fbtn":
					myEvent.page = "brand";
					for (var key:String in scArr) {
						scArr[key].changeState(false);
					}
					break;
				case "nut":
					myEvent.page = "nut";
					checkState(e.currentTarget.name);
					break;
				case "fruit":
					myEvent.page = "fruit";
					checkState(e.currentTarget.name);
					break;
				case "freeze":
					myEvent.page = "freeze";
					checkState(e.currentTarget.name);
					break;
				case "gift":
					myEvent.page = "gift";
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
