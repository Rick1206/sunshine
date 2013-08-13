package  code.products
{
	public class mpro 
	{
		private var _title:String;
		private var _description:String;
		private var _link:String;
		private var _imgurl:String;
		private var _type:String;
		
		public function mpro(type:String,title:String,description:String,link:String,imgurl:String) 
		{
			_type = type;
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
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function clone():mnut {
			return new mnut(_title, _description, _link,_imgurl);
		}
		
	}

}