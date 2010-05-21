/**
 * Header container
 * 
 **/

package com.ipnotica.header {
	
	import com.ipnotica.header.buttons.HeaderBaseButton;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Header extends MovieClip {
		
		public var products:HeaderBaseButton;			/**< Show list of available products (tshirt, hat, cup, ...) */
		public var images:HeaderBaseButton;				/**< Show list of available movieclips and images */
		public var text:HeaderBaseButton;				/**< Show list of available fonts */
		
		public function Header() {
			super();
			init();
		}
		
		private function init():void {
			initStructure();
		}
		
		
		/** Structure handling **/
		
		private function initStructure():void {
			products.label.text = "PRODUCTS";
			images.label.text   = "IMAGES";
			text.label.text     = "TEXT";
		}
		
		
		/** Events handling **/
		
		/*
		private function initEvents():void {
			products.addEventListener(MouseEvent.CLICK, onClickProduct);
			images.addEventListener(MouseEvent.CLICK, onClickImages);
			text.addEventListener(MouseEvent.CLICK, onClickText);
		}
		
		private function onClickProduct(e:Event):void {
 			products.dispatchEvent(new CustomEvents(CustomEvents.HEADER_CLICK, {type: "products"}));
		}
		
		private function onClickImages(e:Event):void {
			images.dispatchEvent(new CustomEvents(CustomEvents.HEADER_CLICK, {type: "images"}));	
		}
		
		private function onClickText(e:Event):void {
			text.dispatchEvent(new CustomEvents(CustomEvents.HEADER_CLICK, {type: "text"}));			
		}
		*/
		
	}
}