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
		
		/** If a thumb is clicked the pruduct item is populated with a new item */
		private function initListeners():void {
			Config.body.menu.addEventListener(CustomEvents.THUMB_CLICKED, onThumbClicked);
		}
		
		// if the current product view is the selected one, add the product
		private function onThumbClicked(e:CustomEvents):void {
			var product:Product = Product(this.parent);
			if (product.id == Config.productVisibleID) {
				var item:Item = addItem(e.data.id, e.data.type);
				setSelectedItem(item);
			}
		}
		
		/** Create and add the new item **/
		private function addItem(id:String, type:String):Item {
			var item:Item = customization.addItem(id, type);
			addChild(item);
			return item
		}
		
		/** Set a specific item as selected */
		private function setSelectedItem(item:Item):void {
			Config.currentItem = item;
			Config.body.footer.update();
		}
		
	}
}