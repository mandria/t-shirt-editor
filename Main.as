﻿/** * Document Class *  **/ package {		import com.greensock.TweenLite;	import com.greensock.plugins.*;	import com.ipnotica.Body;	import com.ipnotica.content.blackboard.producs.customization.Customization;	import com.ipnotica.content.blackboard.producs.product.Product;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;	import com.ipnotica.utils.Utils;		import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.net.URLLoader;	import flash.net.URLRequest;	public class Main extends MovieClip {				public var body:Body;   			/**< container for all components */				public function Main() { 			init();		}				private function init():void {			Config.doc = this;			initFlashvars();			initTweenlite();			initProductsXML();		}						/** Initialize flashvars (now they are accessible in all flash) */		private function initFlashvars():void {			try { 				Config.flashvars = LoaderInfo(this.root.loaderInfo).parameters;				if (Config.flashvars.httpDomain == undefined) { Config.flashvars.httpDomain = ""; }				if (Config.flashvars.httpsDomain == undefined) { Config.flashvars.httpsDomain = ""; }				if (Config.flashvars.xml == undefined) { Config.flashvars.xml = "xml/"; }				if (Config.flashvars.assets == undefined) { Config.flashvars.assets  = "assets/"; }				if (Config.flashvars.productID == undefined) { Config.flashvars.productID = "product"; }			} 			catch (error:Error) { 				trace("Warning. Parameters passed through Javascript has not been loaded"); 			}		}          				/** Add autoalpha functionality to Tweenlite */		private function initTweenlite():void {			TweenPlugin.activate([AutoAlphaPlugin, ColorTransformPlugin, TintPlugin]);		}				/** Load list of possible products */		public function initProductsXML():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "products_real.xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onProductsLoaded);		}				/** If any, load the existing product we want to show */		private function onProductsLoaded(e:Event):void {			Config.products = new XML(e.target.data);			(Config.flashvars.productID == undefined) ? loadImages() : initProduct(); // check if there is a product to load					}				// Load the existing product // _real		private function initProduct():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.productID + ".xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onProductLoaded);		} 				// Save the XML of the product 		private function onProductLoaded(e:Event = null):void {			Config.existingProduct = new XML(e.target.data);			Config.productID = Config.existingProduct.@id; 			loadImages();		}				private function loadImages():void {			//var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "images.xml"); // testing XML			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "images_real.xml"); // real XML			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onObjectsLoaded);		}		private function onObjectsLoaded(e:Event = null):void {			Config.objects = new XML(e.target.data);			loadFonts();		}				// load all fonts into the system		public function loadFonts():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + "fonts/fonts.xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onXMLFontsLoaded);		}				private function onXMLFontsLoaded(e:Event):void {			Config.fontsXML = new XML(e.target.data);			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + "fonts/fonts.swf");			Config.fontLoader.load(url); 			Config.fontLoader.addEventListener(Event.COMPLETE, onFontsLoaded);		}				private function onFontsLoaded(e:Event):void {			startInitialization();		}				// start the real initialization		private function startInitialization():void {			initDefaultConfiguration();			if (Config.flashvars.productID != undefined) { initExistingProduct(); }		}		// When products are loaded the event PRODUCTS_LOADED is fired		private function initDefaultConfiguration(e:Event = null):void {			initDefaultConfig();			dispatchEvent(new CustomEvents(CustomEvents.PRODUCTS_LOADED, {}));		}								/**********************************		 * INIT BASICS OF SELECTED PRODUCT		 **********************************/				public function initDefaultConfig():void {			trace("--> searching for", Config.productID);			Config.product = Utils.findProduct(Config.productID);			trace("--> found out product", Config.product.id);			Config.views = Config.product.viste.children();						if (Config.views.length() > 1) { 				// if there are 2 or more views take the second view as default				Config.productVisibleID = Config.views[0].node.node.id;				Config.viewVisibleID = Config.views[1].node.node.id;				trace("--> SUUU", Config.views[1].node.node.id)			} else {				// if there is 1 view take the first view as default				Config.productVisibleID = Config.viewVisibleID = Config.views[0].node.node.id;				trace("--> GIUUU", Config.views[0].node.node.id)			}					}								/************************		 * INIT EXISTING PRODUCT		 ************************/				private function initExistingProduct():void { 			var views:XMLList = Config.existingProduct.views.view;			var visualViews:Array = Config.body.content.blackboard.products.list;			for (var i:int = 0; i < views.length(); i++) {				initView(views[i]);				Config.body.content.blackboard.views.message.onClickMessage(null);			}			Config.toImport = false;			Config.body.content.blackboard.views.resetFirstView();		}				private function initView(view:XML):void {			var listObjects:XMLList = view.objects.object;			for (var i:int = 0; i < listObjects.length(); i++) {				initListObject(listObjects[i]);				if (listObjects[i].@type == "texts") { Config.currentFontName = listObjects[i].font; } 			}			Config.currentFontName = "Verdana";		}				private function initListObject(object:XML):void {			// object is the var that contains the structure related the saved item			if (object.@type == "swf" || object.@type == "png") 				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: object.@type, id: object.@id, item: Utils.findObject(object.@id), structure: object }));			if (object.@type == "texts") {				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: object.@type, text: object.@id, action: "add", structure: object}));			}		}			}}