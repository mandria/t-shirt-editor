package com.ipnotica.footer.buttons.alphabuttons {
	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class AlphaButtons extends MovieClip {
		
		public var up:MovieClip;
		public var down:MovieClip;
		
		private var alphaUp:Boolean = false;
		private var alphaDown:Boolean = false;
	
	
		public function AlphaButtons() {
			super();
			buttonMode = true;
			init();
		}
		
		private function init():void {
			initEvents();
		}
		
		private function initEvents():void {
			up.addEventListener(MouseEvent.MOUSE_DOWN,   function():void  { alphaUp  = true;  });
			up.addEventListener(MouseEvent.MOUSE_UP,     function():void  { alphaUp  = false; });
			down.addEventListener(MouseEvent.MOUSE_DOWN, function():void  { alphaDown = true;  });
			down.addEventListener(MouseEvent.MOUSE_UP,   function():void  { alphaDown = false; });
			addEventListener(Event.ENTER_FRAME, alphaItem);
			up.addEventListener(MouseEvent.MOUSE_OVER, onMouseAp);
			down.addEventListener(MouseEvent.MOUSE_OVER, onMouseAm);

		}
		
		
		private function onMouseAp(e:Event):void {
		
		//Utils.setTT(this, "transparency", "clicca il pulsante per rendere meno trasparente l'immagine");
		Utils.setTT(this, "Transparency", "Click this button to make the image less transparent");

		}
		private function onMouseAm(e:Event):void {
		
		Utils.setTT(this, "Transparency", "Click this button to make the image more transparent");
		}



		
				
		private function alphaItem(e:Event):void {
			if (Config.currentItem.myResizableMovieClip) {
				var alpha:Number 
				if (Config.currentItem.myResizableMovieClip) {
					if (alphaUp)   { 
						if (Config.currentItem.content.alpha <= 1)    { 
							alpha = Config.currentItem.content.alpha += 0.025; 
							Config.currentItem.structure.properties.alpha = Config.currentItem.content.alpha;
							Utils.initXMLClips();
						} 
					}
					if (alphaDown) { 
						if (Config.currentItem.content.alpha > 0.1)   { 
							alpha = Config.currentItem.content.alpha -= 0.025; 
							Config.currentItem.structure.properties.alpha = Config.currentItem.content.alpha;
							Utils.initXMLClips();
						} 
					}
					
				}
			}
		}		
		
	}
}