/**
 * TShirt conatiner. 
 * Here are placed all shirts and all items used to personalize it 
 * 
 **/

package com.ipnotica.content {
	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;

	public class Content extends MovieClip {
		
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
		
		private function onProductsLoaded(e:CustomEvents):void {
			Config.product = Utils.findProduct(Config.productID);
			initContent();
		}
		
		/** Create all Movieclips to allow the tshirt personalization */
		private function initContent():void {
			// load thsirt in different frames
			// load preview in a single frame
			// the tshirt and preview need to be separated as the preview navigate with a special over object
		}
		
	}
}