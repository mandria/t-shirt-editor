package com.ipnotica.footer.buttons.colorbuttons {
	
	import com.greensock.TweenLite;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;

	public class ColorButton extends MovieClip {
		
		public var icon:MovieClip;
		
		public function ColorButton() {
			super();
			buttonMode = true;
			init();
		}
		
		private function init():void {
			initListeners();
			initColorButton();
		}
		
		private function initColorButton():void {
			var layers:XMLList = Config.currentItem.itemXML.layers;
			TweenLite.to(icon["color"], 1, {tint: Number(layers.layer[0].@color)}) // take the first color (think if there are more)
		}
		
		private function initListeners():void {
			 Config.doc.addEventListener(CustomEvents.COLOR_SELECTED, onColorSelected);
		}
		
		private function onColorSelected(e:CustomEvents):void {
			changeColorButton(e.data.color);
			changeColorItem(e.data.color);
		}
		
		private function changeColorButton(color:Number):void {
			TweenLite.to(icon["color"], 1, {tint: color});
		}
		
		private function changeColorItem(color:Number):void {
			var layers:XMLList = Config.currentItem.itemXML.layers;
			var layer:MovieClip = Config.currentItem.content[layers.layer[0].@id]; // take the first color (think if there are more)
			TweenLite.to(layer, 1, {tint: color})
		}
		
	}
}