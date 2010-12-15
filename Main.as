﻿/** * Document Class *  **/ package {		import com.greensock.TweenLite;	import com.greensock.easing.Quart;	import com.greensock.easing.Strong;	import com.greensock.plugins.*;	import com.ipnotica.Body;	import com.ipnotica.content.blackboard.producs.customization.Customization;	import com.ipnotica.content.blackboard.producs.product.Product;	import com.ipnotica.preloader.Preloader;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;	import com.ipnotica.utils.Utils;		import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.net.URLRequestMethod;	import flash.net.URLVariables;	public class Main extends MovieClip {				public var body:Body;   			/**< container for all components */		public var preloader:Preloader;				public function Main() { 			init();		}				private function init():void {			Config.doc = this;			initFlashvars();						// REMOVE THIS PIECE OF CODE AND SET THE PRODUCTID INTO THE FLASHFARS			// TO BE ABLE TO AUTOMATICALLY LOAD AN ALREADY DEFINED PRODUCT			Config.flashvars.productToLoad = undefined							initTweenlite();			initPreloader();			initProductsXML();		}						/** Initialize flashvars (now they are accessible in all flash) */		private function initFlashvars():void {			try { 				Config.flashvars = LoaderInfo(this.root.loaderInfo).parameters;				if (Config.flashvars.httpDomain == undefined) { Config.flashvars.httpDomain = ""; }				if (Config.flashvars.httpsDomain == undefined) { Config.flashvars.httpsDomain = ""; }				if (Config.flashvars.xml == undefined) { Config.flashvars.xml = "xml/"; }				if (Config.flashvars.assets == undefined) { Config.flashvars.assets  = "assets/"; }				if (Config.flashvars.productToLoad == undefined) { Config.flashvars.productToLoad = "product"; }				if (Config.flashvars.id_grafica == undefined) { Config.flashvars.id_grafica = "55"; }				if (Config.flashvars.serverLocation == undefined) { Config.flashvars.categories = "categories.xml"; }				if (Config.flashvars.serverLocation == undefined) { Config.flashvars.images = "images.xml"; }				if (Config.flashvars.serverLocation == undefined) { Config.flashvars.products = "products.xml"; }				if (Config.flashvars.sid == undefined) { Config.flashvars.sid = "4cb096ddcf22e"; }				if (Config.flashvars.jid == undefined) { Config.flashvars.jid = "GxyU5yi6eI"; }				if (Config.flashvars.productID != undefined) { Config.productID = Config.flashvars.productID; }				if (Config.flashvars.productID != undefined) { Config.flashvars.images += "&sid=" + Config.flashvars.sid + "&jid=" + Config.flashvars.jid } 			} 			catch (error:Error) { 				trace("Warning. Parameters passed through Javascript has not been loaded"); 			}		}          				/** Add autoalpha functionality to Tweenlite */		private function initTweenlite():void {			TweenPlugin.activate([AutoAlphaPlugin, ColorTransformPlugin, TintPlugin]);		}				/** Add preloader untill data is loaded **/		private function initPreloader():void {			preloader = new Preloader();			addChild(preloader);		}				/** Load list of possible products */		public function initProductsXML():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.products); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onProductsLoaded);		}				/** If any, load the existing product we want to show */		private function onProductsLoaded(e:Event):void {			Config.products = new XML(e.target.data);			(Config.flashvars.productToLoad == undefined) ? loadImages() : initProduct(); // check if there is a product to load					}				// Load the existing product // ******************		private function initProduct():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.productToLoad + ".xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onProductLoaded);		} 				// Save the XML of the product 		private function onProductLoaded(e:Event = null):void {			Config.existingProduct = new XML(e.target.data);			Config.productID = Config.existingProduct.@id; 			loadImages();		}				private function loadImages():void {			//var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "images.xml"); // testing XML			//var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.images); // real XML			//var loader:URLLoader = new URLLoader(url);			//loader.addEventListener(Event.COMPLETE, onObjectsLoaded);						var url:String = Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.images 			var request:URLRequest = new URLRequest(url); // real XML			//request.method = URLRequestMethod.POST;				// load query string			//var variables:URLVariables = new URLVariables();			//variables.sid=Config.flashvars.sid;			//variables.jid=Config.flashvars.jid;			//request.data = variables;			// loader			var loader:URLLoader = new URLLoader(request);			loader.addEventListener(Event.COMPLETE, onGraphicsLoaded);					}		private function onGraphicsLoaded(e:Event = null):void {			Config.objects = new XML(e.target.data);			loadFonts();		}				// load all fonts into the system		public function loadFonts():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + "fonts/fonts.xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onXMLFontsLoaded);		}				private function onXMLFontsLoaded(e:Event):void {			Config.fontsXML = new XML(e.target.data);			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + "fonts/fonts.swf");			Config.fontLoader.load(url); 			Config.fontLoader.addEventListener(Event.COMPLETE, onFontsLoaded);		}				private function onFontsLoaded(e:Event):void {			startInitialization();		}				// start the real initialization		private function startInitialization():void {			initDefaultConfiguration();			if (Config.flashvars.productToLoad != undefined) { initExistingProduct(); }			// TODO: make a function to hide and to show 			TweenLite.to(preloader, 1, { alpha:0, delay:1, ease: Strong.easeIn, onComplete: function():void { preloader.visible = false; } });		}		// When products are loaded the event PRODUCTS_LOADED is fired		private function initDefaultConfiguration(e:Event = null):void {			initDefaultConfig();			dispatchEvent(new CustomEvents(CustomEvents.PRODUCTS_LOADED, {}));			// activate a default Clip, if selected			TweenLite.delayedCall(1, activateDefaultClip);		}								/**********************************		 * INIT BASICS OF SELECTED PRODUCT		 **********************************/				public function initDefaultConfig():void {			Config.product = Utils.findProduct(Config.productID);			Config.views = Config.product.viste.children(); 						if (Config.views.length() > 1) { 				// if there are 2 or more views take the second view as default				Config.productVisibleID = Config.views[0].node.node.id;				Config.viewVisibleID = Config.views[1].node.node.id;			} else {				// if there is 1 view take the first view as default				Config.productVisibleID = Config.viewVisibleID = Config.views[0].node.node.id;			}			Utils.setNextPrice();		}				private function activateDefaultClip():void {			if (Config.flashvars.id_grafica) {				var object:XML = Utils.findObject(Config.flashvars.id_grafica);				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: object.type, id: object.id, item: object }));			}		}								/************************		 * INIT EXISTING PRODUCT		 ************************/				public function initExistingProduct():void { 			var backupFamily:String = Config.menuFamily;			var views:XMLList = Config.existingProduct.views.view;			trace("---> INIT LOADING CLIPS ON", views.length(), "VIEWS - product", Config.productID);			//var visualViews:Array = Config.body.content.blackboard.products.list;			for (var i:int = 0; i < views.length(); i++) {				initView(views[i]);				Config.body.content.blackboard.views.message.onClickMessage(null);			}			Config.toImport = false;			Config.body.content.blackboard.views.resetFirstView();			Config.menuFamily = backupFamily;		}				private function initView(view:XML):void {			var listObjects:XMLList = view.objects.object;			for (var i:int = 0; i < listObjects.length(); i++) {				initListObject(listObjects[i]);				if (listObjects[i].@type == "texts") { Config.currentFontName = listObjects[i].font; } 			}			Config.currentFontName = "Verdana";		}				private function initListObject(object:XML):void {			// object is the var that contains the structure related the saved item			if (object.@type == "swf" || object.@type == "png" || object.@type == "jpg") {				Config.menuFamily = "images";				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: object.@type, id: object.@id, item: Utils.findObject(object.@id), structure: object }));			}			if (object.@type == "texts") {				Config.menuFamily = "texts";				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {type: object.@type, text: object.@id, action: "add", structure: object}));			}					}			}}