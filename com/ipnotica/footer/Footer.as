/**
 * Footer. Contains all the buttons that allow the elaboration
 * of a selected item 
 * 
 * @implementationNote All the collections (for MovieClip, TextField or Image)
 * need to be settled to 3 different frames. Lets see if it works in this way 
 * 
 **/

package com.ipnotica.footer {
	
	import com.ipnotica.footer.content.FooterContent;
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;

	public class Footer extends MovieClip {
		
		public var content:FooterContent;
		
		public function Footer() {
			super();
		}
		
		public function update():void {
			trace("Updating footer. The selected element is",Config.currentItem.structure.id);
			clear();
			content.update();
		}
		
		public function clear():void {
			this.removeChild(content);
			content = new FooterContent();
			this.addChild(content);
		}
		
	}
}