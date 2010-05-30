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
		public var properties:Object;
		public var structure:Object
		public var itemXML:XML;
		
		public function CustomizationItem(id:String, type:String, itemXML:XML, properties:Object) {
			super();
			this.id = id;
			this.type = type;
			this.properties = properties;
			this.itemXML = itemXML;
			addItem();
		}
		
		
		/** Create the item **/
		public function addItem():void {
			initStructure();
			initItem();
		}
		
		
		/** 
		 * Init item structure with all its information 
		 * - id (unique key to know the file to load)
		 * - type (item type between image, movieclip and text)
		 * - properties (item properties that we can change by interface)
		 * 
		 * **/
		private function initStructure():void {
			structure = { "id": id, "type": type };
			structure.properties = initProperties();
		}
		
		// init the values (properties) of the item
		private function initProperties():Object {
			if (properties == null) {
				if (type == "swf")   { return Config.swfStructure   };
				if (type == "image") { return Config.imageStructure };
				if (type == "text")  { return Config.textStructure  };
			} 
			return properties;
		}
		
		
		/** 
		 * Create the item
		 **/
		private function initItem():void {
			item = new Item(structure, itemXML);
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
			item.content = MovieClip(LoaderInfo(e.target).content);
			item.content.height = Config.defaultHeight;
			item.content.width = Config.defaultWidth;
			item.addChild(item.content);
			
			// apply the default properties to the item
			item.applyProperties();
		}
		
		
	}
}