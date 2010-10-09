﻿package com.ipnotica.utils {		import com.ipnotica.Body;	import com.ipnotica.content.blackboard.producs.product.Product;	import com.ipnotica.content.blackboard.producs.product.item.Item;	import com.ipnotica.menu.content.slider.font.Font;	import com.utils.fonts.FontLoader;		import flash.text.StyleSheet;		public class Config {						/** Structure **/		public static var doc:Main;							/**< document class **/		public static var body:Body;						/**< images container (here are attached header, footer, content and menu) **/						/** Flashvars **/		public static var flashvars:Object					/**< params passed throug javascript **/						/** Products **/		public static var products:XML;						/**< XML products **/		public static var favourites:XML;					/**< XML favourites **/		public static var product:XML;						/**< XML selected product **/		public static var views:XMLList;					/**< XML list of all available views **/  		public static var productID:String = "12";			/**< ID of the actual selected product (tshirt, cup, hat, ...). The defauld ID here set the firt product shown              **/		public static var productVisibleID:String;			/**< ID of the actual visible product (actually selected view) **/		public static var viewVisibleID:String;				/**< ID of the actual visible view **/		public static var currentProduct:Product;			/**< Current product movieclip */		public static var currentItem:Item;					/**< Current item movieclip */		public static var currentColor:XML;					/**< Current selected color of the product */		public static var existingProduct:XML;				/**< XML that describe who an existing product is made */		public static var objects:XML;						/**< XML images and swf */		public static var changingProduct:Boolean = false;	/**< hack to solve problem of changing product */		public static var productToLoad:Boolean = true;		/**< hack to not load several times the product */				/** Menu **/		public static var menuFamily:String;				/**< Family (images, texts or products) **/		public static var menuItems:XMLList;				/**< List of all images/movieclips or products **/		public static var maxThumbsForRow:uint = 4;			/**< Max number of thums visible in a row **/		public static var maxThumbsForCol:uint = 5;			/**< Max number of thums visible in a row **/		public static var spaceBetweenButtons:uint = 4;		/**< Space between 2 buttons for the navigation **/		public static var currentPage:uint;					/**< Current page of visualized items in the menu **/						/** Images / MovieClips **/		public static var currentCategory:String = "all";	/**< Category for the MovieClip selection **/						/** Fonts **/		public static var fontsXML:XML;		public static var currentFont:Font;		public static var currentFontName:String = "Verdana";		public static var cssFonts:StyleSheet = new StyleSheet();		public static var fontLoader:FontLoader = new FontLoader();		public static var fontThumbHeight:Number = 28.5;		public static var fontDefaultColor:uint = 0x000000; //0x00CBFF;						/** Items **/		public static var defaultHeight:uint = 200;			/**< Default height when we add the item over the product **/		public static var defaultWidth:uint  = 200;			/**< Default width when we add the item over the product **/		public static var toImport:Boolean = true;			/**< Tells if the XML of an initial product has been imported or not **/		public static var nextPrice:Number;					/**< Price for the next item to add **/		public static var totalPrice:Number;				/**< Total price product plus items **/						/** 		 * ITEMS STRUCTURE 		 **/				/** SWF structure **/		public static var swfStructure:Object ={			"x": 100,					/**< horizontal position **/				"y": 100,					/**< vertical position **/			"color": 0x000000,			/**< layers color **/			"rotation": 0,				/**< rotation degree **/			"height": 200,				/**< image height **/			"width": 200,				/**< image width **/			"alpha": 1,					/**< image alpha **/			"scale": 1					/**< resizing ratio **/		}		/** Image structure **/		public static var imageStructure:Object ={			"x": 100,					/**< horizontal position **/				"y": 100,					/**< vertical position **/			"rotation": 0,				/**< rotation degree **/			"color": 0x000000,			/**< image color **/			"height": 200,				/**< image height **/			"width": 200,				/**< image width **/			"alpha": 1,					/**< image alpha **/			"scale": 1					/**< resizing ratio **/		}		/** Text structure **/		public static var textStructure:Object ={			"x": 100,					/**< horizontal position **/				"y": 100,					/**< vertical position **/			"rotation": 0,				/**< rotation degree **/			"color": 0x0000,			/**< layers color **/			"font": "Verdana",			/**< resizing ratio **/			"height": 200,				/**< image height **/			"width": 200,				/**< image width **/			"alpha": 1,					/**< image alpha **/			"scale": 1					/**< resizing ratio **/		}								public function Config() { }	}}          