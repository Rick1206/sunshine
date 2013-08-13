package code
{
	import flash.display.Stage;
	
	public class GlobalVars
	{
		
		public static const WEBHOST:String = "./function_all.php";
		public static const LODING:String = "ui/mcloader.swf";
		
		public function GlobalVars()
		{
		
		}
		
		public static function getLoader():String
		{
			if (Stage.prototype.loader != null)
			{
				return Stage.prototype.loader as String;
			}
			else
			{
				return "";
			}
		}
		
		public static function setLoader(loader:String)
		{
			Stage.prototype.loader = loader;
		}
		
		public static function getWebHost():String
		{
			if (Stage.prototype.webhost != null)
			{
				return Stage.prototype.webhost as String;
			}
			else
			{
				return "";
			}
		}
		
		public static function setWebHost(webhost:String)
		{
			Stage.prototype.webhost = webhost;
		}
		
		public static function getPage():String
		{
			if (Stage.prototype.page != null)
			{
				return Stage.prototype.page as String;
			}
			else
			{
				return "";
			}
		}
		
		public static function setPage(page:String)
		{
			Stage.prototype.page = page;
		}
		
		public static function getPath():String
		{
			if (Stage.prototype.fpath != null)
			{
				return Stage.prototype.fpath as String;
			}
			else
			{
				return "";
			}
		}
		
		public static function setPath(path:String)
		{
			Stage.prototype.fpath = path;
		}
		
		public static function getVer():String
		{
			if (Stage.prototype.ver != null)
			{
				return Stage.prototype.ver;
			}
			else
			{
				return "";
			}
		}
		
		public static function setVer(ver:String)
		{
			Stage.prototype.ver = ver;
		}
		
		
		public static function getTime():String
		{
			if (Stage.prototype.time != null)
			{
				return Stage.prototype.time as String;
			}
			else
			{
				return "";
			}
		}
		
		public static function setTime(time:String)
		{
			Stage.prototype.time = time;
		}
		
		
	}
}