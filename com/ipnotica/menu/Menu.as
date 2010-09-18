﻿/** * Right menu with all list selections. Here we will have the list * of all the MovieClip, Images and the TextField   *  **/package com.ipnotica.menu {		import com.ipnotica.menu.content.MenuContent;	import com.ipnotica.menu.header.MenuHeader;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;	import com.ipnotica.utils.Utils;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.text.Font;	import flash.text.FontStyle;	public class Menu extends MovieClip {				public var header:MenuHeader;				/**< Header. Controls the content (category selection or text fill) */		public var content:MenuContent;				/**< Content. Contains all movieclips, images or texts */				public function Menu() {			super();			init();		}				private function init():void {			Utils.setConfig(this);			initListeners()		}						/** Listen when menu buttons are clicked **/		private function initListeners():void {			Config.body.header.products.addEventListener(MouseEvent.CLICK, onClickProducts);			Config.body.header.images.addEventListener(MouseEvent.CLICK, onClickImages);			Config.body.header.text.addEventListener(MouseEvent.CLICK, onClickText);		}				public function onClickProducts(e:Event):void {			trace("You clicked the *products* selection");			Config.menuFamily = "products";			loadData();		}				public function onClickImages(e:Event):void {			trace("You clicked the *images* selection");			Config.menuFamily = "images";			loadData();		}				public function onClickText(e:Event):void {			trace("You clicked the *text* selection");			Config.menuFamily = "texts";			loadFonts();		}							/** 		 * Load the data to put on the slider. For images and products		 * will be an XML		 **/		public function loadData():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.menuFamily + ".xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onDataLoaded);		}				// when products are loaded the event PRODUCTS_LOADED is fired		// TODO: use custom events		private function onDataLoaded(e:Event):void {			if (Config.menuFamily == "images")   { Config.menuItems = new XMLList(e.target.data).image;   }			if (Config.menuFamily == "products") { Config.menuItems = new XMLList(e.target.data).product; }			update();		}								/** 		 * Load all FONTS to put on the slider. 		 * All FONTS are compiled inside a specific SWF to keep wheight lighter		 **/		public function loadFonts():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + "fonts/fonts.xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onXMLFontsLoaded);		}				private function onXMLFontsLoaded(e:Event):void {			Config.fontsXML = new XML(e.target.data);			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + "fonts/fonts.swf");			Config.fontLoader.load(url); 			Config.fontLoader.addEventListener(Event.COMPLETE, onFontsLoaded);		}				private function onFontsLoaded(e:Event):void {			debugFonts();			update();		}				private function debugFonts():void {			var fonts:Array = Config.fontLoader.fonts;			for each (var font:Font in fonts) {				var isBold:Boolean		= false;				var isItalic:Boolean	= false;				switch (font.fontStyle) {					case FontStyle.BOLD:        isBold   = true;  break;					case FontStyle.BOLD_ITALIC: isBold   = true;  isItalic = true;  break;					case FontStyle.ITALIC:      isItalic = true;  break;				}				trace("-- Loaded font " + font.fontName);			}		}								/** 		 * Update the menu content		 **/				public function update(e:CustomEvents = null):void {			updateHeader()			updateContent()		}				public function updateHeader():void {			// menu header clear			this.removeChild(header);			header = new MenuHeader();			header.x = 3;			this.addChild(header);			// menu header update			header.update();		}				public function updateContent(kind:String = "store"):void {			content.clear();			content.update(kind);		}			 	}}            