/**
 * Personalized Event Handling 
 * 
 **/    

package com.ipnotica.utils {
	
	import flash.events.Event;

	public class CustomEvents extends Event {
		
				
		/*************************/
		/** PERSONALIZED EVENTS **/
		/*************************/
		
		// XML Product
		public static const PRODUCTS_LOADED:String = "productsLoaded";
		
		// XML Menu
		public static const MENU_DATA_LOADED:String = "menuDataLoaded";
		
		
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
   