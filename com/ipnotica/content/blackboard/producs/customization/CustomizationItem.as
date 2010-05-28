package com.ipnotica.content.blackboard.producs.customization {
	
	import com.ipnotica.content.blackboard.producs.product.item.Item;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.Utils;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class CustomizationItem extends MovieClip {
		
		public var item:Item;
		public var id:String;
		public var type:String;
		
		public function CustomizationItem(id:String, type:String) {
			super();
			this.id = id;
			this.type = type;
			addItem();
		}
		
		
		/** Create the item **/
		public function addItem():void {
			var structure:Object = initStructure();
			initItem(structure);
		}
		
		// init its structure
		private function initStructure():Object {
			var structure:Object = { "id": id, "type": type };
			if (type == "swf")   { structure.values = Config.swfStructure   };
			if (type == "image") { structure.values = Config.imageStructure };
			if (type == "text")  { structure.values = Config.textStructure  };
			return structure;
		}
		
		// init the real item
		private function initItem(structure:Object):void {
			item = new Item(structure);
			initItemContent(item);
		}
		
		// request to load the content to the item
		private function initItemContent(item:Item):void {
			var url:String = Config.flashvars.httpDomain + Config.flashvars.assets + "images/customizations/swfs/" + item.structure.id + ".swf";
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedItem);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);
		}
		
		// add the content to the item
		private function onLoadedItem(e:Event):void {
			var content:MovieClip = MovieClip(LoaderInfo(e.target).content);
			content.width = content.height = 200;
			item.addChild(content);
		}
	}
}