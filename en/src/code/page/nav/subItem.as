package code.page.nav {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import com.greensock.TweenNano;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextFieldAutoSize;
	
	public class subItem extends Sprite {
		
		
		public function subItem() {
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
			
		}
		public function changeState(bol:Boolean):void {
			if (bol) {
				TweenNano.to(this.imgIcon, .3, { alpha:1 } );
			}else {
				TweenNano.to(this.imgIcon, .3, { alpha:0 } );
			}
		}
		public function test() {
			//trace(3);
		}
		public function addSubText(strTxt:String,strName:String):void {
			
			var _embeddedFonts:Array = new Array();
				_embeddedFonts = Font.enumerateFonts(false);
				//trace(_embeddedFonts[0].fontName);
			var txtFormat:TextFormat = new TextFormat(_embeddedFonts[0].fontName);
				txtFormat.color = "0xC74A28";
				txtFormat.bold = true;
			var txt:TextField = new TextField();
			//txt.autoSize = TextFieldAutoSize.NONE;
			//txt.embedFonts = true;
			//txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.selectable = false;
			txt.text = strTxt;
			txt.name = strName;
			txt.height = 18;
			txt.width = 120;
			txt.x = 12;
			txt.y = -4;
			txt.setTextFormat(txtFormat);
			addChild(txt);
		}
	}
}
