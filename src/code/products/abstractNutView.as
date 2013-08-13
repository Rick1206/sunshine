package code.products
{
	import flash.display.Sprite;
	import code.tool.Reflection;
	import flash.events.Event;
	
	public class abstractNutView extends Sprite
	{		
		protected var _nut:mpro;
		
		public function abstractNutView(data:mpro) 
		{
			_nut = data;
		}
		protected function init():void {
			
		}
	}

}