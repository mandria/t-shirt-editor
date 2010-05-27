package com.ipnotica.menu.content.slider.navigation.controls {
	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class PageNumber extends MovieClip {
		
		public var label:TextField;
		public var border:MovieClip;
		public var borderSelected:MovieClip;
		
		public var page:uint; 			/** get the page number to handle (start from 0, 1, ... n) */
		
		public function PageNumber(page:uint = 10) {
			super();
			this.page = page - 1;
			this.name = "page" + this.page
			label.text = String(page);
			init();
		}
		
		private function init():void {
			activate();
		}
		
		public function deactivate():void {
			buttonMode = false;
			label.textColor = 0x00CBFF;
			borderSelected.visible = true;
			border.visible = false;
			removeEventListener(MouseEvent.CLICK, onClickPage);
		}
		
		public function activate():void {
			label.textColor = 0x999999;
			borderSelected.visible = false;
			border.visible = true;
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, onClickPage);
		}
		
		private function onClickPage(e:Event):void {
			Config.currentPage = page;
			dispatchEvent(new CustomEvents(CustomEvents.PAGE_CHANGED, {}));
		}
		
	}
}