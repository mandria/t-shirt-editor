/**
 * Small preview that contains a thumb of the view we can select 
 * (front, back, side DX, side SX). Be careful that not all products
 * have all these options, so we should set it somewhere. 
 * 
 * For example a cup do not have multiple views  
 * 
 **/

package com.ipnotica.content.blackboard.views.view {
	
	import flash.display.MovieClip;

	public class View extends MovieClip {
		
		public var id:String;
		public var XMLView:XML;
		public var image:ViewImage;
		
		public function View(id:String, XMLView:XML) {
			super();
			this.id = id;
			this.XMLView = XMLView;
			init();
		}
		
		private function init():void {
			image.addImage(id, XMLView);
		}
		
	}
}