/**
 * Header information for the menu. 
 * 
 * - Select box with category definition of MovieClips (or images)
 * - Text definition to insert over the tshirt
 * 
 **/
 
 package com.ipnotica.menu.header {
	
	import com.doitflash.consts.Ease;
	import com.doitflash.events.MenuEvent;
	import com.doitflash.utils.menu.DropdownMenu;
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;

	public class MenuHeader extends MovieClip{
		
		public var combo:DropdownMenu;
		
		public function MenuHeader() {
			super();
		}
		
		public function update():void {
			if (Config.menuFamily == "images") { updateForImages() };
		}
		
		
		/**
		 * Create the header used for the images. It consists into 
		 * the definition of a combobox to choose between categories
		 * and the upload button
		 **/
		private function updateForImages():void {
			buildImageCombo();
		}
		
		private function buildImageCombo():void {
			
			// path initalization
			var imagePath:String = Config.flashvars.httpDomain + Config.flashvars.assets + "images/header/combo/";
			var xmlPath:String   = Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + "";
			
			// initialization
			combo = new DropdownMenu();
			combo.addEventListener(MenuEvent.SELECTED, onItemSelected);
			
			// positioning initialization
			combo.x = 10; 
			combo.y = 30;
			combo.width = 250;
			combo.headHeight = 30;
			combo.bodyHeight = 260;
			combo.embedFonts = true;
			
			// configurations
			combo.setSpeed = .5;
			combo.setEase = Ease.Quint_easeInOut;
			combo.setHeadBg("glassyBg", { holder:combo, glassColor:0x000000, glassAlpha:0.3, glassBlurQuality:5, glassBlur:7 } );
			combo.headAlpha = 1;
			combo.bodyAlpha = 0;
			combo.headArrowImages = [imagePath + "subArrow_2.png", imagePath + "subArrowOver_2.png", imagePath + "subArrowOver_2.png"];
			combo.setTxtStyle("verdana", 0xFFFFFF, 0x48B4E1, 14, "ltr");
			combo.contentPath = xmlPath + "categories.xml";
			this.parent.addChild(combo);
		}
		
		// Redraw only if is selected a new category
		private function onItemSelected(e:MenuEvent):void {
			if (Config.currentCategory != e.param.address) {
				Config.currentCategory = e.param.address;
				Config.body.menu.updateContent();
			}
		}
		
		
					
		/**
		 * Remove all content into the slider
		 **/
		
		public function clear():void {
			if (combo) { this.parent.removeChild(combo); }
			combo = null;
		}
		
	}
}