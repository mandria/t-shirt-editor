/**
 * Contains all controls to move the slider items
 * 
 * @implementationNote This class will control the items
 * visualized through usage of dots and usage of arrows.
 * Dots will be dinamically added, arrows are placed by 
 * default and changed in theyr state  
 * 
 **/

package com.ipnotica.menu.slider.controls {
	
	import flash.display.MovieClip;

	public class SliderControls extends MovieClip {
		
		public var left:SliderControlLeft;			/**< Move to previous elements */
		public var right:SliderControlRight;      	/**< Move to next elements */
		
		public function SliderControls() {
			super();
		}
		
	}
}