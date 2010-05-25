/**
 * View conatiner. 
 * Here are placed all views (small one, used to chose the main view) 
 * 
 **/

package com.ipnotica.content.blackboard.views {
	
	import com.ipnotica.content.blackboard.views.selector.Selector;
	import com.ipnotica.content.blackboard.views.view.View;
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;

	public class Views extends MovieClip {
		
		public var selector:Selector;
		
		public function Views() {
			super();
		}
		
		/** Add all product view */
		public function addViews():void {
			for (var i:uint=0; i<Config.views.length(); i++) 
				addView(Config.views[i].@id);
			showSelectedView();
			swapUpSelector();
		}
		
		// Add a single product view
		private function addView(id:String):void {
			var view:View = new View(id);
			view.visible = false;
			view.name = id;
			addChild(view);
		}
		
		
		/** Show the selected view (settled up in Config.viewID) */
		public function showSelectedView():void {
			hideAllViews();
			showView();
		}
		
		// Hide all views
		private function hideAllViews():void {
			for (var i:uint=0; i<Config.views.length(); i++) {
				getChildByName(Config.views[i].@id).visible = false;
			}
		}
		
		// Show the selected one
		private function showView():void {
			getChildByName(Config.viewID).visible = true;
		}
		
		private function swapUpSelector():void {
			addChild(selector);
		}
		
	}
}