/**
 * Personalized Event Handling 
 * 
 * 
 * Example usage CustomEvents
 * 
 * 		// From Header.as 
 * 		...
 * 		header.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: item.@type, id: id})); 
 * 		...
 * 
 * 		// From everywhere
 * 		...	
 * 		private function initEvents():void {
 *			header.addEventListener(CustomEvents.BUTTON_HEADER_CLICK, onButtonHeaderClick);
 * 		}
 *		...
 *		private function onButtonHeaderClick(e:CustomEvents):void {
 *			trace(e.data.type);
 *		}
 * 		...
 **/    

package com.ipnotica.utils {
	
	import flash.events.Event;

	public class CustomEvents extends Event {
		
				
		/*************************/
		/** PERSONALIZED EVENTS **/
		/*************************/
		
		// XML Product
		public static const PRODUCTS_LOADED:String  = "productsLoaded";
		public static const VIEW_CHANGED:String  = "viewChanged";
		public static const ITEM_ADDED:String  = "itemAdded";
		
		
		// XML Menu
		public static const MENU_DATA_LOADED:String = "menuDataLoaded";
		public static const PAGE_CHANGED:String     = "pageChanged";
		public static const THUMB_CLICKED:String    = "thumbClicked";
		
		
		/******************/
		/** SISTEM LOGIC **/
		/******************/
		
		public var data:*;

		public function CustomEvents(type:String, data:*) {
			this.data = data;
			super(type);
		}
		
	}
}
   