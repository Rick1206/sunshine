package code.page.promotion {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	import code.tool.RollTool;
	
	public class spProFrame extends Sprite {
		private var _dataArr:Array;
		
		public function spProFrame(arr:Array) {
			_dataArr = arr;
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			loadInfo();
		}
		
		private function loadInfo():void 
		{
			
			mcPro1.loadInfo(_dataArr[0].imgUrl, _dataArr[0].imgLink);
			mcPro2.loadInfo(_dataArr[1].imgUrl, _dataArr[1].imgLink);
			
		}
	}
	
}
