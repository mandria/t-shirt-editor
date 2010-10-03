﻿/** * Single thumb added to the slider. To each single thumb we could * add more functionalities that we can use to make smarter changes * on items (such as the ability at the hove to change item view or  * anything else)     *  **/  package com.ipnotica.menu.content.slider.thumb {		import com.ipnotica.content.blackboard.producs.product.Product;	import com.ipnotica.content.blackboard.producs.product.item.Item;	import com.ipnotica.menu.content.slider.thumb.colors.ColorIcon;	import com.ipnotica.menu.content.slider.thumb.colors.ThumbColors;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	public class Thumb extends MovieClip {				public var image:ThumbImage;				public var id:String;		public var item:XML;						public function Thumb(item:XML = null) {			super();			this.item = item;			this.id   = item.id;			this.buttonMode = true;			init();		}				private function init():void {			initEvents();			image.addImage(id, item);		}				private function initEvents():void {			addEventListener(MouseEvent.CLICK, onClickThumb);		}				private function onClickThumb(e:Event):void {			if (e.target.name != "content") {				if (Config.menuFamily == "products") { /* moved  */ }				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: item.type, id: id, item: item}));			}		}			}}