package com.ipnotica.footer.buttons.rotationbuttons {
	
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class RotationButtons extends MovieClip {
		
		public var left:MovieClip;
		public var right:MovieClip;
		
		private var rotateRight:Boolean = false;
		private var rotateLeft:Boolean = false;
		
		public function RotationButtons() {
			super();
			buttonMode = true;
			init();
		}
		
		private function init():void {
			initEvents();
		}
		
		private function initEvents():void {
			left.addEventListener(MouseEvent.MOUSE_DOWN,  function():void  { rotateLeft  = true;  });
			left.addEventListener(MouseEvent.MOUSE_UP,    function():void  { rotateLeft  = false; });
			right.addEventListener(MouseEvent.MOUSE_DOWN, function():void  { rotateRight = true;  });
			right.addEventListener(MouseEvent.MOUSE_UP,   function():void  { rotateRight = false; });
			addEventListener(Event.ENTER_FRAME, moveItem);
		}
				
		private function moveItem(e:Event):void {
			// cahnge real item values
			if (rotateRight) { Config.currentItem.rotation++; }
			if (rotateLeft)  { Config.currentItem.rotation--; }
			// change structure values (to future storage)
			Config.currentItem.structure.properties.rotation = Config.currentItem.rotation;
		}
		
	}
}