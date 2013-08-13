package code.tool
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.EventDispatcher;
	
	public class LoadXml extends EventDispatcher
	{
		public static var COMPLETE:String = "load_XML_COMPLETE";
		public var xml:XML;
		
		public function LoadXml(path:String, Loaded:Function)
		{
			var loader:URLLoader = new URLLoader();
			var requestt:URLRequest = new URLRequest(path);
			loader.load(requestt);
			loader.addEventListener(Event.COMPLETE, onComplete);
			this.addEventListener(LoadXml.COMPLETE, Loaded)
		}
		
		private function onComplete(event:Event):void
		{
			var loader_temp:URLLoader = event.target as URLLoader;
			if (loader_temp != null)
			{
				xml = new XML(loader_temp.data);
				this.dispatchEvent(new Event(LoadXml.COMPLETE));
			}
			else
			{
				trace("错误");
			}
		}
	} 
}