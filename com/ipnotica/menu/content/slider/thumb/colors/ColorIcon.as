package com.ipnotica.menu.content.slider.thumb.colors {
	
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;

	public class ColorIcon extends MovieClip {
		
		public var content:MovieClip;
		public var color:XML;
		
		public function ColorIcon(color:XML = null) {
			super();
			buttonMode = true;
			this.color = color;
		}
		
		public function setColor(color:Number):void {
			TweenLite.to(content, 1, {tint: color});
		}
		
	}
}