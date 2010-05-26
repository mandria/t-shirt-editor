/**
 * Products conatiner
 * Here are placed all product views 
 * 
 **/
 
 package com.ipnotica.content.blackboard.producs {
 	
	import com.ipnotica.content.blackboard.producs.product.Product;
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;

	public class Products extends MovieClip {
		
		public function Products() {
			super();
		}


		/** Add all products view */
		public function addProducts():void {
			for (var i:uint=0; i<Config.views.length(); i++) 
				addProduct(Config.views[i].@id);
			showSelectedView();
		}
		
		// Add a single product view
		private function addProduct(id:String):void {
			var product:Product = new Product(id);
			product.visible = false;
			product.name = id;
			addChild(product);
		}
		
		
		/** Show the selected view (settled up in Config.) */
		public function showSelectedView():void {
			//trace("Going to show product with ID", Config.visibleProductID);
			hideAllViews();
			showProductView();
		}
		
		// Hide all views
		private function hideAllViews():void {
			for (var i:uint=0; i<Config.views.length(); i++) {
				getChildByName(Config.views[i].@id).visible = false;
			}
		}
		
		// Show the selected one
		private function showProductView():void {
			getChildByName(Config.productVisibleID).visible = true;
		}
		
	}
}