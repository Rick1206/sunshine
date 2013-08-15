package code.page.time {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import code.tool.LoadXml;
	import code.GlobalVars;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import code.tool.RollTool;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class timedetail extends MovieClip {
		
		//private var detailFrame:Sprite;
		
		private var xmlDate:XML;
		private var cw:Number=250;
		private var sc:mcDtime;
		private var _num:int;
		private var mcArr:Array;
		
		public function timedetail() {
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var xmlLoader:URLLoader = new URLLoader();
			
				xmlLoader.load(new URLRequest(GlobalVars.getPath() 
										  + "xml/timedetail.xml" 
										  + GlobalVars.getVer()));
				
				xmlLoader.addEventListener(Event.COMPLETE, onLoadedHandler);					 
			
		}
		
		
		private function setBtn():void {
			
			btnNext.addEventListener(MouseEvent.CLICK, onPageHandler);
			btnLast.addEventListener(MouseEvent.CLICK, onPageHandler);
			
			RollTool.setRoll(btnLast);
			RollTool.setRoll(btnNext);

			btnBack.addEventListener(MouseEvent.CLICK, onBackHandler);
			RollTool.setRoll(btnBack);
		}
		
		private function onPageHandler(e:MouseEvent):void 
		{
			switch(e.currentTarget.name) {
				case "btnNext":
					
					if (_num < 4) {
					_num++;
					TweenMax.to(detailFrame, .5, { x:-300, autoAlpha:0, onComplete:function() {
						detailFrame.x = 600;
						TweenMax.to(detailFrame, .5, { x:0, autoAlpha:1, onStart:function() {
							page();
							}} );
						}} );
					}
					break;
				case "btnLast":
					
					if (_num > 0) {
					_num--;
					TweenMax.to(detailFrame, .5, { x:300, autoAlpha:0, onComplete:function() {
						detailFrame.x = -600;
						TweenMax.to(detailFrame, .5, { x:0, autoAlpha:1, onStart:function() {
							page();
							} } );
						} } );
					}
					break;
					
			}
		}
		
		private function page():void {
			
			trace(mcArr.length);
			if (detailFrame.numChildren > 0) {
				trace("suc");
				for (var key:String in mcArr) {
					detailFrame.removeChild(mcArr[key]);
				}
			}
			
			mcArr = new Array;
			sc = new mcDtime();
			sc.loadInfo(GlobalVars.getPath() + xmlDate.item[_num].time[0].img + GlobalVars.getVer());
			sc.txtTitle.text = xmlDate.item[_num].time[0].title;
			sc.txt.text = xmlDate.item[_num].time[0].description;
			mcArr.push(sc);
			detailFrame.addChild(sc);
			sc.y = 235;
			cw = 250;
			sc.x = cw;
			
			onLoadTimeImgHandler(null);
		}
		private function onLoadedHandler(e:Event):void {
			
			switch(GlobalVars.getTime()) {
				case "春节欢庆时刻":
					_num = 0;
					break;
				case "朋友欢庆时刻":
					_num = 1;
					break;
				case "旅游休闲时刻":
					_num = 2;
					break;
				case "办公室小憩时刻":
					_num = 3;
					break;
				case "网上享乐时刻":
					_num = 4;
					break;
			}
			
			if (GlobalVars.getTime() == "") {
				btnBack.visible = true;
			}else {
				btnBack.visible = false;
				GlobalVars.setTime("");
			}
			
			mcArr = new Array();
			xmlDate = new XML(e.target.data);
			//detailFrame = new Sprite();
			sc = new mcDtime();
			
			sc.loadInfo(GlobalVars.getPath() + xmlDate.item[_num].time[0].img + GlobalVars.getVer());
			sc.txtTitle.text = xmlDate.item[_num].time[0].title;
			sc.txt.text = xmlDate.item[_num].time[0].description;
			
			sc.y = 235;
			sc.x = cw;
			
			//sc.addEventListener("imgLoaded", onLoadTimeImgHandler);
			
			detailFrame.addChild(sc);
			
			mcArr.push(sc);
			addChild(detailFrame);
			
			onLoadTimeImgHandler(null);
		}
	
		private function onBackHandler(e:MouseEvent):void 
		{
			TweenMax.to(this, .3, { autoAlpha:0 } );
			
			this.dispatchEvent(new Event("back"));
		}
		
		private function onLoadTimeImgHandler(e:Event):void 
		{
			cw += (323 - 20);
			
			var len:int = xmlDate.item[_num].product.length();
			
			for (var i:int = 0; i < len; i++)
			{
				var mc:mcProduct = new mcProduct;
				
				mc.loadInfo(xmlDate.item[_num].product[i].type,
							xmlDate.item[_num].product[i].title,
							xmlDate.item[_num].product[i].link,
							GlobalVars.getPath() + xmlDate.item[_num].product[i].img + GlobalVars.getVer());
							
				mc.x = cw + i * 120;
				mc.y = 400;	
				
				mcArr.push(mc);
				detailFrame.addChild(mc);
				
			}
			
			setBtn();
		}
		
		public function get num():int 
		{
			return _num;
		}
		
		public function set num(value:int):void 
		{
			_num = value;
		}
	}
	
}
