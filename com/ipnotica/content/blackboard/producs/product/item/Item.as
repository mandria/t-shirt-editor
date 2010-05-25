/**
 * Represet a superclass for all possible items such as TextField, 
 * MovieClip and Images. Here there will be a type that represent
 * which item we are talking about and we should define a structure
 * for every item type (object) so that we can serialize it in a 
 * cookie if necessary. 
 * 
 **/

package com.ipnotica.content.blackboard.producs.product.item {
	
	import flash.display.MovieClip;

	public class Item extends MovieClip {
		
		public function Item() {
			super();
		}
		
	}
}