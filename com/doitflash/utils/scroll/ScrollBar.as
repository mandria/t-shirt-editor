package com.doitflash.utils.scroll
{
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// import classes
////////////////////////////////////////////////////////////////////////////////////
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import com.doitflash.events.ScrollEvent;
	
	/**
	 * ScrollBar class is the base class of scrollbars.
	 * @see ScrollEvent
	 * 
	 * @author Ali Tavakoli - 1/27/2010 8:01 PM
	 * @version 3.0
	 * 
	 */
	public class ScrollBar extends Sprite
	{
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// properties
////////////////////////////////////////////////////////////////////////////////////
		// needed variables
		/**
		 * @private
		 */
		protected var _propSaver:Object;
		
		private var _maskHolder:Sprite;
		private var _mask:Sprite;
		
		// input variables
		private var _width:Number;
		private var _height:Number;
		
		private var _contentBg:Sprite;
		private var _maskContent:DisplayObject;
		
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// constructor function
////////////////////////////////////////////////////////////////////////////////////
		/**
		 * Constructor function
		 */
		public function ScrollBar():void
		{
			// let's make the _maskHolder
			_maskHolder = new Sprite();
			this.addChild(_maskHolder);
			
			// set default variables
			_width = 100;
			_height = 100;
			_maskContent = new Sprite();
			_maskHolder.addChild(_maskContent);
			
			// set the object to save the setters value inside it self
			_propSaver = new Object();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		}
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// methods
////////////////////////////////////////////////////////////////////////////////////

		//**********************************************************************************
		// ***************************************************************** MAIN METHODS
		//**********************************************************************************
		
		// onStageAdded function
		private function onStageAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
			
			// let's set the settings
			setMask();
			setContentBg();
			
			// this class's children can override this function if they needed to do more works
			setMoreSettings();
		}
		
		// onStageRemove function
		private function onStageRemove(e:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
			this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded, false, 0, true);
			
			// let's remove the settings
			gc();
			
			// this class's children can override this function if they needed to do remove the works they have done
			removeSettings();
		}
		
		// here is the setMask function
		private function setMask():void
		{
			// remove the old _mask
			if(_mask != null)
			{
				// remove _mask
				_mask.graphics.clear();
				_maskHolder.removeChild(_mask);
				_mask = null;
			}
			
			// create the mask content if it's null, if this class is added to stage (have set the settings) and then is removed from stage (have removed the setting) and we nulled the _maskContent in gc()
			if (_maskContent == null)
			{
				_maskContent = new Sprite();
				trace("mask content is removed, please set the mask content again.");
			}
			
			// create the mask
			_mask = new Sprite();
			//_mask.graphics.lineStyle(5, 0x0000FF, .5, false);
			_mask.graphics.beginFill(0xFFFFFF, 1);
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();
			_maskContent.mask = _mask;
			
			// place the _mask and  _maskContent in the _maskHolder
			_maskHolder.addChild(_maskContent);
			_maskHolder.addChild(_mask);
		}
		
		// here is the setContentBg function
		private function setContentBg():void
		{
			// remove the old _contentBg
			if(_contentBg != null)
			{
				// remove _contentBg
				_contentBg.graphics.clear();
				_maskHolder.removeChild(_contentBg);
				_contentBg = null;
			}
			
			// create the content background
			_contentBg = new Sprite();
			//_contentBg.graphics.lineStyle(5, 0x0000FF, .5, false);
			_contentBg.graphics.beginFill(0xFFFFFF, 0);
			_contentBg.graphics.drawRect(0, 0, _width, _height);
			_contentBg.graphics.endFill();
			
			// place the _contentBg in the _maskHolder
			_maskHolder.addChildAt(_contentBg, 0);
		}
		
		// here is the gc function
		private function gc():void
		{
			// remove the old _mask
			if(_mask != null)
			{
				// remove _mask
				_maskContent.mask = null;
				_mask.graphics.clear();
				_maskHolder.removeChild(_mask);
				_mask = null;
			}
			
			// remove the old _contentBg
			if(_contentBg != null)
			{
				// remove _contentBg
				_contentBg.graphics.clear();
				_maskHolder.removeChild(_contentBg);
				_contentBg = null;
			}
			
			// remove the old _maskHolder
			if(_maskContent != null)
			{
				if (_maskContent.parent == _maskHolder)
				{
					_maskHolder.removeChild(_maskContent);
					_maskContent = null;
				}
			}
		}
		
		/**
		 * this method is for children of the class to use it when it's added to stage.
		 */
		protected function setMoreSettings():void { };
		/**
		 * this method is for children of the class to use it when it's removed from stage.
		 */
		protected function removeSettings():void{};
		
		//**********************************************************************************
		// ***************************************************************** SETTER - GETTER
		//**********************************************************************************
		
		/**
		 * indicates mask width.
		 * @default 100
		 */
		public function get maskWidth():Number
		{
			return _width;
		}
		/**
		 * @private
		 */
		public function set maskWidth(w:Number):void
		{
			if(w != _width)
			{
				_width = w;
				_width = Math.max(RegSimpleConst.MASK_MIN_WIDTH, _width);
				
				_propSaver.maskWidth = _width; // pass the new value to the value of the object property
				
				if(stage)
				{
					setMask();
					setContentBg();
					setMoreSettings();
				}
				
				this.dispatchEvent(new ScrollEvent(ScrollEvent.MASK_WIDTH));
			}
		}
		
		/**
		 * indicates mask height.
		 * @default 100
		 */
		public function get maskHeight():Number
		{
			return _height;
		}
		/**
		 * @private
		 */
		public function set maskHeight(h:Number):void
		{
			if(h != _height)
			{
				_height = h;
				_height = Math.max(RegSimpleConst.MASK_MIN_HEIGHT, _height);
				
				_propSaver.maskHeight = _height; // pass the new value to the value of the object property
				
				if(stage)
				{
					setMask();
					setContentBg();
					setMoreSettings();
				}
				
				this.dispatchEvent(new ScrollEvent(ScrollEvent.MASK_HEIGHT));
			}
		}
		
		/**
		 * indicates mask content.
		 */
		public function get maskContent():DisplayObject
		{
			return _maskContent;
		}
		/**
		 * @private
		 */
		public function set maskContent(c:DisplayObject):void
		{
			if(c != _maskContent)
			{
				// remove the old _maskContent
				if (_maskContent != null)
				{
					_maskHolder.removeChild(_maskContent);
					_maskContent = null;
				}
				
				_maskContent = c;
				
				if(stage)
				{
					setMask();
					setMoreSettings();
				}
			}
		}
		
		/**
		 * @private
		 */
		public function get contentBg():Sprite
		{
			return _contentBg;
		}
		
		/**
		 * export the class and send the Object that holds all of the setters values.
		 */
		public function get exportProp():Object
		{
			return _propSaver;
		}
		/**
		 * import the class and get the Object that holds all of the setters values.
		 */
		public function set importProp(sc:Object):void
		{
			for (var prop:* in sc)
			{
				this[prop] = sc[prop];
			}
		}
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
	}
}