﻿package com.ipnotica.menu.content.slider.thumbproduct {		import com.ipnotica.utils.Config;	import com.ipnotica.utils.Utils;		import flash.display.Bitmap;	import flash.display.Loader;	import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.net.URLRequest;		public class ThumbProductImage extends MovieClip {				public var image:Bitmap;		public var path:String;				public function ThumbProductImage() {			super();		}				public function initImage(path:String):void {			this.path = path;			cleanImage();			loadImage();		}		private function loadImage():void {			var url:String = Config.flashvars.httpDomain + Config.flashvars.assets + path;			var loader:Loader = new Loader();			loader.load(new URLRequest(url));			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedImage);			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);		}				private function onLoadedImage(e:Event):void {			image = Bitmap(LoaderInfo(e.target).content);			addChild(image);		}     						/*********		 * HELPER		 *********/				private function cleanImage():void {			if (image) { this.removeChild(image); image = null; }		}			}}