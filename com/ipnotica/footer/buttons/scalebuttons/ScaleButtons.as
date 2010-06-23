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
			addEventListener(Event.ENTER_FRAME, scaleItem);
		}
				
		// TODO: Here the rotation can not be on the item, otherwise it has some strange effects. 
		// For this reason we act directly on the content, also if this create some problems.
		private function scaleItem(e:Event):void {
			// change real item values
			if (Config.currentItem.content) {
				if (scaleUp) { Config.currentItem.content.scaleY = Config.currentItem.content.scaleX = Config.currentItem.content.scaleX - 0.01; }
				if (scaleDown) { Config.currentItem.content.scaleY = Config.currentItem.content.scaleX = Config.currentItem.content.scaleX + 0.01; }
				// change structure values (to future storage)
				Config.currentItem.structure.properties.scale = Config.currentItem.content.scaleX;
			}
		}
		
	}
}