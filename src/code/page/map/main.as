package code.page.map {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import code.tool.RollTool;
	
	public class main extends MovieClip {
		public function main() {
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//mcBj.addEventListener();
			
			mcMap.mcBj.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			mcMap.mcTj.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			mcMap.mcLd.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			RollTool.setRoll(mcMap.mcBj);
			
			RollTool.setRoll(mcMap.mcTj);
			
			RollTool.setRoll(mcMap.mcLd);
			
			
			mDetail.addEventListener("back", onShowHandler);
		}
		
		private function onShowHandler(e:Event):void 
		{
			TweenMax.to(mcMap, .3, { autoAlpha:1} );
		}
		
		private function onClickHandler(e:MouseEvent):void 
		{
			  
			switch(e.currentTarget.name) {
				
				case "mcBj":
					mDetail.loadInfo("1");
					break;
				case "mcTj":
					mDetail.loadInfo("2");
					break;
				case "mcLd":
					mDetail.loadInfo("3");
					break;
			}
			
			TweenMax.to(mcMap, .3, { autoAlpha:0 } );
			
			TweenMax.to(mDetail, .3, { autoAlpha:1} );
		}
	}
	
}
