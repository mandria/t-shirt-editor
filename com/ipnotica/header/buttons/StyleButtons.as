package com.ipnotica.header.buttons {
	
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;

	public class StyleButtons extends MovieClip {
		
		public var regular:MovieClip;
		public var italic:MovieClip;
		public var bold:MovieClip;
		
		public function StyleButtons() {
			super();
			init();
		}
		
		private function init():void {
			initButtonMode();
			initDisabledMode();
		}
		
		private function initButtonMode():void {
			regular["cover"].buttonMode = true;
			italic["cover"].buttonMode = true;
			bold["cover"].buttonMode = true;
		}
		
		private function initDisabledMode():void {
			regular["disable"].visible = true;
			italic["disable"].visible = true;
			bold["disable"].visible = true;
		}
		
		public function setDefault(font:XML):void {
			initDisabledMode();
			for (var i:int=0; i<font.styles.style.length(); i++) {
				var style:String = font.styles.style[i].@type;
				if (i == 0) { setActive(style) }
				this[style]["disable"].visible = false;
			}
		}
		
		public function setActive(style:String):void {
			deactivateAll();
			TweenLite.to(this[style]["border"], 0.3, {tint: 0x00CBFF});
		}
		
		private function deactivateAll():void {
			TweenLite.to(regular["border"], 0.3, {tint: 0xCCCCCC});
			TweenLite.to(italic["border"], 0.3, {tint: 0xCCCCCC});
			TweenLite.to(bold["border"], 0.3, {tint: 0xCCCCCC});
		}
		
	}
}
