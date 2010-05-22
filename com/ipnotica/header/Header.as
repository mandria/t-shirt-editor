/**
 * Header container
 * 
 **/

package com.ipnotica.header {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.ipnotica.header.buttons.ImagesButton;
	import com.ipnotica.header.buttons.ProductsButton;
	import com.ipnotica.header.buttons.TextButton;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Header extends MovieClip {
		
		public var products:ProductsButton;			/**< Show list of available products (tshirt, hat, cup, ...) */
		public var images:ImagesButton;				/**< Show list of available movieclips and images */
		public var text:TextButton;					/**< Show list of available fonts */
		public var arrow:MovieClip;					/**< Give a visual feedback of the selected item */
		
		public function Header() {
			super();
			init();
		}
		
		private function init():void {
			initEvents();
		}
		
		private function initEvents():void {
			products.addEventListener(MouseEvent.CLICK, moveArrow);
			images.addEventListener(MouseEvent.CLICK, moveArrow);
			text.addEventListener(MouseEvent.CLICK, moveArrow);
		}
		
		private function moveArrow(e:Event):void {
			var newX:uint = e.currentTarget.x + 45;
			TweenLite.to(arrow, 0.4, {x: newX, ease: Quad.easeOut});
		}
		
		/** samples */
		
		/** Structure handling **/
		
		/*
		private function initStructure():void {
			products.label.text = "PRODUCTS";
			images.label.text   = "IMAGES";
			text.label.text     = "TEXT";
		}*/
		
		
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