package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * ScrollEvent class shows all the events being dispatched with the ScrollBar.
	 * @author Ali Tavakoli
	 */
	public class ScrollEvent extends Event
	{
		/**
		 * @private
		 */
		public static const TWEEN_COMPLETE:String = "myTweenComplete";
		
		/**
		 * Dispatches when the mask width is modified.
		 */
		public static const MASK_WIDTH:String = "myMaskWidth";
		/**
		 * Dispatches when the mask height is modified.
		 */
		public static const MASK_HEIGHT:String = "myMaskHeight";
		/**
		 * Dispatches when the scrollbar is initialized and added to stage.
		 */
		public static const ENTER_FRAME:String = "myEnterFrame";
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function ScrollEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param = data;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @private
		 */
		public function get param():*
		{
			return _param;
		}
	}
}