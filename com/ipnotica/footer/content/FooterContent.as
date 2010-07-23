/**
 * Collect all buttons used to transform an Item.
 * 
 **/

package com.ipnotica.footer.content {
	
	import com.ipnotica.footer.buttons.colorbuttons.ColorButton;
	import com.ipnotica.footer.buttons.horizontalbuttons.HorizontalButtons;
	import com.ipnotica.footer.buttons.removebuttons.RemoveButton;
	import com.ipnotica.footer.buttons.rotationbuttons.RotationButtons;
	import com.ipnotica.footer.buttons.scalebuttons.ScaleButtons;
	import com.ipnotica.footer.buttons.verticalbuttons.VerticalButtons;
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;

	public class FooterContent extends MovieClip {
		
		public var buttons:Object;
		
		private var initialX:uint = 0;
		
		public function FooterContent() {
			super();
		}
		
		/** Populate the footer with all buttons related to a specific item (swf, png, text) */
		public function update():void {
			buttons = Config.currentItem.structure.properties;
			addButtons();
		}
		
		/** Add all buttons */
		private function addButtons():void {
			for (var name:String in buttons){
				addButton(name, buttons[name]);
			}
			addButton("remove", "remove element");
		}
		
		/** Check which button we have to add */
		private function addButton(name:String, value:String):void {
			switch (name) {
				case "x"       : addHorizontalButtons(); break;
				case "y"       : addVerticalButtons();   break;
				case "rotation": addRotationButtons(); break;
				case "scale"   : addScaleButtons(); break;
				case "color"   : addColorButtons(); break;
				case "remove"  : addRemoveButtons(); break;
				default:  trace ("Other buttons can be added");
			}
		}
		
		// add buttons for horizontal movements
		private function addHorizontalButtons():void {
			var button:HorizontalButtons = new HorizontalButtons();
			addChild(button);
			button.x = initialX;
			initialX += button.width;
		}
		
		// add buttons for vertical movements
		private function addVerticalButtons():void {
			var button:VerticalButtons = new VerticalButtons();
			addChild(button);
			button.x = initialX;
			initialX += button.width;
		}
		
		// add rotation movements
		private function addRotationButtons():void {
			var button:RotationButtons = new RotationButtons();
			addChild(button);
			button.x = initialX;
			initialX += button.width;
		}
		
		// add scale movements
		private function addScaleButtons():void {
			var button:ScaleButtons = new ScaleButtons();
			addChild(button);
			button.x = initialX;
			initialX += button.width;
		}
		
		// add color picker
		private function addColorButtons():void {
			var button:ColorButton = new ColorButton(Config.currentItem.structure.type);
			button.name = "colorButton";
			addChild(button);
			button.x = initialX;
			initialX += button.width;
		}
		
		// add delete bottons
		private function addRemoveButtons():void {
			var button:RemoveButton = new RemoveButton();
			addChild(button);
			button.x = initialX;
			initialX += button.width;
		}
		
	}
}