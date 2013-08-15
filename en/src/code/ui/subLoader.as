package code.ui
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class subLoader extends Sprite
	{
		
		private static var instance:subLoader;
		private static var _swfUrl:String="";
		
		public function subLoader(content:ConSingle)
		{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(_swfUrl));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler)
		}
		
		public function init(url:String):void
		{
			
		}
		
		private function onCompleteHandler(e:Event):void
		{
			addChild(e.target.content);
		}
		
		public static function getInstance():subLoader
		{
			if (instance == null)
			{
				instance = new subLoader(new ConSingle);
			}
			return instance;
		}
		
		public static function get swfUrl():String 
		{
			return _swfUrl;
		}
		
		public static function set swfUrl(value:String):void 
		{
			_swfUrl = value;
		}
		
		
	}
}

class ConSingle
{

}