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
		
		// Button Header
		public static const HEADER_CLICK:String = "buttonHeaderClick";
		
		
		
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
   