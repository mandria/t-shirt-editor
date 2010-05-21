/**
 * Footer. Contains all the buttons that allow the elaboration
 * of a selected item 
 * 
 * @implementationNote All the collections (for MovieClip, TextField or Image)
 * need to be settled to 3 different frames. Lets see if it works in this way 
 * 
 **/

package com.ipnotica.footer {
	
	import com.ipnotica.footer.groups.ImageEditGroup;
	import com.ipnotica.footer.groups.MovieClipEditGroup;
	import com.ipnotica.footer.groups.TextFieldEditGroup;
	
	import flash.display.MovieClip;

	public class Footer extends MovieClip {
		
		public var imageGroup:ImageEditGroup;				/**< Image editing functionalities */
		public var movieClipGroup:MovieClipEditGroup;		/**< MovieClip editing functionalities */
		public var textFieldGroup:TextFieldEditGroup;		/**< TextField editing functionalities */
		
		public function Footer() {
			super();
		}
		
	}
}