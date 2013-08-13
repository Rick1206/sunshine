package code.products
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import code.tool.Reflection;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import code.GlobalVars;
		
	public class brandNut extends abstractNutView
	{		
		private var _data:mpro;
		private var _reflection:Reflection;
		public function brandNut(data:mpro) 
		{
			super(data);
			_data = data;
			init();
		}
		override protected function init():void {
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest(GlobalVars.getPath() + _data.imgurl + GlobalVars.getVer());
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImgLoadedHandle);
			loader.load(request);
		}
		
		private function onImgLoadedHandle(e:Event):void 
		{
			var img:Bitmap = e.currentTarget.content as Bitmap;
			img.smoothing = true;
			_reflection = new Reflection(img, -20, 80); 
			_reflection.x = -_reflection.width / 2;
			_reflection.y = -_reflection.height / 2;
			addChild(_reflection);
			//var mc:Matrix
		}
		
		public function get data():mpro 
		{
			return _data;
		}
		
		public function set data(value:mpro):void 
		{
			_data = value;
		}
		
		public function clone():brandNut 
		{
			var _this:brandNut = new brandNut(_data);
			return _this;
		}
	}

}