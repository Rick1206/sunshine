package code.page.time
{
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.events.LoaderEvent;
	
	import code.GlobalVars;
	
	public class mcTime extends MovieClip
	{
		
		private var _title:String;
		private var _link:String;
		private var _imgurl:String;
		
		private var _description:String;
		private var _num:int;
		
		public function mcTime()
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
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			mcInfo.visible = false;
			mcInfo.alpha = 0;
			
			//this.addEventListener(MouseEvent.ROLL_OUT, onShowInfoHandler);
			//this.addEventListener(MouseEvent.ROLL_OVER, onShowInfoHandler);
		}
		public function showInfo():void {
			TweenMax.to(mcInfo, .3, { autoAlpha: 1 } );
			this.removeEventListener(MouseEvent.ROLL_OUT, onShowInfoHandler);
			this.removeEventListener(MouseEvent.ROLL_OVER, onShowInfoHandler);
		}
		
		public function hideInfo():void {
			TweenMax.to(mcInfo, .3, { autoAlpha: 0 } );
			//this.addEventListener(MouseEvent.ROLL_OUT, onShowInfoHandler);
			//this.addEventListener(MouseEvent.ROLL_OVER, onShowInfoHandler);
		}
		
		private function onShowInfoHandler(e:MouseEvent):void
		{
			switch (e.type)
			{
				case "rollOver": 
					TweenMax.to(mcInfo, .3, {autoAlpha: 1});
					break;
				case "rollOut": 
					TweenMax.to(mcInfo, .3, {autoAlpha: 0});
					break;
			}
		}
		public function loadInfo(title:String, description:String,imgurl:String):void {
			_title = title;
			_description = description;
			_imgurl = imgurl;
			mcInfo.loadInfo(title, description);
			
			var imgLoader:ImageLoader =  new ImageLoader(GlobalVars.getPath() +
														 _imgurl + 
														 GlobalVars.getVer()
														, { onComplete:onImgLoaderHandler } );
			imgLoader.load();
		}
		
		private function onImgLoaderHandler(event:LoaderEvent):void 
		{
			 var myBitmap:Bitmap = event.target.rawContent as Bitmap;
			 myBitmap.smoothing = true;
			 mcPic.addChild(myBitmap);
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
		}
		
		public function get link():String
		{
			return _link;
		}
		
		public function set link(value:String):void
		{
			_link = value;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		public function set description(value:String):void
		{
			_description = value;
		}
		
		public function get num():int
		{
			return _num;
		}
		
		public function set num(value:int):void
		{
			_num = value;
		}
		public function clone():mcTime {
			var sc:mcTime = new mcTime();
			sc.loadInfo(_title, _description,_imgurl);
			return sc;
		}
		
	}

}
