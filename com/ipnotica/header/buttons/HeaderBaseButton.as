/**
 * Base structure for all header buttons.
 * 
 * @implementationNote This is the button used to define the main functionalities
 * in the top menu. It will accept a description and other possible info 
 * 
 **/

package com.ipnotica.header.buttons {
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class HeaderBaseButton extends MovieClip {
		
		public var icon:MovieClip;
		public var label:TextField;
		
		public function HeaderBaseButton() {
			super();
			init();
		}
		
		private function init():void {
			buttonMode = true;
		}
		
	}
}