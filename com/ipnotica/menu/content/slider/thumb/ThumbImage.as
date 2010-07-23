package com.ipnotica.menu.content.slider.thumb {
	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.Utils;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class ThumbImage extends MovieClip {
		
		public var id:String;
		public var swf:MovieClip;
		public var product:Bitmap;
		
		private var type:String;
		
		public function ThumbImage() {
			super();
			buttonMode = true;
		}
		
		public function reload():void {
			if (product) { removeChild(product); product = null; }
			addImage(id, type);
		}
		
		// load image with specific ID
		public function addImage(id:String, type:String):void {
			this.id = id;
			this.type = type;
			
			var url:String = Config.flashvars.httpDomain + Config.flashvars.assets
			
			// load MovieClips or images
			if (Config.menuFamily == "images") 
					url += "images/customizations/" + id + "." + type;
			
			// load products images
			if (Config.menuFamily == "products") { 
				url += "images/products/thumbs/" + Thumb(parent).item.@id + "/" + "1" + "-";
				url += (Thumb(parent).colors.currentColor) ? Thumb(parent).colors.currentColor.@id : Thumb(parent).item.colors..color[0].@id;
				url += ".png";
			}
			
			// real thumb loading 
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);
		}
		
		// add background to the stage
		private function onLoadedImage(e:Event):void {
			
			// swf for the customization
			if (Config.menuFamily == "images" && type == "swf") {
				swf = MovieClip(LoaderInfo(e.target).content);
				swf.width = swf.height = height;
				addChild(swf);
			}

			// image for the customization  
			if (Config.menuFamily == "products") {
				product = Bitmap(LoaderInfo(e.target).content);
				addChild(product);
			}
			
			// image for the product
			if (Config.menuFamily == "products") {
				product = Bitmap(LoaderInfo(e.target).content);
				addChild(product);
			}
		}     
		
	}
}