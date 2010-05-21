/**
 * Move to a specific "page" of items (typical carousel system)
 * 
 **/

package com.ipnotica.menu.slider.controls {
	
	import flash.display.MovieClip;

	public class SliderControlDot extends MovieClip {
		
		public var selected:MovieClip;						/**< Dot full (when selected) graphic representation */
		public var deselected:MovieClip;					/**< Dot empty (when not selected) graphic representation */
		
		public function SliderControlDot() {
			super();
			init();
		}
		
		private function init():void {
			stop();
			buttonMode = true;
		}
		
	}
}