package code.page
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class foot extends MovieClip
	{
		
		public function foot()
		{
			
			if (stage)
			{
				initAll();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initAll);
			}
		}
		
		private function initAll(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
			init();
		}
		
		private function init():void 
		{
			subBg.width = stage.stageWidth;
			subBg.x = 0;
			mcCopyRight.x = stage.stageWidth/2;
			if (stage.stageWidth > 1300) {
				mcPowerBy.x = stage.stageWidth / 2 + 580;
				mcShare.x = stage.stageWidth / 2 - 480;
			}else {
				mcPowerBy.x = stage.stageWidth / 2 + 330;
				mcShare.x = stage.stageWidth / 2 - 325;
			}
			
			stage.addEventListener(Event.RESIZE, updateBgStage);
		}
		
		private function updateBgStage(e:Event):void 
		{
			subBg.width = stage.stageWidth;
			subBg.x = stage.stageWidth / 2 - subBg.width/2;
			mcCopyRight.x = stage.stageWidth / 2;
			if (stage.stageWidth > 1300) {
				mcPowerBy.x = stage.stageWidth / 2 + 580;
				mcShare.x = stage.stageWidth / 2 - 480;
			}else {
				mcPowerBy.x = stage.stageWidth / 2 + 330;
				mcShare.x = stage.stageWidth / 2 - 325;
			}
			
		}
	}

}
