package com.ipnotica.menu.content.slider.thumb.colors {
	
	import flash.display.MovieClip;

	public class ThumbColorsList extends MovieClip {
		
		public function ThumbColorsList() {
			super();
		}
		
		public function addColor(color:XML, i:int):ColorIcon {
			
			// color icon definition
			var colorIcon:ColorIcon = new ColorIcon(color);
			colorIcon.setColor(Number(color.@color));
			addChild(colorIcon);
			
			// position definition 
			var row:int = i / 3;
			var col:int = i % 3;
			colorIcon.x = col * 21;
			colorIcon.y = row * 15;
			
			return colorIcon;
		}
		
	}
}