/**
 * Container with the list of items we can add. 
 * 
 * - Here will be placed the slider with all available MovieClips or loaded images
 * - Here will be placed the list of fonts and the ability to define the initial value
 * 
 **/
 
 package com.ipnotica.menu.content {
	
	import com.ipnotica.menu.content.slider.Slider;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class MenuContent extends MovieClip {
		
		public var slider:Slider;				/**< Slider. All images, movieclips or text plus navigation system */
		
		public function MenuContent() {
			super();
		}
		
		public function clear():void {
			slider.clear();
		}

		public function update():void {
			slider.update();
		}
		
	}
}