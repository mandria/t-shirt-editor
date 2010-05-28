/**
 * Contains the logic that handle the customization of a view product
 * Here there are all objects added 
 **/

package com.ipnotica.content.blackboard.producs.customization {
	
	import com.ipnotica.content.blackboard.producs.product.item.Item;
	
	import flash.display.MovieClip;

	public class Customization extends MovieClip {
		
		public var items:Array = [];
		
		public function Customization() {
			super();
		}
		
		// Add a new item to the items list
		public function addItem(id:String, type:String):Item {
			var customizationItem:CustomizationItem = new CustomizationItem(id, type);
			items.push(customizationItem.item);
			return customizationItem.item;
		}
		
	}
}