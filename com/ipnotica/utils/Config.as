﻿package com.ipnotica.utils {		import com.ipnotica.Body;
	import com.ipnotica.content.blackboard.producs.product.Product;
	import com.ipnotica.content.blackboard.producs.product.item.Item;		public class Config {						/** Structure **/		public static var doc:Main;							/**< document class **/		public static var body:Body;						/**< images container (here are attached header, footer, content and menu) **/						/** Flashvars **/		public static var flashvars:Object					/**< params passed throug javascript **/						/** Products **/		public static var products:XML;						/**< XML products **/		public static var favourites:XML;					/**< XML favourites **/		public static var product:XML;						/**< XML selected product **/		public static var views:XMLList;					/**< XML list of all available views **/  		public static var productID:String = "1";			/**< ID of the actual selected product (tshirt, cup, hat, ...). The defauld ID here set the firt product shown              **/		public static var productVisibleID:String;			/**< ID of the actual visible product (actually selected view) **/		public static var viewVisibleID:String;				/**< ID of the actual visible view **/		public static var currentProduct:Product;			/**< Current product movieclip */		public static var currentItem:Item;					/**< Current item movieclip */		public static var currentColor:XML;					/**< Current selected color of the product */				public static var changingProduct:Boolean = false	/** hack to solve problem of changing product */				/** Menu **/		public static var menuFamily:String;				/**< Family (images, text or products) **/		public static var menuItems:XMLList;				/**< List of all images/movieclips or products **/		public static var maxThumbsForRow:uint = 4;			/**< Max number of thums visible in a row **/		public static var maxThumbsForCol:uint = 5;			/**< Max number of thums visible in a row **/		public static var spaceBetweenButtons:uint = 4;		/**< Space between 2 buttons for the navigation **/		public static var currentPage:uint;					/**< Current page of visualized items in the menu **/						/** Images / MovieClips **/		public static var currentCategory:String = "all";	/**< Category for the MovieClip selection **/						/** Items **/		public static var defaultHeight:uint = 200;			/**< Default height when we add the item over the product **/		public static var defaultWidth:uint  = 200;			/**< Default width when we add the item over the product **/						/** 		 * ITEMS STRUCTURE 		 **/				/** SWF structure **/		public static var swfStructure:Object ={			"x": 0,					/**< horizontal position **/				"y": 0,					/**< vertical position **/			"color": null,			/**< layers color **/			"rotation": 0,			/**< rotation degree **/			"scale": 1				/**< resizing ratio **/		}		/** Image structure **/		public static var imageStructure:Object ={			"x": 0,					/**< horizontal position **/				"y": 0,					/**< vertical position **/			"rotation": 0,			/**< rotation degree **/			"scale": 1				/**< resizing ratio **/		}		/** Text structure **/		public static var textStructure:Object ={			"x": 0,					/**< horizontal position **/				"y": 0,					/**< vertical position **/			"rotation": 0,			/**< rotation degree **/			"scale": 1,				/**< resizing ratio **/			"text": "pippo",		/**< text content **/			"font": "Verdana"		/**< font family **/		}								public function Config() { }	}}          