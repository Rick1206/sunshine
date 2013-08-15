++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------/*
 * Copyright (c) 2009 Catface Games
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */ 
 
 /*
 * CacheManage.as
 * Created On: 2011-4-26 14:06
 */
 package code{
	import flash.utils.Dictionary;
	public class CacheManage {
		
		private static var m_instance:CacheManage;
		
		private var data:Dictionary=new Dictionary();
		
		/* CacheManage
		 * Use CacheManage.instance
		 * @param singleton DO NOT USE THIS - Use CacheManage.instance */
		public function CacheManage(singleton:Singleton) {
			if (singleton == null)
				throw new Error("CacheManage is a singleton class.  Access via ''CacheManage.instance''.");
		}
		/* instance
		 * Gets the CacheManage instance */
		public static function get instance():CacheManage {
 			if (CacheManage.m_instance == null)
				CacheManage.m_instance = new CacheManage(new Singleton());
 			return CacheManage.m_instance;
 		}
		
		public function getCacheById(index:*):* {
			return data[index];
		}
		
		public function addAssetById(index:*, asset:*):void {
			data[index] = asset;
		}
	}
}
 
class Singleton { }