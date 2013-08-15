package code {
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
    import flash.net.URLRequest;

	public class mySound {
		
		public static var soundTrans:SoundTransform;
		public static var channel:SoundChannel;
		public static var snd:Sound;
		public static var position:Number;
		
		public static var state:String = "play";
		
		private static var instance:mySound;
		 
		public function mySound(content:ConSingle) {
			
		}
		public function loadMp3():void {
			
			snd = new Sound(); 
			channel = new SoundChannel();
		    soundTrans = new SoundTransform();
			
			snd.addEventListener(Event.COMPLETE, onSoundCompleteHandler);
			
			snd.load(new URLRequest(GlobalVars.getPath()+ "mysound.mp3" + GlobalVars.getVer()));
			
		}
		private	function soundCompleteHandler(e:Event):void 
		{
			soundTrans.volume = .1;
			channel.soundTransform = soundTrans;
			channel = snd.play(0);
			channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
		}
			
		private	function onSoundCompleteHandler(e:Event):void 
		{
			soundTrans.volume = .1;
			channel.soundTransform = soundTrans;
			channel = snd.play(0);
			channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
		}
		
		
		public function changeState():void {
			if (state == "play") {
				position = channel.position;
				channel.stop();
				state = "stop";
			}else {
				channel = snd.play(position);
				channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);	
				state = "play";
			}
		}
		
		public static function getInstance():mySound
        {
             if(instance == null)
             {
                 instance = new mySound(new ConSingle);
             }
             return instance;
		}
	}
}
class ConSingle
{
     
}