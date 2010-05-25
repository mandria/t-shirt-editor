﻿/** * Document Class *  **/ package {		import com.greensock.plugins.AutoAlphaPlugin;	import com.greensock.plugins.TweenPlugin;	import com.ipnotica.Body;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;	import com.ipnotica.utils.Utils;		import flash.display.LoaderInfo;	import flash.display.MovieClip;	import flash.events.Event;	import flash.net.URLLoader;	import flash.net.URLRequest;	public class Main extends MovieClip {				public var body:Body;   			/**< container for all components */				public function Main() { 			init();		}				private function init():void {			Config.doc = this;			initFlashvars();			initTweenlite();			initProductsXML();		}						/** Initialize flashvars (now they are accessible in all flash) */		private function initFlashvars():void {			try { 				Config.flashvars = LoaderInfo(this.root.loaderInfo).parameters;				if (Config.flashvars.httpDomain == undefined) { Config.flashvars.httpDomain = ""; }				if (Config.flashvars.httpsDomain == undefined) { Config.flashvars.httpsDomain = ""; }				if (Config.flashvars.xml == undefined) { Config.flashvars.xml = "xml/"; }				if (Config.flashvars.assets == undefined) { Config.flashvars.assets  = "assets/"; }			} 			catch (error:Error) { 				trace("Warning. Parameters passed through Javascript has not been loaded"); 			}		}          				/** Add autoalpha functionality to Tweenlite */		private function initTweenlite():void {			TweenPlugin.activate([AutoAlphaPlugin]);		}								/** Load XML products */		public function initProductsXML():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "products.xml"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, onProductsLoaded);		}				// when products are loaded the event PRODUCTS_LOADED is fired		private function onProductsLoaded(e:Event):void {			Config.products = new XML(e.target.data);			initDefaultConfig();			dispatchEvent(new CustomEvents(CustomEvents.PRODUCTS_LOADED, {}));		}				// set the config values needed to load a specific product view 		private function initDefaultConfig():void {			Config.product = Utils.findProduct(Config.productID);			Config.views   = Config.product.views.view;						if (Config.views.length() > 1) { 				// if there are 2 or more views take the second view as default				Config.visibleProductID = Config.views[0].@id;				Config.visibleViewID = Config.views[1].@id; 			} else {				// if there is 1 view take the first view as default				Config.visibleProductID = Config.visibleViewID = Config.views[0].@id;			}					}		    					}}