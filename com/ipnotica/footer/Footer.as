/**
 * Footer. Contains all the buttons that allow the elaboration
 * of a selected item 
 * 
 * @implementationNote All the collections (for MovieClip, TextField or Image)
 * need to be settled to 3 different frames. Lets see if it works in this way 
 * 
 **/

package com.ipnotica.footer {
	
	import com.ipnotica.footer.buttons.colorbuttons.ColorButton;
	import com.ipnotica.footer.content.FooterContent;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;

	public class Footer extends MovieClip {
		
		public var content:FooterContent;
		
		public function Footer() {
			super();
			
			
		}
		
		public function update():void {
			clear();
			content.update();
		}
		
		public function clear():void {
			clearEvents();
			this.removeChild(content);
			content = new FooterContent();
			content.y = 3;
			this.addChild(content);
		}
		
		private function clearEvents():void {
			trace("------", "Clearing everything")
			if (content.getChildByName("colorButton")) {
				trace("------", "REMOVE EVENT LISTENER")
				var colorButton:ColorButton = ColorButton(content.getChildByName("colorButton"));
				Config.doc.removeEventListener(CustomEvents.COLOR_SELECTED, colorButton.onColorSelected);
			}
		}
		
	}
}