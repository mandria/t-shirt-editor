/**
 * Items container 
 * 
 **/

package com.ipnotica.content.blackboard.producs.product {
	
	import com.ipnotica.content.blackboard.producs.customization.Customization;
	import com.ipnotica.content.blackboard.producs.product.item.Item;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;

	public class ProductItems extends MovieClip {
		
		public var customization:Customization;
		
		public function ProductItems() {
			super();
			init();
		}
		
		private function init():void {
			customization = new Customization();
			initListeners();
		}
		
		private function initListeners():void {
			Config.body.menu.addEventListener(CustomEvents.THUMB_CLICKED, onThumbClicked);
		}
		
		private function onThumbClicked(e:CustomEvents):void {
			var product:Product = Product(this.parent);
			if (product.id == Config.productVisibleID) {
				trace("Catched event on one of the view", product.id ,". The type is", e.data.type, "and its id", e.data.id);
				var item:Item = customization.addItem(e.data.id, e.data.type);
				addChild(item);
			}

		}
		
	}
}