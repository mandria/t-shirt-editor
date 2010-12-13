﻿/** * Items container  *  **/package com.ipnotica.content.blackboard.producs.product {		import com.greensock.TweenLite;	import com.ipnotica.content.blackboard.producs.customization.Customization;	import com.ipnotica.content.blackboard.producs.product.item.Item;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;	import com.ipnotica.utils.Utils;		import flash.display.MovieClip;	import flash.text.AntiAliasType;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;	public class ProductItems extends MovieClip {				public var customization:Customization;				public function ProductItems() {			super();			init(); 		}				private function init():void {			customization = new Customization();		}				// if the current product view is the selected one, add the product		public function onThumbClicked(e:CustomEvents):void {						// load the movieclip to the products (created from interface or automatically generated)			if (Config.menuFamily == "images" && e.data.type != "texts") {				var product:Product = Product(this.parent);				if (product.id == Config.productVisibleID) {					var item:Item = addItem(e.data.id, e.data.type, e.data.item, e.data.structure);					setSelectedItem(item);					Utils.setNextPrice();				}				Config.doc.dispatchEvent(new CustomEvents(CustomEvents.ITEM_ADDED, {}));			}						// load the new product 			if (Config.menuFamily == "products") {				Config.productToLoad = true;				Config.body.footer.clear();				Config.productID = e.data.id;				Config.doc.initDefaultConfig();				Config.body.content.update();				Utils.setNextPrice();				Config.toImport = true;				Config.doc.initExistingProduct();				Config.body.header.updateHeader(null);				Config.body.menu.header.showButtons("products");			}						// this is used only to create the text from the interface (you click the add button)			if (Config.menuFamily == "texts" && e.data.action == "add" && e.data.structure == null) {				var itemText:Item = addItem(e.data.text, "texts", Config.currentFont.font, e.data.structure);				setSelectedItem(itemText);				Utils.setNextPrice();			}						// this is used only to create the text from an existing model (you have imported the structure)			if (e.data.type == "texts" && e.data.action == "add" && e.data.structure != null && Config.toImport) {				var itemTextImp:Item = addItem(e.data.structure.@id, e.data.type, null, e.data.structure);				setSelectedItem(itemTextImp);				Utils.setNextPrice();			}			// update the text			if (Config.menuFamily == "texts" && e.data.action == "update") { // I clicked to the update button in the menu header				if (Config.currentItem.structure.type == "texts") { // means I'm acting on an existing text					Config.currentItem.structure.properties.font = Config.currentFontName;					Config.currentItem.content.defaultTextFormat = new TextFormat(Config.currentFontName, 18, 0);					Config.currentItem.content.antiAliasType = AntiAliasType.ADVANCED;           			Config.currentItem.content.autoSize = TextFieldAutoSize.NONE;					Config.currentItem.content.embedFonts = true;					Config.currentItem.content.textColor = Config.currentItem.structure.properties.color;					Config.currentItem.content.htmlText = "<p>"+ e.data.text + "</p>";					Config.currentItem.content.height = Config.currentItem.content.textHeight+5;					Config.currentItem.content.width  = Config.currentItem.content.textWidth+5;					Config.currentItem.structure.id = e.data.text;					Config.currentItem.myResizableMovieClip.centerItem();				}			}					}				/** Create and add the new item **/		public function addItem(id:String, type:String, itemXML:XML, structureXML:XML):Item {			var item:Item = customization.addItem(id, type, itemXML, null, structureXML);			item.name = id;			addChild(item);			return item;		}				/** Set a specific item as selected */		private function setSelectedItem(item:Item):void {			Config.currentItem = item;			Config.body.footer.update();		}		}}