package com.ipnotica.menu.content.slider.font {
	
	import com.ipnotica.content.blackboard.producs.product.item.Item;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Font extends MovieClip {
		
		public var cover:MovieClip;
		public var border:MovieClip;
		
		public var label:TextField = new TextField();
		public var fontName:String;
		public var font:XML;
		public var styles:XMLList;
		public var stylesList:Array = [];
		
		public function Font(font:XML) {
			super();
			this.font = font;
			this.styles = font.styles.style;
			init();
		}
		
		private function init():void {
			cover.buttonMode = true;
			initLabel(styles[0].@font);
			initStyles();
		}
		
		private function initLabel(font:String):void {
			fontName = font;
			label.x = 6; label.y = 7;
			label.defaultTextFormat = new TextFormat(font, 12, 0);
			label.antiAliasType = AntiAliasType.ADVANCED;
            label.autoSize = TextFieldAutoSize.NONE;
            label.width = 306;
			label.embedFonts = true;
			label.htmlText = "<p>"+ font + ": Lorem ipsum dolor sit amet, consectetur adipisicing elit</p>";
			addChild(label);
			addChild(cover);
		}
		
		private function initStyles():void {
			for (var i:int=0; i<styles.length(); i++) {
				stylesList.push({ type: styles[i].@type, font: styles[i].@font });
				trace("init " + styles[i].@type + " with font " + styles[i].@font);
			}
		}
				
	}
}