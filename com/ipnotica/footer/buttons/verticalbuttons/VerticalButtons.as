/**
 * Move the item right or left  
 * 
 * The perfect behavior comes when we click over the button and
 * the movement start to accelerate
 **/
 
package com.ipnotica.footer.buttons.verticalbuttons {
	
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class VerticalButtons extends MovieClip {
		
		public var up:MovieClip;
		public var down:MovieClip;
		
		private var moveUp:Boolean   = false;
		private var moveDown:Boolean = false;
		
		public function VerticalButtons() {
			super();
			init();
			buttonMode = true;
		}
		
		private function init():void {
			initEvents();
		}
		
		private function initEvents():void {
			up.addEventListener(MouseEvent.MOUSE_DOWN,   function():void  { moveUp   = true;  });
			up.addEventListener(MouseEvent.MOUSE_UP,     function():void  { moveUp   = false; });
			down.addEventListener(MouseEvent.MOUSE_DOWN, function():void  { moveDown = true;  });
			down.addEventListener(MouseEvent.MOUSE_UP,   function():void  { moveDown = false; });
			addEventListener(Event.ENTER_FRAME, moveItem);
		}
		
		private function moveItem(e:Event):void {
			// cahnge real item values
			if (moveUp) { Config.currentItem.y--; }
			if (moveDown)  { Config.currentItem.y++; }
			// change structure values (to future storage)
			Config.currentItem.structure.properties.y = Config.currentItem.y;
		}
				
	}
}