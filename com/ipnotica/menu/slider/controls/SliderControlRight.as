/**
 * Move to next items 
 * 
 **/

package com.ipnotica.menu.slider.controls {
	
	import flash.display.MovieClip;

	public class SliderControlRight extends MovieClip {
		
		public var arrow:MovieClip;						/**< Arrow graphic representation */
		
		public function SliderControlRight() {
			super();
			init();
		}
		
		private function init():void {
			buttonMode = true;
		}
		
	}
}