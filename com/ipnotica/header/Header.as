/**
 * Header container
 * 
 **/

package com.ipnotica.header {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.ipnotica.header.buttons.ImagesButton;
	import com.ipnotica.header.buttons.PriceBuyButton;
	import com.ipnotica.header.buttons.ProductsButton;
	import com.ipnotica.header.buttons.TextButton;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Header extends MovieClip {
		
		public var buy:PriceBuyButton;				/**< Button that will add the product to the cart */
		public var description:TextField;			/**< Current product description */
		
		public var products:ProductsButton;			/**< Show list of available products (tshirt, hat, cup, ...) */
		public var images:ImagesButton;				/**< Show list of available movieclips and images */
		public var text:TextButton;					/**< Show list of available fonts */
		public var arrow:MovieClip;					/**< Give a visual feedback of the selected item */
		
		public function Header() {
			super();
			init();
		}
		
		private function init():void {
			Utils.setConfig(this);
			initEvents();
			initSelectedButton();
			initListeners();
		}
		
		
		/** Handle arrow movements */
		private function initEvents():void {
			products.addEventListener(MouseEvent.CLICK, moveArrow);
			images.addEventListener(MouseEvent.CLICK, moveArrow);
			text.addEventListener(MouseEvent.CLICK, moveArrow);
		}
		
		private function moveArrow(e:Event):void {
			var newX:uint = e.currentTarget.x + 65;
			TweenLite.to(arrow, 0.4, {x: newX, ease: Quad.easeOut});
		}
		
		
		/** Define the selected button in the hader */ 
		private function initSelectedButton():void {
			TweenLite.delayedCall(0, function():void { Config.body.menu.onClickImages(null) }); // Trick. If we do not do so, the menu is still null
			images.dispatchEvent(new MouseEvent(MouseEvent.CLICK));    
		}
		
		
		/** Listen when products are loaded so he can update header content */
		private function initListeners():void {
			Config.doc.addEventListener(CustomEvents.PRODUCTS_LOADED, updateHeader);
			Config.doc.addEventListener(CustomEvents.VIEW_CHANGED, updateDescription);
			Config.doc.addEventListener(CustomEvents.ITEM_ADDED, updatePrice);
		}
		
		public function updateHeader(e:CustomEvents):void {
			updateDescription();
			updatePrice();
		}
		
		private function updateDescription(e:CustomEvents = null):void {
			description.text = Utils.productAndViewDescription();
		}
		
		private function updatePrice(e:CustomEvents = null):void {
			buy.price.text = Utils.totalPrice() + " euro"; 
		}
		
		
		
	}
}