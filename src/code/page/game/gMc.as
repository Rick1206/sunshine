package code.page.game
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import code.GlobalVars;
	import code.tool.Reflection;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	public class gMc extends MovieClip
	{
		
		
		private var _imgData:BitmapData;
		
		public function gMc()
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void
		{
			var loader:Loader = new Loader();
			
				
		}
		
		public function loadInfo(title:String):void
		{
			txtTitle.text = title;
		}
		
		public function get imgData():BitmapData 
		{
			return _imgData;
		}
		
		public function set imgData(value:BitmapData):void 
		{
			_imgData = value;
		}
		
		
	}

}
