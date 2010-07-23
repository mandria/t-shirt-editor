package com.ipnotica.footer.buttons.colorbuttons {
	
	import com.greensock.TweenLite;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;

	public class ColorButton extends MovieClip {
		
		public var icon:MovieClip;
		
		private var type:String;
		
		public function ColorButton(type:String) {
			super();
			this.type = type;
			buttonMode = true;
			init();
		}
		
		private function init():void {
			initListeners();
			initColorButton();
		}
		
		private function initColorButton():void {
			//if (type == "swf") {
				var layers:XMLList = Config.currentItem.itemXML.layers;
				TweenLite.to(icon["color"], 1, {tint: Number(layers.layer[0].@color)}) // take the first color (think if there are more)
			//}
		}
		
		private function initListeners():void {
			 Config.doc.addEventListener(CustomEvents.COLOR_SELECTED, onColorSelected);
		}
		
		public function onColorSelected(e:CustomEvents):void {
			changeColorButton(e.data.color);
			changeColorItem(e.data.color);
		}
		
		private function changeColorButton(color:Number):void {
			TweenLite.to(icon["color"], 1, {tint: color});
		}
		
		private function changeColorItem(color:Number):void {
			trace("------ Changing color for", type);
			
			if (type == "swf") {
				var layers:XMLList = Config.currentItem.itemXML.layers;
				var layer:MovieClip = Config.currentItem.content[layers.layer[0].@id]; // take the first color (think if there are more)
				TweenLite.to(layer, 1, {tint: color})
			} 
			
			if (type == "png") {
				TweenLite.to(Config.currentItem.content, 1, {tint: color})
			}
		}
		
	}
}