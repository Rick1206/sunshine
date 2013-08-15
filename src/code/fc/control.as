package code.fc {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import code.tool.LoadXml;
	import code.GlobalVars;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
		import code.mySound;
		import com.greensock.TweenMax;
	
	public class control extends MovieClip {
		
		private var btnArr:Array;
		private var musicState:String = "play";
		public function control() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		private function init(e:Event = null):void {
			mySound.getInstance().loadMp3();
			removeEventListener(Event.ADDED_TO_STAGE, init);		
			var cfg:LoadXml = new LoadXml(GlobalVars.getPath() + "xml/control.xml" + GlobalVars.getVer(), onLoadedHandler);
			btnArr = [btnShop, btnService, btnSearch, btnSound,btnRegion];
			
			TweenMax.to(btnSound.Bg, .5, { colorTransform: { tint:0xC54A26, tintAmount:1 }} );
			
		}
		private function onLoadedHandler(e:Event) {
			//trace(e.target.xml); 
			var _xmlDate:XML = e.target.xml;
			for (var key:String in btnArr) {	
				btnArr[key].addEventListener(MouseEvent.CLICK, onClickHandler);
				RollTool.setRoll(btnArr[key]);
			}
			
			function onClickHandler(e:MouseEvent):void {
				
				var strUrl:String = "";
				switch(e.currentTarget.name) {
					case "btnRegion":
						strUrl = "./en/";
						navigateToURL(new URLRequest(strUrl), "_self");
						break;
					case "btnShop":
						strUrl = _xmlDate.btnshop.link;
						navigateToURL(new URLRequest(strUrl), "_blank");
						break;
					case "btnService":
						strUrl = _xmlDate.btnservice.link;
						navigateToURL(new URLRequest(strUrl), "_blank");
						break;
					case "btnSearch":
						strUrl = _xmlDate.btnsearch.link;
						navigateToURL(new URLRequest(strUrl), "_blank");
						break;
					case "btnSound":						
						if (musicState == "play") {
							TweenMax.to(btnSound.Bg, .5, { colorTransform: { tint:0xE0D1B5, tintAmount:1 }} );
							musicState = "stop"
						}else {
							TweenMax.to(btnSound.Bg, .5, { colorTransform: { tint:0xC54A26, tintAmount:1 }} );
							musicState = "play";
						}
						mySound.getInstance().changeState();
						break;
				}
			}
		
		} 
	}
	
}
