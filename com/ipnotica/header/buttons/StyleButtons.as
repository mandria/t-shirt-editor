package com.ipnotica.header.buttons {
	
	import com.greensock.TweenLite;
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class StyleButtons extends MovieClip {
		
		public var regular:MovieClip;
		public var italic:MovieClip;
		public var bold:MovieClip;
		
		private var names:Object = { "regular": "", "italic": "", "bold": "" }
		
		public function StyleButtons() {
			super();
			init();
		}
		
		private function init():void {
			initButtonMode();
			initDisabledMode();
			initFontNames();
			initEvents();
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
		
		private function initFontNames():void {
			names["regular"] = "";
			names["italic"] = "";
			names["bold"] = "";
		}
		
		private function initEvents():void {
			regular["cover"].addEventListener(MouseEvent.CLICK, function():void {setActive("regular")});
			italic["cover"].addEventListener(MouseEvent.CLICK, 	function():void {setActive("italic")});
			bold["cover"].addEventListener(MouseEvent.CLICK, 	function():void {setActive("bold")});
		}		
		
		public function setDefault(font:XML):void {
			initDisabledMode();
			initFontNames();
			for (var i:int=0; i<font.styles.style.length(); i++) {
				var style:String = font.styles.style[i].@type;
				this[style]["disable"].visible = false;
				names[style] = font.styles.style[i].@font;
			}
			setActive(font.styles.style[0].@type);
		}
		
		public function setActive(style:String):void {
			deactivateAll();
			TweenLite.to(this[style]["border"], 0.3, {tint: 0x00CBFF});
			Config.currentFontName = names[style];
			Config.body.menu.header.initInputText(Config.body.menu.header.input.text);
		}
		
		private function deactivateAll():void {
			TweenLite.to(regular["border"], 0.3, {tint: 0xCCCCCC});
			TweenLite.to(italic["border"], 0.3, {tint: 0xCCCCCC});
			TweenLite.to(bold["border"], 0.3, {tint: 0xCCCCCC});
		}
		
	}
}
