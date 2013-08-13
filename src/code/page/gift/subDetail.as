package code.page.gift
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	import flash.text.TextField;
	
	public class subDetail extends MovieClip
	{
		private var gArr:Array;
		private var infoArr:Array;
		
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
			if (gArr != null)
			{
				for (var key:String in gArr)
				{
					removeChild(gArr[key]);
				}
			}
			gArr = null;
			
			if (infoArr != null)
			{
				for (key in infoArr)
				{
					subInfo.removeChild(infoArr[key]);
				}
			}
			
			infoArr = null;
		}
		public function loadXml(data:XML,inum:int):void
		{
			if (gArr != null)
			{
				for (var key:String in gArr)
				{
					removeChild(gArr[key]);
				}
			}
			
			if (infoArr != null)
			{
				for (key in infoArr)
				{
					subInfo.removeChild(infoArr[key]);
				}
			}
			
			infoArr = new Array;
			gArr = new Array();
			
			subInfo.txtTitle.text = data.item[inum].title;
			
			//trace(data.item[inum].title);
			
			var num:int = data.item[inum].subgift.length();
			
			var sc:subGiftDetail = new subGiftDetail();
			
			switch(inum)
			{
				case 2:
					sc.setPicRef( -120, 120);
					sc.btnUrl.y = 230;
					sc.txtTitle.y = 200;
					sc.x = 100;
					sc.y = 80;
					break;
				case 3:
					sc.setPicRef(-90, 120);
					sc.btnUrl.y = 200;
					sc.txtTitle.y = 170;
					sc.x = 100;
					sc.y = 80;
					
					break;
				default:
					sc.x = 120;
					sc.y = -20;
			}
			
			
			sc.loadInfo(data.item[inum].title, data.item[inum].weight, data.item[inum].link, data.item[inum].img);
			
			addChild(sc);
			
			setChildIndex(sc, 0);
			gArr.push(sc);
			
			for (var i:int = 0; i < num; i++)
			{	
				var myText:TextField  = new TextField();
				
				myText.text = data.item[inum].subgift[i].title + " " + data.item[inum].subgift[i].weight;
				
				myText.y = 75 + i * 20;
				myText.x = 50;
				myText.textColor = 0xffffff;
				myText.width = 120;
				subInfo.addChild(myText);
				infoArr.push(myText);
				
				var mc:subGift = new subGift();
				
				mc.loadInfo(data.item[inum].subgift[i].title,data.item[inum].subgift[i].weight,data.item[inum].subgift[i].img,data.item[inum].subgift[i].thumbnail);
				//trace(inum);
				if (inum == 2) {
					mc.y = 150;
				}else {
					mc.y = 100;
				}
				
				//mc.y = 100;
				mc.x = 260 + i * 78;
				addChild(mc);
				gArr.push(mc);
				
			}
				
		}
	}

}
