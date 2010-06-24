package com.ipnotica.menu.content.slider.thumb.colors {
	
	import com.ipnotica.menu.content.slider.thumb.Thumb;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ThumbColors extends MovieClip {
		
		public var list:ThumbColorsList;			/**< list of available colors for the product **/
		
		private var selected:ColorIcon;
		
		public function ThumbColors() {
			super();
		}
		
		// load the list of colors
		public function init(item:XML, selected:ColorIcon):void {
			this.selected = selected;
			initStructure();
			initEvents();
			initColors(item);
		}
		
		
		// initial structure information 
		private function initStructure():void {
			this.visible = false;
		}
		
		
		/**
		 * Mouse Event handling
		 **/
		private function initEvents():void {
			selected.addEventListener(MouseEvent.CLICK, onClickSelected);
		}
		
		private function onClickSelected(e:Event):void { 
			this.visible = true; 
			selected.visible = false; 
		} 
		
		
		/**
		 * Create the list of colors and the mouse event handling
		 **/
		private function initColors(item:XML):void {
			selected.color = item.colors.color[0];
			selected.setColor(Number(item.colors.color[0].@color));
			for(var i:int = 0; i < item.colors.color.length(); i++) {
				var colorIcon:ColorIcon = list.addColor(item.colors.color[i], i);
				colorIcon.addEventListener(MouseEvent.CLICK, onClickColor);
			}
		}
		
		private function onClickColor(e:Event):void {
			var colorIcon:ColorIcon = ColorIcon(e.currentTarget);
			trace("You have selected the color", colorIcon.color);
			
			this.visible = false; 
			selected.visible = true;
			
			Config.currentColor = colorIcon.color;
			Config.body.content.update();
			
			// redraw the stuff that changes based on color
			selected.setColor(Number(Config.currentColor.@color))
		}
		
	}
}