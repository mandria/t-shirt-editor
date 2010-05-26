/**
 * Container with the list of items we can add. 
 * 
 * - Here will be placed the slider with all available MovieClips or loaded images
 * - Here will be placed the list of fonts and the ability to define the initial value
 * 
 **/
 
 package com.ipnotica.menu {
	
	import com.ipnotica.menu.slider.Slider;
	
	import flash.display.MovieClip;

	public class MenuContent extends MovieClip {
		
		public var slider:Slider;				/**< Slider. All images, movieclips or text plus navigation system */
		
		public function MenuContent() {
			super();
		}
		
		
		
	}
}