package com.ipnotica.footer.buttons.colorbuttons {
	
	import com.greensock.TweenLite;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;
	import flash.events.Event;


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
			TweenLite.to(icon["color"], 0, {tint: Config.currentItem.structure.properties.color});
		}
		
		private function initListeners():void {
			 Config.doc.addEventListener(CustomEvents.COLOR_SELECTED, onColorSelected);
			 addEventListener(MouseEvent.MOUSE_OVER, onMouse);
		}
		
		private function onMouse(e:Event):void {
		
		//Utils.setTT(this, "colore", "clicca questo pulsante per cambiare colore");
		Utils.setTT(this, "Color", "Click this button to change color");

		}
		
		public function onColorSelected(e:CustomEvents):void {
			changeColorButton(e.data.color);
			changeColorItem(e.data.color);
		}
		
		private function changeColorButton(color:Number):void {
			TweenLite.to(icon["color"], 1, {tint: color});
		}
		
		private function changeColorItem(color:Number):void {

			// change of color for SWFs
			if (type == "swf") {
				var layers:XMLList = Config.currentItem.itemXML.layers;
				var layer:MovieClip = Config.currentItem.content[layers.layer[0].@id]; // take the first color (think if there are more)
				TweenLite.to(layer, 1, {tint: color})
			} 
			
			// change of color for PNGs
			if (type == "png") { TweenLite.to(Config.currentItem.content, 1, {tint: color}) }
			
			// change of color for PNGs
			if (type == "texts") { TweenLite.to(Config.currentItem.content, 1, {tint: color}) }
			
			// save the color in the item structure
			Config.currentItem.structure.properties.color = color;
			Utils.initXMLClips();
		}
		
	}
}