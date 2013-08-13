package code.page.nav {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.events.PChangeEvent;
	import code.tool.RollTool;
	
	public class btnContact extends btn {
		private var scArr:Array;
		private var _curHeight:Number;
		
		public function btnContact() {
			super();
			if (stage)
			{
				initAll();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initAll);
			}
		}
		
		private function initAll(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
			
			fbtn.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			RollTool.setRoll(fbtn);
			
			var subText:Array =  [
				["购物地图","map"],
				["联系方式", "contactus"],
				["加入我们","joinus"]
			];
			
			scArr = this.addSubText(subText, -24);
			
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
		
			_curHeight = num*20;
		}
		
		
		private function onClickHandler(e:MouseEvent):void 
		{
			var myEvent:PChangeEvent = new PChangeEvent("CHANGE");
			switch(e.currentTarget.name) {
				case "fbtn":
					myEvent.page = "contact";
					//for (var key:String in scArr) {
						//scArr[key].changeState(false);
					//}
					checkState("map");
					break;
				case "map":
					myEvent.page = "map";
					trace(e.currentTarget.name);
					checkState(e.currentTarget.name);
					break;
				case "contactus":
					myEvent.page = "contactus";
					checkState(e.currentTarget.name);
					break;
				case "joinus":
					myEvent.page = "joinus";
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
