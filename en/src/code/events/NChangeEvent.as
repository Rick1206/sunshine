package code.events {
	
	import flash.events.Event;
	
	public class NChangeEvent extends Event {
		
	
		public static const CHANGE:String = "CHANGE";
	
		private var _nid:String;
		
		public function NChangeEvent(eventType:String, bubbles:Boolean = false, cancelable:Boolean = false) {	
			super(eventType,bubbles,cancelable);
		}
		
		public function get nid():String 
		{
			return _nid;
		}
		
		public function set nid(value:String):void 
		{
			_nid = value;
		}
		
	}
}