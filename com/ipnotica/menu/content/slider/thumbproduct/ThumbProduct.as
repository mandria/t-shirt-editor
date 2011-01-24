// thumb to handle products list and color selection

package com.ipnotica.menu.content.slider.thumbproduct {
	
	import com.ipnotica.content.blackboard.producs.product.Product;
	import com.ipnotica.content.blackboard.producs.product.item.Item;
	import com.ipnotica.menu.content.slider.thumbproduct.colors.ColorBoxContainer;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ThumbProduct extends MovieClip	{
		
		// VISUAL
		public var image:ThumbProductImage;    		/**< Image container of the product **/
		public var colors:ColorBoxContainer;		/**< Container for all product's colors **/
		
		// INSTANCE
		public var currentProduct:XML;				/**< Current product selected **/
		public var products:XMLList;				/**< List of all products **/
		public var currentViews:XMLList; 			/**< List of all views of the selected product **/
		public var currentView:XML;		 			/**< Thumb visible view of the selected product **/
		
		
		/***********
		 * INIT
		 ***********/  
		
		public function ThumbProduct(item:XML) {
			super();
			this.currentProduct = item.node[0];
			this.products = item.node;
			init();
		}
		
		private function init():void {
			initViews();
			initThumb();
			initColors();
			initEvents();
		}
		
		public function initViews():void {
			this.currentViews = currentProduct.viste.children();
			this.currentView = this.currentViews[0]; 
		}
		
		private function initThumb():void {
			var path:String = currentView.node.node.path.text() + ".thumb60-" + currentView.node.node.filename.text();
			image.initImage(path);
		}
		
		
		/***********
		 * EVENTS
		 ***********/  
		
		private function initEvents():void {
			addEventListener(MouseEvent.CLICK, onClickThumb);
		}
		
		// click
		public function onClickThumb(e:Event = null):void {
			Config.productToLoad = true;
			// load the XML structure of the clips
			Config.existingProduct = new XML(Config.body.header.buyNow.generateXMLProduct()); // generate the XML for embedded views
			// reload the thumb
			initThumb()
			// remove all objects (texts, png, swf) loaded on the product
			cleanPreviousItems(); 
			Config.body.content.update();
			Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: "product", id: currentProduct.id, item: currentProduct}));
		}
		
		
		/*******************************
		 * Visual definition color list
		 *******************************/  
		
		private function initColors():void { 
			// Eventually allow the visualization of color (the container with 
			// a transparency in the case you need more space)
			colors.init(products);
		}
		
		
		/**********
		 * HELPERS
		 **********/
		
		private function cleanPreviousItems():void {
			var products:Array = Config.body.content.blackboard.products.list;
			for (var i:int=0; i<products.length; i++) {
				var product:Product = products[i];
				var items:Array = product.items.customization.items;
				for (var j:int=0; j<items.length; j++) {
					if (Item(items[j]).myResizableMovieClip) {
						stage.removeEventListener(MouseEvent.MOUSE_UP, Item(items[j]).myResizableMovieClip.handleStageMouseUp);
						Item(items[j]).removeChild(Item(items[j]).myResizableMovieClip);
						Item(items[j]).myResizableMovieClip = null;
						product.items.removeChild(items[j]);
						items[j] = null;
					}
				}
			}
		}
		
	}
}