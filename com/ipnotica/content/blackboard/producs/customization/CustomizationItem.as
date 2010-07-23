﻿package com.ipnotica.content.blackboard.producs.customization {		import com.ipnotica.content.blackboard.producs.product.item.Item;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.Utils;	import com.ipnotica.utils.resize.ResizableMovieClip;		import flash.display.Bitmap;	import flash.display.Loader;	import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.net.URLRequest;	public class CustomizationItem extends MovieClip {				public var item:Item;		public var id:String;		public var type:String;		public var properties:Object;		public var structure:Object		public var itemXML:XML;				public function CustomizationItem(id:String, type:String, itemXML:XML, properties:Object) {			super();			this.id = id;			this.type = type;			this.properties = properties;			this.itemXML = itemXML;			addItem();		}						/** Create the item **/		public function addItem():void {			initStructure();			initItem();		}						/** 		 * Init item structure with all its information 		 * - id (unique key to know the file to load)		 * - type (item type between image, movieclip and text)		 * - properties (item properties that we can change by interface)		 * 		 * **/		private function initStructure():void {			structure = { "id": id, "type": type };			structure.properties = initProperties();		}				// init the values (properties) of the item		private function initProperties():Object {			if (properties == null) {				if (type == "swf")   { return Config.swfStructure   };				if (type == "png")   { return Config.imageStructure };				if (type == "text")  { return Config.textStructure  };			} 			return properties;		}						/** 		 * Create the item		 **/		private function initItem():void {			item = new Item(structure, itemXML);			initItemContent(item);		}				// request to load the content to the item		private function initItemContent(item:Item):void {			var url:String = Config.flashvars.httpDomain + Config.flashvars.assets + "images/customizations/" + item.structure.id + "." + item.structure.type;			var loader:Loader = new Loader();			loader.load(new URLRequest(url));			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedItem);			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);		}				// add the content to the item		private function onLoadedItem(e:Event):void {						// load MC or image			item.content = (item.structure.type == "swf") ? MovieClip(LoaderInfo(e.target).content) : Bitmap(LoaderInfo(e.target).content);			if (item.structure.type == "png") { item.content.smoothing = true; }			// set default properties of element			item.content.height = Config.defaultHeight;			item.content.width  = Config.defaultWidth;			item.myResizableMovieClip = new ResizableMovieClip(item.content);			item.myResizableMovieClip.setX(100);			item.myResizableMovieClip.setY(100);			item.addChild(item.myResizableMovieClip);			// apply the default properties to the item			item.applyProperties();		}					}}