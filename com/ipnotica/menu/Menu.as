/**
 * Right menu with all list selections. Here we will have the list
 * of all the MovieClip, Images and the TextField  
 * 
 **/

package com.ipnotica.menu {
	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Menu extends MovieClip {
		
		public var header:MenuHeader;				/**< Header. Controls the content (category selection or text fill) */
		public var content:MenuContent;				/**< Content. Contains all movieclips, images or texts */
		
		public function Menu() {
			super();
			init();
		}
		
		private function init():void {
			Utils.setConfig(this);
			initListeners()
			initEvents();
		}
		
		
		/** 
		 * Events  
		 * 
		 **/
		
		private function initEvents():void {
			
		}
		
		
		/**
		 * Header menu buttons click (products, images or text)
		 * 
		 **/
		   
		private function initListeners():void {
			Config.body.header.products.addEventListener(MouseEvent.CLICK, onClickProducts);
			Config.body.header.images.addEventListener(MouseEvent.CLICK, onClickImages);
			Config.body.header.text.addEventListener(MouseEvent.CLICK, onClickText);
		}
		
		private function onClickProducts(e:Event):void {
			trace("The menu has seen that you clicked the *products* selection");
		}
		
		private function onClickImages(e:Event):void {
			trace("The menu has seen that you clicked the *images* selection");
		}
		
		private function onClickText(e:Event):void {
			trace("The menu has seen that you clicked the *text* selection");
		}	
	}
}            