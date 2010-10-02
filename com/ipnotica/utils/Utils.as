﻿package com.ipnotica.utils {	import com.ipnotica.Body;	import com.ipnotica.content.blackboard.producs.product.Product;	import com.ipnotica.content.blackboard.producs.product.item.Item;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;			public class Utils {				public function Utils() { }						/**		 * HACK. Makes some objects available to his childrens.		 * To understand why this is necessary, as would be logic 		 * to access to parents.		 *  		 * @description This is necessary because flash access to 		 * some MovieClips (like menu) before the Main can have been 		 * initialized. So in the menu we need to call this function		 * to be able to navigate everywhere.		 * 		 * @implementation The object passed as Param is iterated		 * on its parent until the Body object is found out.		 * 		 **/ 		 		public static function setConfig(obj:MovieClip):void {			while (!(obj is Main)) {				obj = MovieClip(obj.parent);				if (obj is Main) { Config.doc  = Main(obj); }				if (obj is Body) { Config.body = Body(obj); }			}		}				/**		 * Gives specific view through its unique id  		 * 		 * @implementation This is an alternative implementation 		 * <code>Config.product..*.(hasOwnProperty("@id") && @id=="2"));</code>		 **/		 		public static function findView(id:String):XML {			return Config.product.views.view.(@id == id)[0];		}				/** 		 * Give specific product passing its unique ID.		 **/				public static function findProduct(id:String):XML {			return Config.products.product.(@id == id)[0];   		}				/** 		 * Give specific image or swf passing its unique ID		 **/				public static function findObject(idSearch:String):XML {			return Config.objects.node.(id == idSearch)[0];   		}				/** 		 * Return all items or the once selected through the combo box		 * in the case a category has been selected		 **/				public static function findItems(category:String):XMLList {			return (category == "all") ? Config.menuItems : Config.menuItems.(ref_cat == category);		}				/** 		 * Return all uploaded items for the specific project		 * in the case a category has been selected		 **/				public static function findItemsUpload():void {			var url:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "upload.xml?id=projectID"); 			var loader:URLLoader = new URLLoader(url);			loader.addEventListener(Event.COMPLETE, Utils.onUploadComplete);		}				private static function onUploadComplete(e:Event):void {			Config.body.menu.content.slider.redrawNavigation(new XML(e.target.data).image);		}				/** 		 * Return the concat of the product description and the view description.		 **/		 		public static function productAndViewDescription():String {			return Config.product.@description + " ("  + Utils.findView(Config.productVisibleID).@description + ")";		}				/** 		 * Return the total price for the current product.		 **/		public static function totalPrice():Number {			return  Number(Config.product.price) + Utils.priceItems();		}				// take out the items for ONE specific view		public static function priceItems():Number {			var total:Number = 0;			var views:Array = Config.body.content.blackboard.products.list;			for (var i:int = 0; i < views.length; i++) { total += Utils.priceView(Product(views[i]).items.customization.items); }			return total;		}				// take out the total price of items for ONE single view		public static function priceView(items:Array):Number {			var total:Number = 0;			//for (var i:int = 0; i < items.length; i++) { total += Number(items[i].itemXML.price); }			return total;		}						/**		 * Give the number of pages that show different movieclips 		 **/				public static function numberOfPages():uint {			if (Config.menuFamily != "texts") { return Math.ceil(Utils.findItems(Config.currentCategory).length() / (Config.maxThumbsForCol*Config.maxThumbsForRow)); }			return Math.ceil(Config.fontsXML.font.length() / Config.maxThumbsForCol);		}				public static function setOrderItem(items:Array, item:Item, index:int):void {			items.push(item);			items.splice(index, 1); // replaces Aral and Superior			for (var i:int=0; i < items.length; i++)				trace(items[i].name);		}				/** 		 * IO common error handling 		 **/				public static function onIOError(e:IOErrorEvent):void {			trace("IO Error:", e);		}			}}