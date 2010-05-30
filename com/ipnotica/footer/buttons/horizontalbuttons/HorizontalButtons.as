/**
 * Move the item right or left  
 * 
 * The perfect behavior comes when we click over the button and
 * the movement start to accelerate
 **/

package com.ipnotica.footer.buttons.horizontalbuttons {
	
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class HorizontalButtons extends MovieClip {
		
		public var left:MovieClip;
		public var right:MovieClip;
		
		private var moveRight:Boolean = false;
		private var moveLeft:Boolean = false;
		
		public function HorizontalButtons() {
			super();
			init();
		}
		
		private function init():void {
			initEvents();
		}
		
		private function initEvents():void {
			left.addEventListener(MouseEvent.MOUSE_DOWN,  function():void  { moveLeft  = true;  });
			left.addEventListener(MouseEvent.MOUSE_UP,    function():void  { moveLeft  = false; });
			right.addEventListener(MouseEvent.MOUSE_DOWN, function():void  { moveRight = true;  });
			right.addEventListener(MouseEvent.MOUSE_UP,   function():void  { moveRight = false; });
			addEventListener(Event.ENTER_FRAME, moveItem);
		}
				
		private function moveItem(e:Event):void {
			// cahnge real item values
			if (moveRight) { Config.currentItem.x++; }
			if (moveLeft)  { Config.currentItem.x--; }
			// change structure values (to future storage)
			Config.currentItem.structure.properties.x = Config.currentItem.x;
		}
		
	}
}