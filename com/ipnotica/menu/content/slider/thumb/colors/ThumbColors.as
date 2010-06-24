package com.ipnotica.menu.content.slider.thumb.colors {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ThumbColors extends MovieClip {
		
		public var list:ThumbColorsList;			/**< list of available colors for the product **/
		private var selected:ColorIcon;
		
		private var hiddenOpacity:Number = 0.2;
		
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
			list.visible = false;
			selected.alpha = hiddenOpacity;
		}
		
		
		/**
		 * Mouse Event handling
		 **/
		private function initEvents():void {
			selected.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			selected.addEventListener(MouseEvent.MOUSE_OVER, onOut);
			selected.addEventListener(MouseEvent.CLICK, onClickSelected);
		}
		
		private function onOver(e:Event):void          { selected.alpha = 1; }
		private function onOut(e:Event):void           { selected.alpha = hiddenOpacity; }
		private function onClickSelected(e:Event):void { trace("clicked!!!"); list.visible = true; selected.visible = false; } 
		
		
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
			list.visible = false; selected.visible = true;
		}
		
	}
}