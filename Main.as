﻿/** * Document Class *  **/ package {		import com.greensock.TweenLite;	import com.greensock.plugins.*;	import com.ipnotica.Body;	import com.ipnotica.content.blackboard.producs.customization.Customization;	import com.ipnotica.content.blackboard.producs.product.Product;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;	import com.ipnotica.utils.Utils;		import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.net.URLLoader;	import flash.net.URLRequest;
	public class Main extends MovieClip {				public var body:Body;   			/**< container for all components */				public function Main() { 			init();		}				private function init():void {			Config.doc = this;			initFlashvars();			initTweenlite();			initProductsXML();			initFavouritesXML();		}						/** Initialize flashvars (now they are accessible in all flash) */		private function initFlashvars():void {			try { 				Config.flashvars = LoaderInfo(this.root.loaderInfo).parameters;				if (Config.flashvars.httpDomain == undefined) { Config.flashvars.httpDomain = ""; }				if (Config.flashvars.httpsDomain == undefined) { Config.flashvars.httpsDomain = ""; }				if (Config.flashvars.xml == undefined) { Config.flashvars.xml = "xml/"; }				if (Config.flashvars.assets == undefined) { Config.flashvars.assets  = "assets/"; }				if (Config.flashvars.productID == undefined) { Config.flashvars.productID = "product"; }			} 			catch (error:Error) { 				trace("Warning. Parameters passed through Javascript has not been loaded"); 			}		}          				/** Add autoalpha functionality to Tweenlite */		private function initTweenlite():void {			TweenPlugin.activate([AutoAlphaPlugin, ColorTransformPlugin, TintPlugin]);		}				/** Load list of possible products */		public function initProductsXML():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "products.xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onProductsLoaded);		}				/** If any, load the existing product we want to show */		private function onProductsLoaded(e:Event):void {			Config.products = new XML(e.target.data);			(Config.flashvars.productID == undefined) ? initDefaultConfiguration() : initProduct(); // check if there is a product to load		}				// Load the existing product 		private function initProduct():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.productID + ".xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onProductLoaded);		} 				// Save the XML of the product 		private function onProductLoaded(e:Event = null):void {			Config.existingProduct = new XML(e.target.data);			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "images.xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onObjectsLoaded);		}		private function onObjectsLoaded(e:Event = null):void {			Config.objects = new XML(e.target.data);			initDefaultConfiguration();			initExistingProduct();		}		// When products are loaded the event PRODUCTS_LOADED is fired		private function initDefaultConfiguration(e:Event = null):void {			initDefaultConfig();			dispatchEvent(new CustomEvents(CustomEvents.PRODUCTS_LOADED, {}));		}				// Set the config values needed to load a specific product view 		// Before calling this function remember to set Config.productID		public function initDefaultConfig():void {			Config.product = Utils.findProduct(Config.productID);			Config.views = Config.product.views.view;						if (Config.views.length() > 1) { 				// if there are 2 or more views take the second view as default				Config.productVisibleID = Config.views[0].@id;				Config.viewVisibleID = Config.views[1].@id; 			} else {				// if there is 1 view take the first view as default				Config.productVisibleID = Config.viewVisibleID = Config.views[0].@id;			}						// set the color as the first one available			if (Config.currentColor == null)				Config.currentColor = Config.product.colors.color[0];		}								/**		 * Load all images and texts for requested product		 **/				private function initExistingProduct():void {			var views:XMLList = Config.existingProduct.views.view;			var visualViews:Array = Config.body.content.blackboard.products.list;			for (var i:int = 0; i < views.length(); i++) {				// get an array that will contain all items				var customization:Customization = Product(visualViews[i]).items.customization;				initView(views[i], customization);			}		}				private function initView(view:XML, customization:Customization):void {			var listObjects:XMLList = view.objects.object;			for (var i:int = 0; i < listObjects.length(); i++)				initListObject(listObjects[i], customization);		}				private function initListObject(object:XML, customization:Customization):void {			if (object.@type == "swf" || object.@type == "swf") 				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: object.@type, id: object.@id, item: Utils.findObject(object.@id), structure: object }));		}								/**		 * To delete. This section is going to not be used, but 		 * can allow you to chose some products to show as favourite.		 * Actually it makes more sense outside the editor		 **/				/** Load XML favourites products */		public function initFavouritesXML():void {			//var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "favourites.xml"); 			//var loader:URLLoader = new URLLoader(url);			//loader.addEventListener(Event.COMPLETE, onFavouritesLoaded);		}				// when products are loaded the event PRODUCTS_LOADED is fired		private function onFavouritesLoaded(e:Event):void {			//Config.favourites = new XML(e.target.data);		}			}}