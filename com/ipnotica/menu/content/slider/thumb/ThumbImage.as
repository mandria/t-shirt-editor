﻿package com.ipnotica.menu.content.slider.thumb {		import com.ipnotica.utils.Config;	import com.ipnotica.utils.Utils;		import flash.display.Bitmap;	import flash.display.Loader;	import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.net.URLRequest;	public class ThumbImage extends MovieClip {				public var id:String;		public var swf:MovieClip;		public var product:Bitmap;		public var image:Bitmap;		public var itemXML:XML		private var type:String;				public function ThumbImage() {			super();			buttonMode = true;		}				public function reload():void {			if (product) { removeChild(product); product = null; }			addImage(id, itemXML);		}				// load image with specific ID		public function addImage(id:String, item:XML):void {			this.id = id;			this.itemXML = item;			this.type = item.type;						var url:String = Config.flashvars.httpDomain + Config.flashvars.assets;			var imageName:String = item.image.node.node.path.text() + "thumb60-" + item.image.node.node.filename.text(); // real style							// load MovieClips or images			if (Config.menuFamily == "images") 					url += "images/files/" + imageName;						// real thumb loading 			var loader:Loader = new Loader();			loader.load(new URLRequest(url));						loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedImage);			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);		}				// add background to the stage		private function onLoadedImage(e:Event):void {						// swf for the customization			if (Config.menuFamily == "images" && type == "swf") {				swf = MovieClip(LoaderInfo(e.target).content);				swf.width = swf.height = height;				addChild(swf);			}			// image for the customization  			if (Config.menuFamily == "images" && type == "png") {				image = Bitmap(LoaderInfo(e.target).content);				image.smoothing = true;   				image.width = image.height = height;				addChild(image);			}		}     			}}