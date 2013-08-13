package code.page.control{
	
	import flash.display.MovieClip;
	
	
	public class iconNum extends MovieClip {
		
		private var _id:int;
		public function iconNum() {
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
	}
	
}
