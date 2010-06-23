package com.ipnotica.footer.buttons.scalebuttons {
	
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ScaleButtons extends MovieClip {
		
		public var up:MovieClip;
		public var down:MovieClip;
		
		private var scaleUp:Boolean = false;
		private var scaleDown:Boolean = false;
		
		public function ScaleButtons() {
			super();
			buttonMode = true;
			init();
		}
		
		private function init():void {
			initEvents();
		}
		
		private function initEvents():void {
			up.addEventListener(MouseEvent.MOUSE_DOWN,  function():void  { scaleDown  = true;  });
			up.addEventListener(MouseEvent.MOUSE_UP,    function():void  { scaleDown  = false; });
			down.addEventListener(MouseEvent.MOUSE_DOWN, function():void  { scaleUp = true;  });
			down.addEventListener(MouseEvent.MOUSE_UP,   function():void  { scaleUp = false; });
			addEventListener(Event.ENTER_FRAME, rotateItem);
		}
				
		private function rotateItem(e:Event):void {
			// cahnge real item values
			if (scaleUp) { Config.currentItem.scaleY = Config.currentItem.scaleX = Config.currentItem.scaleX - 0.01; }
			if (scaleDown) { Config.currentItem.scaleY = Config.currentItem.scaleX = Config.currentItem.scaleX + 0.01; }
			// change structure values (to future storage)
			Config.currentItem.structure.properties.scale = Config.currentItem.scaleX;
		}
		
	}
}