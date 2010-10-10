﻿package com.ipnotica.content.blackboard.producs.customization {		import com.ipnotica.content.blackboard.producs.product.item.Item;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.Utils;	import com.ipnotica.utils.resize.ResizableMovieClip;		import flash.display.Bitmap;	import flash.display.Loader;	import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.events.MouseEvent;	import flash.net.URLRequest;	import flash.text.AntiAliasType;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;	public class CustomizationItem extends MovieClip {				public var item:Item;		public var id:String;		public var type:String;		public var properties:Object;		public var structure:Object		public var itemXML:XML;		public var structureXML:XML;				public function CustomizationItem(id:String, type:String, itemXML:XML, properties:Object, structureXML:XML) {			super();			this.id = id;			this.type = type;			this.properties = properties;			this.itemXML = itemXML;			this.structureXML = structureXML;			addItem();		}						/** Create the item **/		public function addItem():void {			initStructure();			initItem();		}						/** 		 * Init item structure with all its information 		 * - id (unique key to know the file to load)		 * - type (item type between image, movieclip and text)		 * - properties (item properties that we can change by interface)		 * 		 ***/		private function initStructure():void {			structure = { "id": id, "type": type };			structure.properties = initProperties();		}				// init the values (properties) of the item		private function initProperties():Object {			var structure:Object = {};			var app:Object = {};				if (properties == null) {				if (type == "swf")   { app = Config.swfStructure   };				if (type == "png")   { app = Config.imageStructure };				if (type == "texts") { app = Config.textStructure  };			} 			for (var val:String in app) { structure[val] = app[val]; }			return structure;		}						/** 		 * Create the item		 **/		private function initItem():void {			item = new Item(structure, itemXML);			if (type == "texts" && structureXML != null) 				initItemTextContent(item);			else 				(Config.menuFamily == "images") ? initItemContent(item) : initItemTextContent(item);		}				// add a textfield		private function initItemTextContent(item:Item):void {			item.structure.properties.font = (structureXML) ? structureXML.font : Config.currentFontName;			var label:TextField = new TextField();			label.defaultTextFormat = (this.structureXML) ? new TextFormat(structureXML.font, 18, 0) : new TextFormat(item.structure.properties.font, 18, 0);			//label.defaultTextFormat = new TextFormat(Config.currentFontName, 18, 0);			label.antiAliasType = AntiAliasType.ADVANCED;            label.autoSize = TextFieldAutoSize.NONE;			label.embedFonts = true;			label.textColor = (structureXML) ? structureXML.color : Config.fontDefaultColor;						label.htmlText = "<p>"+ id + "</p>";			addChild(label);						item.content = label			item.content.height = label.textHeight + 5;			item.content.width  = label.textWidth + 5;			item.structure.properties.height = item.content.height			item.structure.properties.width = item.content.width							item.myResizableMovieClip = new ResizableMovieClip(item.content);			item.myResizableMovieClip.x = item.myResizableMovieClip.y = 100;			item.addChild(item.myResizableMovieClip);			item.itemXML = this.structureXML;			// apply the default properties to the item			if (structureXML) { item.applyProperties(structureXML); }		}				// request to load the content to the item		private function initItemContent(item:Item):void {			//var imageName:string =  + item.structure.id + "." + item.structure.type; // test way			var tempItem = Utils.findObject(item.structure.id);			var imageName:String = tempItem.image.node.node.path.text() + "thumb200-" + tempItem.image.node.node.filename.text(); // test way			var url:String = Config.flashvars.httpDomain + Config.flashvars.assets + "images/files/" + imageName;						var loader:Loader = new Loader();			loader.load(new URLRequest(url));			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedItem);			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);		}				// add the content to the item		private function onLoadedItem(e:Event):void {						// load MC or image			item.content = (item.structure.type == "swf") ? MovieClip(LoaderInfo(e.target).content) : Bitmap(LoaderInfo(e.target).content);			if (item.structure.type == "png") { item.content.smoothing = true; }			// set default properties of element			item.content.height = Config.defaultHeight;			item.content.width  = Config.defaultWidth;			item.myResizableMovieClip = new ResizableMovieClip(item.content);			item.myResizableMovieClip.setX(100);			item.myResizableMovieClip.setY(100);			item.addChild(item.myResizableMovieClip);						// apply the structure related to the item			if (structureXML) { item.applyProperties(structureXML); }		}					}}