/**
 * Share a base structure for all footer buttons.
 * 
 * @implementationNote For example here will be implemented all the logic that 
 * allow the visualization of a pop-up (to help user).
 * 
 **/

package com.ipnotica.footer.buttons {
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;

	public class FooterBaseButton extends SimpleButton {
		
		public function FooterBaseButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null) {
			super(upState, overState, downState, hitTestState);
		}
		
	}
}