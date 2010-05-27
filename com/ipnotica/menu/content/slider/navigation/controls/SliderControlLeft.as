/**
 * Move to previous items 
 * 
 **/

package com.ipnotica.menu.content.slider.navigation.controls {
	
	import flash.display.MovieClip;

	public class SliderControlLeft extends MovieClip {
		
		public var arrow:MovieClip;					/**< Arrow graphic representation */
		
		public function SliderControlLeft() {
			super();
			init();
		}
		
		private function init():void {
			stop();
			buttonMode = true;
		}
		
	}
}