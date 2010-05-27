package com.ipnotica.menu.content.slider.navigation.controls {
	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class PagePrevious extends MovieClip {
		
		public var label:TextField;
		
		public function PagePrevious() {
			super();
			disable();
		}
		
		/** Disable the button */
		public function disable():void {
			buttonMode = false;
			alpha = 0.5;
			removeEventListener(MouseEvent.CLICK, previousPage);
		}
		
		/** Enable the button funcitonalities */
		public function enable():void {
			alpha = 1;
			buttonMode = true;
			addEvents();
		}
		
		// add event listener
		private function addEvents():void {
			addEventListener(MouseEvent.CLICK, previousPage);
		}
		
		// raise a new event when the page changes
		private function previousPage(e:Event):void {
			Config.currentPage -= 1;
			trace("Moving to new page", Config.currentPage);
			dispatchEvent(new CustomEvents(CustomEvents.PAGE_CHANGED, {}));
		}
		
	}
}