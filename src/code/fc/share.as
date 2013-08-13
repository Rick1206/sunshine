package code.fc {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class share extends MovieClip {
		
		private var btnArr:Array;
		
		public function share() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			btnArr = [btnMap, btnLaw, btnContact, btnFacebook, btnTwitter, btnLinkedIn, btnKaixin, btnSina, btnRenren];
			
			for (var key:String in btnArr) {
				btnArr[key].addEventListener(MouseEvent.CLICK, onClickHandler);
				RollTool.setRoll(btnArr[key]);
			}
		}
		
		private function onClickHandler(e:MouseEvent):void {
			switch(e.currentTarget.name) {
				case "btnMap":
					
					break;
				case "btnLaw":
					
					break;
				case "btnContact":
					
					break;
				case "btnFacebook":
					setShareUrl("fb","http://www.baidu.com","Welcome to our site!");
					break;
				case "btnTwitter":
					setShareUrl("twitter","http://www.baidu.com","Welcome to our site!");
					break;
				case "btnLinkedIn":
					setShareUrl("linkedin","http://www.baidu.com","Welcome to our site!");
					break;
				case "btnKaixin":
					setShareUrl("kaixin001","http://www.baidu.com","Welcome to our site!");
					break;
				case "btnSina":
					setShareUrl("tsina","http://www.baidu.com","Welcome to our site!");
					break;
				case "btnRenren":
					setShareUrl("renren","http://www.baidu.com","Welcome to our site!");
					break;
			}
			
		}
		private function setShareUrl(webid:String,url:String,title:String):void {
			var strUrl:String = "http://www.jiathis.com/send/?webid=" + webid + "&url=" + url + "&title=" + title;
			navigateToURL(new URLRequest(strUrl),"_blank");
		}
	}
	
}
