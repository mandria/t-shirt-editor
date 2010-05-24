/**
 * Contains the tshirt image (background) and the items (MovieClip, 
 * TextFields and Images). We have an instance for every view (front, 
 * back, side dx, side sx)  
 * 
 **/

package com.ipnotica.content.product {
	
	import flash.display.MovieClip;

	public class Product extends MovieClip {
		
		public var id:String;
		public var image:ProductImage;
		public var items:ProductItems;
		
		public function Product(id:String) {
			super();
			this.id = id;
			init();
		}
		
		private function init():void {
			initImage()
			initItems();
		}
		
		private function initImage():void {
			image = new ProductImage(id);
			addChild(image);
		}
		
		private function initItems():void {
			items = new ProductItems();
			addChild(items);
		}
		
	}
}