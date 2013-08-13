package  code.products
{
	/**
	 * ...
	 * @author rick
	 */
	public class mnut 
	{
		private var _title:String;
		private var _description:String;
		private var _link:String;
		private var _imgurl:String;
		
		public function mnut(title:String,description:String,link:String,imgurl:String) 
		{
			_title = title;
			_description = description;
			_link = link;
			_imgurl = imgurl;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function set title(value:String):void 
		{
			_title = value;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
		public function set description(value:String):void 
		{
			_description = value;
		}
		
		public function get link():String 
		{
			return _link;
		}
		
		public function set link(value:String):void 
		{
			_link = value;
		}
		
		public function get imgurl():String 
		{
			return _imgurl;
		}
		
		public function set imgurl(value:String):void 
		{
			_imgurl = value;
		}
		
		public function clone():mnut {
			return new mnut(_title, _description, _link,_imgurl);
		}
		
	}

}