/**
 * Blackboard where the drawing will take act. 
 * 
 **/

package com.ipnotica.content.blackboard {
	
	import com.ipnotica.content.blackboard.producs.Products;
	import com.ipnotica.content.blackboard.views.Views;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Blackboard extends MovieClip {
		
		public var products:Products;			/** Contains all the product views */
		public var views:Views;					/** Contains all the small views */
		
		public function Blackboard() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			Utils.setConfig(this);
			initListeners();
		}

		/** Listen when products are loaded so he can build the structure */
		private function initListeners():void {
			Config.doc.addEventListener(CustomEvents.PRODUCTS_LOADED, loadProduct);
		}
		
		/** Load all the elements related to a product */
		public function loadProduct(e:CustomEvents):void {
			if (Config.productToLoad) {
				products.addProducts();
				views.addViews(); 
				Config.productToLoad = false;
			}
			
		}

		
	}
}