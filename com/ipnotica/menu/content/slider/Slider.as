﻿/** * List of items navigable through a slider system. *  **/ package com.ipnotica.menu.content.slider {		import com.greensock.TweenLite;	import com.ipnotica.menu.content.slider.content.SliderContent;	import com.ipnotica.menu.content.slider.font.Font;	import com.ipnotica.menu.content.slider.navigation.SliderNavigation;	import com.ipnotica.menu.content.slider.thumb.Thumb;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.Utils;		import flash.display.MovieClip;	import flash.events.MouseEvent;	public class Slider extends MovieClip {				public var navigationBottom:SliderNavigation;		/**< Controls to move between content */		public var navigationTop:SliderNavigation;			/**< Controls to move between content */		public var content:SliderContent;					/**< Content for the thumbs **/				public function Slider() {			super();			}						/**		 * Based on the kind of object we need we have different rendering		 * - products: list of images with possibility to change color		 * - images: list of movieclips/images		 * - text: list of texts		 **/		public function update(kind:String = "store"):void {			if (Config.menuFamily == "products") { addProducts(); }			if (Config.menuFamily == "images")   { addImages(kind);   } 			if (Config.menuFamily == "texts")    { addTexts();    }		}								/**		 * Add the FONTS to the list of selectable ones		 **/		private function addTexts():void {			Config.maxThumbsForRow = 1;				Config.maxThumbsForCol = 14;			var posY:Number = 0;			for (var i:int = 0; i < Config.fontsXML.font.length(); i++) {				var font:Font = new Font(Config.fontsXML.font[i]);				addFont(font, posY);				posY += Config.fontThumbHeight;				font.addEventListener(MouseEvent.CLICK, onClickFont);				if (i == 0) { 					Config.currentFont = font; 					Config.currentFontName = font.fontName;					Config.body.menu.header.styles.setDefault(Config.fontsXML.font[0]);					TweenLite.to(Config.currentFont.border, 0.3, {tint: 0x00CBFF});				}			}			updateNavigation();		}				private function addFont(font:Font, posY:Number):void {			font.y = posY;			content.c.addChild(font);		}				private function onClickFont(e:MouseEvent):void {			TweenLite.to(Config.currentFont.border, 0.3, {tint: 0xCCCCCC});			Config.currentFont = Font(e.currentTarget);			Config.currentFontName = Font(e.currentTarget).fontName;			Config.body.menu.header.initInputText(Config.body.menu.header.input.text);			Config.body.menu.header.styles.setDefault(Config.currentFont.font);			TweenLite.to(Config.currentFont.border, 0.3, {tint: 0x00CBFF});		}								/**		 * Add all products/personalizations THUMBS		 **/		private function addProducts():void {			Config.maxThumbsForRow = 4;				Config.maxThumbsForCol = 5;			for (var i:uint=0; i<Config.menuItems.length(); i++) { addThumb(Config.menuItems[i], i); }			updateNavigation();		}						/** 		 * MovieClip Handling 		 **/		private function addImages(kind:String = "store"):void {			Config.maxThumbsForRow = 4;				Config.maxThumbsForCol = 5;						if (kind == "store") { 				var items:XMLList = Utils.findItems(Config.currentCategory);				redrawNavigation(items);			}						if (kind == "upload") {				Utils.findItemsUpload();				// this event, when loaded the images, will continue the drawing			} 		}			 	public function redrawNavigation(items:XMLList):void {			for (var i:uint=0; i<items.length(); i++) { addThumb(Config.menuItems[i], i); }			updateNavigation();		}				/** Add a new thumb */		private function addThumb(item:XML, i:uint):void {			var row:uint = Math.floor(i / Config.maxThumbsForRow);			var col:uint = i % Config.maxThumbsForRow;			var thumb:Thumb = new Thumb(item);			content.c.addChild(thumb);			thumb.y = thumb.width * row;			thumb.x = thumb.height * col;		}				/** Define the paging system */		private function updateNavigation():void {			swapNavigationUp();			navigationTop.update();			navigationBottom.update();		}				/** Put the menu over the tumbs */		private function swapNavigationUp():void {			addChild(navigationBottom);			addChild(navigationTop);		}						/**		 * Change page handling		 **/				public function changePage():void {			scrollPage();			refreshNavigation();		}				private function scrollPage():void {			var thumbHeight:Number = (Config.menuFamily == "texts") ? Config.fontThumbHeight : 80;			content.c.y = -Config.currentPage * (thumbHeight * Config.maxThumbsForCol);		}				private function refreshNavigation():void {			navigationBottom.setPrev();          navigationTop.setPrev();				navigationBottom.setNext();          navigationTop.setNext();			navigationBottom.setPageNumbers();   navigationTop.setPageNumbers();		}			}}