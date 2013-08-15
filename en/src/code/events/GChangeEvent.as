package code.events
{
	
	import flash.events.Event;
	
	public class GChangeEvent extends Event
	{
		
		public static const DETAIL:String = "DETAIL";
		
		private var _gtype:String;
		
		private var _gid:String;
		
		public function GChangeEvent(eventType:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(eventType, bubbles, cancelable);
		}
		
		public function get gtype():String 
		{
			return _gtype;
		}
		
		public function set gtype(value:String):void 
		{
			_gtype = value;
		}
		
		public function get gid():String 
		{
			return _gid;
		}
		
		public function set gid(value:String):void 
		{
			_gid = value;
		}
	
	}
}