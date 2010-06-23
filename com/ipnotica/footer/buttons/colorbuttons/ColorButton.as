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
		}
		
		private function initListeners():void {
			 Config.doc.addEventListener(CustomEvents.COLOR_SELECTED, onColorSelected);
		}
		
		private function onColorSelected(e:CustomEvents):void {
			TweenLite.to(icon["color"], 1, {tint: e.data.color});
		}
		
	}
}