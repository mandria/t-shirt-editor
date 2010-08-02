﻿/** * Header information for the menu.  *  * - Select box with category definition of MovieClips (or images) * - Text definition to insert over the tshirt *  **/  package com.ipnotica.menu.header {		import com.doitflash.consts.Ease;	import com.doitflash.events.MenuEvent;	import com.doitflash.utils.menu.DropdownMenu;	import com.ipnotica.utils.Config;	import com.ipnotica.utils.CustomEvents;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.FocusEvent;	import flash.events.MouseEvent;	import flash.text.AntiAliasType;	import flash.text.TextField;	import flash.text.TextFieldType;	import flash.text.TextFormat;	public class MenuHeader extends MovieClip{				public var description:TextField;		public var productDescription:MovieClip;		public var upload:Upload;		public var addText:MovieClip;		public var updateText:MovieClip;		public var input:TextField;				public var combo:DropdownMenu;				public function MenuHeader() {			super();			init();		}				private function init():void {			initStructure();			initEvents();		}				private function initStructure():void {			addText.buttonMode = updateText.buttonMode = true;			productDescription.visible = addText.visible = updateText.visible = false;		}				private function initEvents():void {			addText.addEventListener(MouseEvent.CLICK, onClickAddText);			updateText.addEventListener(MouseEvent.CLICK, onClickUpdateText);		}						private function onClickAddText(e:Event):void {			Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {text: input.text, action: "add"}));		}				private function onClickUpdateText(e:Event):void {			Config.doc.dispatchEvent(new CustomEvents(CustomEvents.THUMB_CLICKED, {text: input.text, action: "update"}));		}						public function update():void {			if (Config.menuFamily == "products") { updateForProducts() };			if (Config.menuFamily == "images")   { updateForImages() };			if (Config.menuFamily == "texts")    { updateForTexts() };		}						/**		 * Create the header used for the images. It consists into 		 * the definition of a combobox to choose between categories		 * and the upload button		 **/		private function updateForImages():void {			buildImageCombo();			showButtons(Config.menuFamily);		}				private function buildImageCombo():void {						// path initalization			var imagePath:String = Config.flashvars.httpDomain + Config.flashvars.assets + "images/header/combo/";			var xmlPath:String   = Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "";						// initialization			combo = new DropdownMenu();			combo.addEventListener(MenuEvent.SELECTED, onItemSelected);						// positioning initialization			combo.x = 6; 			combo.y = 27;			combo.width = 290;			combo.headHeight = 30;			combo.bodyHeight = 260;			combo.embedFonts = true;						// configurations			combo.setSpeed = .5;			combo.setEase = Ease.Quint_easeInOut;			combo.setHeadBg("glassyBg", { holder:combo, glassColor:0x000000, glassAlpha:0.3, glassBlurQuality:5, glassBlur:7 } );			combo.headAlpha = 1;			combo.bodyAlpha = 0;			combo.headArrowImages = [imagePath + "subArrow_2.png", imagePath + "subArrowOver_2.png", imagePath + "subArrowOver_2.png"];			combo.setTxtStyle("verdana", 0xFFFFFF, 0x48B4E1, 14, "ltr");			combo.contentPath = xmlPath + "categories.xml";			this.parent.addChild(combo);		}				// Redraw only if is selected a new category		private function onItemSelected(e:MenuEvent):void {			if (Config.currentCategory != e.param.address) {				Config.currentCategory = e.param.address;				Config.body.menu.updateContent();			}		}								private function updateForProducts():void {			trace("-- Loading product header");			description.text = "Choose a product";			showButtons(Config.menuFamily);		}						/**		 * 		 * TEXT INSERT HEADER UPDATE		 * 		 **/		private function updateForTexts():void {			showButtons(Config.menuFamily);			initInputText();		}				public function initInputText(text:String = "Write a text..."):void {			if (getChildByName("input")) { removeChild(input) };  			input = new TextField();			input.name = "input";			input.defaultTextFormat = new TextFormat(Config.currentFontName, 14, 0);			input.embedFonts = true;			input.type = TextFieldType.INPUT;			input.antiAliasType = AntiAliasType.ADVANCED;			input.border = true;			input.textColor = 0x00CBFF			input.borderColor = 0xAAAAAA;			input.x = 3;			input.y = 5;			input.height = 55;			input.width = 296;			input.multiline = true;			input.wordWrap = true;			input.text = text			addChild(input);			input.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);			input.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);		}				private function onFocusIn(e:FocusEvent):void {			if (input.text == "Write a text...") { input.text = ""; }		}				private function onFocusOut(e:FocusEvent):void {			if (input.text == "") { input.text = "Write a text..." }		}											/**		 * Remove all content into the slider		 **/				public function clear():void {					}				public function showButtons(family:String):void {			if (family == "texts") { 				productDescription.visible = upload.visible = description.visible = false; addText.visible = updateText.visible = true;				if (Config.currentItem) { updateText.visible = (Config.currentItem.structure.type == "texts"); }				else { updateText.visible = false; }			}			if (family == "images") { upload.visible = description.visible = true;  productDescription.visible = addText.visible = updateText.visible = false; }			if (family == "products") { productDescription.visible = true;  description.visible = upload.visible = addText.visible = updateText.visible = false; }					}			}}