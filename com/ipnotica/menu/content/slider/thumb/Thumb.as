﻿/** * Single thumb added to the slider. To each single thumb we could * add more functionalities that we can use to make smarter changes * on items (such as the ability at the hove to change item view or  * anything else)     *  **/  package com.ipnotica.menu.content.slider.thumb {		import com.ipnotica.content.blackboard.producs.product.Product;	import com.ipnotica.content.blackboard.producs.product.item.Item;	import com.ipnotica.menu.content.slider.thumb.colors.ColorIcon;	import com.ipnotica.menu.content.slider.thumb.colors.ThumbColors;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	public class Thumb extends MovieClip {				public var image:ThumbImage;		public var colors:ThumbColors;				/**< List of possible colors for the product **/		public var selected:ColorIcon;  			/**< Actual color of the product **/				public var id:String;		public var item:XML;				private var hiddenOpacity:Number = 0.2;						public function Thumb(item:XML = null) {			super();			this.item = item;			this.id   = item.@id;			init();		}				private function init():void {			selected.alpha = hiddenOpacity;			initEvents();			initColors();			image.addImage(id, item.@type);		}				private function initEvents():void {			addEventListener(MouseEvent.CLICK, onClickThumb);			addEventListener(MouseEvent.MOUSE_OVER, onOver);			addEventListener(MouseEvent.MOUSE_OUT, onOut);		}				private function onOver(e:Event):void { selected.alpha = 1; }		private function onOut(e:Event):void  { selected.alpha = hiddenOpacity; }						private function onClickThumb(e:Event):void {			if (e.target.name != "content") {				if (Config.menuFamily == "products") {					cleanPreviousItems();					trace(Config.currentColor, colors.currentColor, selected)					Config.currentColor = (colors.currentColor == null) ? item.colors.color[0] : colors.currentColor;					colors.init(item, selected);					selected.setColor(Config.currentColor.@color);				}				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: item.@type, id: id, item: item}));			}		}				private function cleanPreviousItems():void {			var products:Array = Config.body.content.blackboard.products.list;			for (var i:int=0; i<products.length; i++) {				var product:Product = products[i];				var items:Array = product.items.customization.items;				for (var j:int=0; j<items.length; j++) {					stage.removeEventListener(MouseEvent.MOUSE_UP, Item(items[j]).myResizableMovieClip.handleStageMouseUp);					Item(items[j]).removeChild(Item(items[j]).myResizableMovieClip);					Item(items[j]).myResizableMovieClip = null;					product.items.removeChild(items[j]);					items[j] = null;				}			}		}				private function initColors():void {			if (Config.menuFamily == "products") { 				colors.init(item, selected);			} else {				selected.visible = false;				colors.visible = false;			}			colors.visible = false;		}			}}