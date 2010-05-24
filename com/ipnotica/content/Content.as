/**
 * TShirt conatiner. 
 * Here are placed all shirts and all items used to personalize it 
 * 
 **/

package com.ipnotica.content {
	
	import com.ipnotica.content.product.Product;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;

	public class Content extends MovieClip {
		
		private var productContainer:ProductContainer;
		
		public function Content() {
			super();
			init();
		}
		
		private function init():void {
			Utils.setConfig(this);
			initListeners();
		}
		
		
		/** Listen when products are loaded so he can build the structure */
		private function initListeners():void {
			Config.doc.addEventListener(CustomEvents.PRODUCTS_LOADED, onProductsLoaded);
		}
		
		
		/** Load the content with the correct product and preview */
		public function onProductsLoaded(e:CustomEvents):void {
			Config.product 	= Utils.findProduct(Config.productID);
			Config.views 	= Config.product.views.view;
			Config.viewID 	= Config.views[0].@id; // take the first view as default
			addContent();
		}
		
		/** Create the product container and populate it */
		private function addContent():void {
			addProductContainer();
			addProducts();
			addViews();
		}
		
		// Container
		// Add the main product container and remove, if existing, the previous one
		private function addProductContainer():void {
			if (productContainer != null) { removeChild(productContainer) } // remove the existing one
			productContainer = new ProductContainer();
			productContainer.name = "productContainer";
			addChild(productContainer);
		}
		
		// Products
		// Add all products (all different views in different frames) and then set the first as default
		private function addProducts():void {
			for (var i:uint=0; i<Config.views.length(); i++) {
				productContainer.gotoAndStop(i+1);
				addProduct(Config.views[i].@id);
			}
			productContainer.gotoAndStop(1);
		}
		
		// Add a single product
		private function addProduct(id:String):void {
			var product:Product = new Product(id);
			product.name = id;
			productContainer.addChild(product)
		}
		
		// Views
		// Add all views
		private function addViews():void {
			
		}
		
		
	}
}