/**
 * Background TShirt image
 * 
 **/
 
 package com.ipnotica.content.blackboard.producs.product {
 	
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.Utils;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class ProductImage extends MovieClip {
		
		public var id:String;
		
		public function ProductImage() {
			super();
		}
				
		// load image with specific ID
		public function addImage(id:String):void {
			this.id = id;
			var url:String = Config.flashvars.httpDomain + Config.flashvars.assets + "images/products/normals/" + Config.productID + "/" + id + "-" + Config.currentColor.@id + ".png";
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);
		}
		
		// add background to the stage
		private function onLoadedImage(e:Event):void {
			var image:Bitmap = Bitmap(LoaderInfo(e.target).content);
			image.smoothing = true;
			addChild(image);
		}             
		
	}
}