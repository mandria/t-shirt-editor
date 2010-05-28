/**
 * Main container for all application. 
 * 
 * Here are added all others components that will build the applications behavior
 * 
 **/

package com.ipnotica {
	
	import com.ipnotica.content.Content;
	import com.ipnotica.footer.Footer;
	import com.ipnotica.header.Header;
	import com.ipnotica.menu.Menu;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Body extends MovieClip	{
		
		public var header:Header;				/**< Header. Here are placed the main menu functionalities */
		public var content:Content;				/**< Content. Here the tshirt and all items are placed */
		public var menu:Menu;					/**< Menu. Here there are all MC, Text and Images to choose */
		public var footer:Footer;				/**< Footer. Here are placed all functionalities to edit the items */
		
		public function Body() {
			super();
		}
		
	}
}