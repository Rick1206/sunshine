package code.page.brand
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	
	public class subDetail extends MovieClip
	{
		private var pArr:Array;
		
		public function subDetail()
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
		
		}
		public function clear():void {
			if (pArr != null)
			{
				for (var key:String in pArr)
				{
					removeChild(pArr[key]);
				}
			}
			pArr = null;
		}
		public function loadXml(data:XML):void
		{
			if (pArr != null)
			{
				for (var key:String in pArr)
				{
					removeChild(pArr[key]);
				}
			}
			pArr = new Array();
			
			txtTitle.text = data.title;
			txtDes.text = data.description;
			
			var num:int = data.pro.length();
			
			for (var i:int = 0; i < num; i++)
			{
				if (i < 3)
				{
					var sc:subProDetail = new subProDetail();
					
					sc.loadInfo(data.pro[i].title, data.pro[i].weight, data.pro[i].link, data.pro[i].img);
					
					sc.x = 130 + i * 240;
					
					addChild(sc);
					pArr.push(sc);
					
					setChildIndex(sc, 0);
				}
			}
		}
	}

}
