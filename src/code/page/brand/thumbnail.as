package code.page.brand
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.events.Event;
	import code.GlobalVars;
	import code.tool.Reflection;
		
	public class thumbnail extends Sprite
	{
		private var _reflection:Reflection;
		
		public function thumbnail() {
			
		}
		public function loadPic(str:String):void 
		{
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest(GlobalVars.getPath() + str + GlobalVars.getVer());
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImgLoadedHandle);
			loader.load(request);
			
		}
		private function onImgLoadedHandle(e:Event):void 
		{
			var img:Bitmap = e.currentTarget.content as Bitmap;
			img.smoothing = true;
			_reflection = new Reflection(img, -20, 80);
			addChild(_reflection);
		}
		
	}
	
}