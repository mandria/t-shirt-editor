/**
 * Contains the logic that handle the customization of a view product
 * Here there are all objects added 
 **/

package com.ipnotica.content.blackboard.producs.customization {
	
	import com.ipnotica.content.blackboard.producs.product.item.Item;
	
	import flash.display.MovieClip;

	public class Customization extends MovieClip {
		
		public var items:Array = [];
		public var selectedItem:Item;
		
		public function Customization() {
			super();
		}
		
		// Add a new item  (type Item) to the items list
		public function addItem(id:String, type:String, itemXML:XML, properties:Object = null):Item {
			var customizationItem:CustomizationItem = new CustomizationItem(id, type, itemXML, properties);
			items.push(customizationItem.item);
			return customizationItem.item;
		}
		
	}
}