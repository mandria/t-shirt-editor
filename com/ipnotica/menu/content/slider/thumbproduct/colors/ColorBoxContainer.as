package com.ipnotica.menu.content.slider.thumbproduct.colors {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ColorBoxContainer extends MovieClip {
		
		// INSTANCE
		public var products:XMLList;

		// CONFIGURATION
		public var hiddenAlpha:Number = 0.2;		/**< Alpha value when the color icon is not selected **/
		public var visibleAlpha:Number = 1;			/**< Alpha value when the color icon is over **/

		
		/********
		 * INIT
		 *******/
		
		public function ColorBoxContainer() {
			super();
		}
		
		public function init(products:XMLList):void {
			this.products = products;
			initVisuals();
			initEvents();
			initColors();
		}
		
		
		/**********
		 * VISUALS 
		 **********/
		
		private function initVisuals():void {
			onOut(null);
		}
		
		
		/*********
		 * EVENTS
		 *********/
		
		private function initEvents():void {
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		// over 
		private function onOver(e:Event):void { 
			alpha = visibleAlpha; 
		}
		
		// out
		private function onOut(e:Event):void  { 
			alpha = hiddenAlpha; 
		}
		
		
		/********************************
		 * VISUAL DEFINITION COLOR LIST 
		 ********************************/
		
		private function initColors():void {
			for (var i:int = 0; i < products.length(); i++) {
				var colorBox:ColorBox = new ColorBox(products[i]);
				initVisualsColorBox(colorBox, i);
			}
		}
		
		// visuals color box
		private function initVisualsColorBox(colorBox:ColorBox, i:uint):void {
			addChild(colorBox);
			var row:int = i / 3;
			var col:int = i % 3;
			colorBox.x = col * 21;
			colorBox.y = row * 15;
		}
		
	}
}