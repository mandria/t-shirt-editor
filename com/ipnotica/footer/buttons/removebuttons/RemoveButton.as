package com.ipnotica.footer.buttons.removebuttons {
	
	import ascb.util.ArrayUtilities;
	
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class RemoveButton extends MovieClip {
		
		public function RemoveButton() {
			super();
			init();
		}
		
		private function init():void {
			initEvents();
		}
		
		private function initEvents():void {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:Event):void {
			var items:Array = Config.currentProduct.items.customization.items;
			// remove the item from the stage
			Config.currentProduct.items.removeChild(Config.currentItem);
			// remove the item from the array
			var index:Number = ArrayUtilities.findMatchIndex(items, Config.currentItem);
			items.splice(index, 1);
			// clear up the footer
			Config.body.footer.clear();
			// TODO: load the last element
			if (items.length > 0) { 
				Config.currentItem = items[items.length - 1];
				Config.body.footer.content.update();  
			}
		}
		
	}
}