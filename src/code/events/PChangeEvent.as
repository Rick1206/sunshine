package code.events {
	
	import flash.events.Event;
	
	public class PChangeEvent extends Event {
		
	
		public static const CHANGE:String = "CHANGE";
	
		private var _page:String;
		
		public function PChangeEvent(eventType:String, bubbles:Boolean = false, cancelable:Boolean = false) {	
			super(eventType,bubbles,cancelable);
		}
		
		public function get page():String 
		{
			return _page;
		}
		
		public function set page(value:String):void 
		{
			_page = value;
		}
		
	}
}