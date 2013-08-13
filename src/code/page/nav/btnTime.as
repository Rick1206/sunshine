package code.page.nav {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.events.PChangeEvent;
	import code.tool.RollTool;
	
	import code.GlobalVars;
	
	public class btnTime extends btn {
		private var scArr:Array;
		private var _curHeight:Number;
		
		public function btnTime() {
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
				["旅游休闲时刻","travel"],
				["办公室小憩时刻", "office"],
				["网上享乐时刻", "network"],
				["朋友聚会时刻", "friend"],
				["中秋节欢庆时刻","autumn"]
			];
			
			scArr = this.addSubText(subText, -30);
			
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
		
		private function onClickHandler(e:Event):void
		{
			var myEvent:PChangeEvent = new PChangeEvent("CHANGE");
			switch(e.currentTarget.name) {
				case "fbtn":
					myEvent.page = "time";
					for (var key:String in scArr) {
						scArr[key]..changeState(false);
					}
					break;
				case "travel":
					myEvent.page = "travel";
					GlobalVars.setTime("旅游休闲时刻");
					checkState(e.currentTarget.name);
					break;	
				case "network":
					myEvent.page = "network";
					GlobalVars.setTime("网上享乐时刻");
					checkState(e.currentTarget.name);
					break;
				case "office":
					myEvent.page = "office";
					GlobalVars.setTime("办公室小憩时刻");
					checkState(e.currentTarget.name);
					break;
				case "friend":
					myEvent.page = "friend";
					GlobalVars.setTime("朋友聚会时刻");
					checkState(e.currentTarget.name);
					break;
				case "autumn":
					myEvent.page = "autumn";
					GlobalVars.setTime("中秋节欢庆时刻");
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
