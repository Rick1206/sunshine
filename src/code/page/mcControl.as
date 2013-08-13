package code.page {
	
	import flash.display.MovieClip;
	
	
	public class mcControl extends MovieClip {
		
		private var _num:String;
		public function mcControl() {
			// constructor code
		}
		
		public function get num():String 
		{
			return _num;
		}
		
		public function set num(value:String):void 
		{
			_num = value;
			txt.text = _num;
		}
		
		public function init(num:int):void {
			
		}
		
	}
	
}
