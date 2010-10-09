/**
 * Contains the tshirt image (background) and the items (MovieClip, 
 * TextFields and Images). We have an instance for every view (front, 
 * back, side dx, side sx)  
 * 
 **/

package com.ipnotica.content.blackboard.producs.product {
	
	import flash.display.MovieClip;

	public class Product extends MovieClip {
		
		public var id:String;
		public var XMLView:XML;
		public var image:ProductImage;
		public var items:ProductItems;
		
		public function Product(id:String, XMLView:XML) {
			super();
			this.id = id;
			this.XMLView = XMLView;
			init();
		}
		
		private function init():void {
			image.addImage(id, XMLView);
		}
		
	}
}