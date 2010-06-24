/**
 * Single thumb added to the slider. To each single thumb we could
 * add more functionalities that we can use to make smarter changes
 * on items (such as the ability at the hove to change item view or 
 * anything else)    
 * 
 **/
 
 package com.ipnotica.menu.content.slider.thumb {
	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.CustomEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Thumb extends MovieClip {
		
		public var image:ThumbImage;
		
		public var id:String;
		public var item:XML;
		
		public function Thumb(item:XML) {
			super();
			this.item = item;
			this.id   = item.@id;
			init();
		}
		
		private function init():void {
			image.addImage(id);
			initEvents();
		}
		
		private function initEvents():void {
			addEventListener(MouseEvent.CLICK, onClickThumb);
		}
		
		private function onClickThumb(e:Event):void {
			Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: item.@type, id: id, item: item}));
		}
		
	}
}