package com.ipnotica.content.blackboard.views.message {
	
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ViewMessage extends MovieClip {
		
		public var arrow:MovieClip;
		public var container:MovieClip;
		
		private var outOpacity:Number = 0.0;
		private var overOpacity:Number = 0.8;
		
		public function ViewMessage() {
			super();
			init();
		}
		
		private function init():void {
			alpha = outOpacity;
			initEvents();
		}
		
		private function initEvents():void {
			addEventListener(MouseEvent.MOUSE_OVER, onOverMessage);
			addEventListener(MouseEvent.MOUSE_OUT,  onOutMessage);
			addEventListener(MouseEvent.CLICK, 		onClickMessage);
		}
		
		private function onOverMessage(e:Event):void { alpha = overOpacity }
		private function onOutMessage(e:Event):void  { alpha = outOpacity }
		
		private function onClickMessage(e:Event):void {
			Config.body.content.blackboard.views.selector.changeProduct();
			Config.body.content.blackboard.views.selector.onRightClick(null);
			Config.body.footer.clear();
		}
		
	}
}