package code.page.time {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	
	public class subIcon extends MovieClip {
		
		private var _title:String;
		private var _description:String;
		
		public function subIcon() {
			// constructor code
			
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//trace(3);
			//parent.mouseChildren=false;
			
			btnMore.addEventListener(MouseEvent.CLICK, onShowImgHandler);
			RollTool.setRoll(btnMore);
			
		}
		
		private function onShowImgHandler(e:MouseEvent):void 
		{
			//trace(3);
			e.stopPropagation();
			this.dispatchEvent(new Event("showDetail"));
			
		}
		
		public function loadInfo(title:String, description:String):void {
			_title = title;
			_description = description;
			
			txtTitle.text = _title;
			txtDes.text = _description;
			
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function set title(value:String):void 
		{
			_title = value;
		}
	}
	
}
