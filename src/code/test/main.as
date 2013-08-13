package code.test {
	
	import flash.display.MovieClip;
	import code.products.nut;
	
	public class main extends MovieClip {
		
		
		public function main() {
			// constructor code
			
			var myNut:nut = new nut();
			myNut.getProInfo("test");
			
		}
	}
	
}
