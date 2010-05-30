package com.ipnotica.menu.content.slider.thumb {
	
	import com.greensock.TweenLite;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.Utils;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class ThumbImage extends MovieClip {
		
		public var id:String;
		public var swf:MovieClip;
		
		public function ThumbImage() {
			super();
			buttonMode = true;
		}
		
		// load image with specific ID
		public function addImage(id:String):void {
			this.id = id;
			
			var url:String = Config.flashvars.httpDomain + Config.flashvars.assets + "images/customizations/swfs/" + id + ".swf";
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);
		}
		
		// add background to the stage
		private function onLoadedImage(e:Event):void {
			swf = MovieClip(LoaderInfo(e.target).content);
			swf.width = swf.height = height;
			addChild(swf);
			//TweenLite.to(swf.mouth, 10, {tint:0x99ff66});
		}     
		
	}
}