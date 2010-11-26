package com.ipnotica.preloader {
	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.Utils;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class Preloader extends MovieClip {
		
		public var label:TextField;
		
		public function Preloader() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {     
			initVisuals();
		}
		
		private function initVisuals():void {
			loadPreloaderImage();
		}
		
		private function loadPreloaderImage():void {
			var url:String = Config.flashvars.httpDomain + Config.flashvars.assets + "images/preloader/preloader.swf";
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);
		}
		
		private function onLoadedImage(e:Event):void {
			var image:* = LoaderInfo(e.target).content;
			addChild(image);
			image.x = 390;
			image.y = 350;
		}     
		
		
	}
}