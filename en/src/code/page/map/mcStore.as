package code.page.map {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import code.tool.RollTool;
	import flash.events.MouseEvent;
	
	public class mcStore extends MovieClip {
		
		private var _sid:String;
		
		public function mcStore() {
			// constructor code
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			var myShape:Shape = new Shape;
			myShape.graphics.beginFill(0xFFFFFF, 0);
			var _w:Number = this.width;
			var _h:Number = this.height;
			myShape.graphics.drawRect( -_w / 2, -_h / 2, _w, _h);
			addChild(myShape);
			
			
			sImg.visible = false;
			sImg.alpha = 0;
			
			RollTool.setRoll(this);
			
			
			this.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
		}
		
		private function onRollHandler(e:MouseEvent):void 
		{
				switch(e.type) {
					case "rollOver":
						TweenMax.to(txtTitle, .3, { x:24 } );
						break;
					case "rollOut":
						TweenMax.to(txtTitle, .3, { x:18 } );
						
						break;
				}
		}
		
		public function onSelect():void {
			
			TweenMax.to(sImg, .5, { autoAlpha:1} );
			
			TweenMax.to(txtTitle, .5, { colorTransform: { tint:0xC54A26, tintAmount:1 }} );
		}
		
		public function unSelect():void {
			
			TweenMax.to(sImg, .5, { autoAlpha:0} );
			
			TweenMax.to(txtTitle, .5, { colorTransform: { tint:0x99783F, tintAmount:1 }} );
		}
		
		public function get sid():String 
		{
			return _sid;
		}
		
		public function set sid(value:String):void 
		{
			_sid = value;
		}
	}
	
}
