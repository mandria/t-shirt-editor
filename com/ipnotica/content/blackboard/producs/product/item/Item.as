/**
 * Represet a superclass for all possible items such as TextField, 
 * MovieClip and Images. Here there will be a type that represent
 * which item we are talking about and we should define a structure
 * for every item type (object) so that we can serialize it in a 
 * cookie if necessary. 
 * 
 **/

package com.ipnotica.content.blackboard.producs.product.item {
	
	import com.greensock.TweenLite;
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;

	public class Item extends MovieClip {
		
		public var structure:Object;
		public var itemXML:XML;
		public var content:MovieClip;
		
		public function Item(structure:Object, itemXML:XML) {
			super();
			this.structure = structure;
			this.itemXML = itemXML;
			buttonMode = true;
		}
		
		
		/**
		 * Apply the properties settled up into structure.properties
		 **/
		 
		public function applyProperties():void {
			for (var name:String in structure.properties) {
				applyProperty(name, structure.properties[name]);
			}
		}
		
		private function applyProperty(property:String, value:*):void {
			switch (property) {
				case "x"       : setHorizontalValue(value); break;
				case "y"       : setVerticalValue(value); break;
				//case "rotation": addRotationButton(); break;
				//case "scale"   : addScaleButton(); break;
				case "color"   : setColorValue(value); break;
				default:  trace ("The property", property," is not HANDLED");
			}
		}
		
		/** X position setting */
		private function setHorizontalValue(value:*):void {
			trace ("The property x has been defined at", value);
			x = value;
		}
		
		/** Y position setting */
		private function setVerticalValue(value:*):void {
			trace ("The property y has been defined at", value);
			y = value;
		}
		
		/** Color setting */
		private function setColorValue(value:*):void {
			if (value == null) { initColorProperties(); }
			setColor();
		}
		
		private function initColorProperties():void {
			var colors:Array = []
			var layers:XMLList = Config.currentItem.itemXML.layers;
			for (var i:int = 0; i < layers.layer.length(); i++) {
				colors[i] = {};
				colors[i].id = layers.layer[i].@id;
				var color:Number = ("@color" in layers.layer[i]) ? layers.layer[i].@color : 0xFFFFFF; 
				colors[i].color = color;
			}
			structure.properties.color = colors;
		}
		
		private function setColor():void {
			// set the colors to the MovieClip
			
			//var layer:MovieClip = Config.currentItem.content[layers.layer[i].@id];
			//TweenLite.to(layer, 0, {tint: colors[i].color})
		}

	}
}