/**
 * View conatiner. 
 * Here are placed all views (small one, used to chose the main view) 
 * 
 **/

package com.ipnotica.content.blackboard.views {
	
	import com.ipnotica.content.blackboard.views.message.ViewMessage;
	import com.ipnotica.content.blackboard.views.selector.Selector;
	import com.ipnotica.content.blackboard.views.view.View;
	import com.ipnotica.utils.Config;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Views extends MovieClip {
		
		public var selector:Selector;
		public var message:ViewMessage;
		
		private var outOpacity:Number = 0.35;
		private var overOpacity:Number = 0.85;
		
		public function Views() {
			super();
			init();
		}
		
		private function init():void {
			selector.alpha = outOpacity;
			initEvents();
		}
		
		private function initEvents():void {
			addEventListener(MouseEvent.MOUSE_OVER, onOverViews);
			addEventListener(MouseEvent.MOUSE_OUT, onOutViews);
		}
		
		private function onOverViews(e:Event):void { selector.alpha = overOpacity; }
		private function onOutViews(e:Event):void  { selector.alpha = outOpacity;  }
		
		
		/** Add all views */
		public function addViews():void {
			for (var i:uint=0; i<Config.views.length(); i++) 
				addView(Config.views[i].@id);
			showSelectedView();
			showSelector();
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
			getChildByName(Config.viewVisibleID).visible = true;
		}
		
		/** Init the selector to navigate between views */
		private function showSelector():void {
			addChild(selector);
			selector.init();
			addChild(message);
		}
		
		public function resetFirstView():void {
			Config.body.content.blackboard.views.selector.index = 0;
			Config.body.content.blackboard.views.selector.changeProduct();
			Config.body.content.blackboard.views.selector.onRightClick(null);
			Config.body.footer.clear();
		}

		
	}
}