package code.page.map
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class mcPoint extends MovieClip
	{
		private var _address:String;
		
		public function mcPoint()
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
			
			
			
			RollTool.setRoll(this);
		}
		
		private function onBaiduMapHandler(e:MouseEvent):void
		{
			
			navigateToURL(new URLRequest("http://api.map.baidu.com/geocoder?address=" + _address + "&output=html"), "_blank");
		}
		
		public function loadInfo(title:String, telephone:String, address:String)
		{
			_address = address;
			
			txtTitle.text = title;
			txtTel.text = telephone;
			txtAdd.text = address;
			
			
			this.addEventListener(MouseEvent.CLICK, onBaiduMapHandler);
		
		}
	}

}
