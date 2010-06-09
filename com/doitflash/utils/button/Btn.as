package com.doitflash.utils.button
{
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// import classes
////////////////////////////////////////////////////////////////////////////////////
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.doitflash.events.ButtonEvent;
	/**
	 * Btn class is the base class for all of the different kind of Button classes.
	 * 
	 * @author Ali Tavakoli - 1/25/2010 8:09 PM
	 * @author Modified by Hadi Tavakoli - 2/6/2010 2:48 PM
	 * @version 3.0
	 * @example To create a clickable hit area:
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.utils.button.Btn;
	 * import com.doitflash.events.ButtonEvent;
	 * 
	 * var _btn:Btn = new Btn();
	 * 
	 * var _myHit:Hit = new Hit(); // this a custom Sprite that you want to use as your hit area
	 * 
	 * _btn.addEventListener(ButtonEvent.MOUSE_UP, onUp);
	 * _btn.addEventListener(ButtonEvent.ROLL_OVER, onOver);
	 * _btn.addEventListener(ButtonEvent.ROLL_OUT, onOut);
	 * _btn.addEventListener(ButtonEvent.MOUSE_DOWN, onDown);
	 * _btn.addEventListener(ButtonEvent.CLICK, onClick);
	 * _btn.addEventListener(ButtonEvent.DOUBLE_CLICK, onDoubleClick);
	 * _btn.addEventListener(ButtonEvent.ACTIVE, onActive);
	 * _btn.addEventListener(ButtonEvent.INACTIVE, onInactive);
	 * 
	 * _btn.addEventListener(ButtonEvent.ADDED_TO_STAGE, onStageAdded); // when the class is added to stage
	 * _btn.addEventListener(ButtonEvent.REMOVED_FROM_STAGE, onStageRemove); // when the class is removed from stage
	 * 
	 * _btn.handCursor = false;
	 * _btn.activated = true;
	 * _btn.id = 0; // indicates the hit area id
	 * 
	 * _btn.hit = _myHit.getChildByName("hitArea") as Sprite; // we have set a hit area, our hit area is now a Sprite insode of the _myHit
	 * 
	 * this.addChild(_btn);
	 * 
	 * function onUp(e:ButtonEvent):void
	 * {
	 * 		trace("up");
	 * }
	 * 
	 * function onOver(e:ButtonEvent):void
	 * {
	 * 		trace("over");
	 * }
	 * 
	 * function onOut(e:ButtonEvent):void
	 * {
	 * 		trace("out");
	 * }
	 * 
	 * function onDown(e:ButtonEvent):void
	 * {
	 * 		trace("down");
	 * }
	 * 
	 * function onClick(e:ButtonEvent):void
	 * {
	 * 		trace("click");
	 * }
	 * 
	 * function onDoubleClick(e:ButtonEvent):void
	 * {
	 * 		trace("double click");
	 * }
	 * 
	 * function onActive(e:ButtonEvent):void
	 * {
	 * 		trace("active");
	 * }
	 * 
	 * function onInactive(e:ButtonEvent):void
	 * {
	 * 		trace("inactive");
	 * }
	 * 
	 * function onStageAdded(e:ButtonEvent):void
	 * {
	 * 		trace("added to stage");
	 * }
	 * 
	 * function onStageRemove(e:ButtonEvent):void
	 * {
	 * 		trace("removed from stage");
	 * }
	 * 
	 * //////// if we didn't set hit, class would create a default hit itself and we could set width and height of the default hit
	 * //_btn.hitWidth = 20;
	 * //_btn.hitHeight = 20;
	 * 
	 * //////// protected functions:
	 * //setMoreSettings();
	 * //removeSettings();
	 * //onBtnUp();
	 * //onBtnOver();
	 * //onBtnOut();
	 * //onBtnDown();
	 * //onBtnClick();
	 * //onBtnDoubleClick();
	 * //onBtnActive();
	 * //onBtnInactive();
	 * 
	 * //////// protected variables:
	 * //_hit // give us the hit area
	 * //_isFirstTimeHitSet // tells if we have set hit or not
	 * </listing>
	 */
	public class Btn extends Sprite
	{
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// properties
////////////////////////////////////////////////////////////////////////////////////
		// needed variables
		protected var _id:int = 0;
		protected var _hit:*;
		protected var _isFirstTimeHitSet:Boolean = true; // if we had set _hit, then this is set to false and we don't draw a new _hit
		
		// input variables
		private var _hitWidth:Number = 5;
		private var _hitHeight:Number = 5;
		private var _activated:Boolean = true;
		private var _handCursor:Boolean = false;

////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// constructor function
////////////////////////////////////////////////////////////////////////////////////
		/**
		 * Constructor function
		 */
		public function Btn():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		}
		
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// methods
////////////////////////////////////////////////////////////////////////////////////

		// call it when the class is added to stage
		private function onStageAdded(e:Event):void
		{
			// remove listener
			this.removeEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			
			// set main settings
			setHit();
			
			setMoreSettings();
			
			setActivation();
			
			// dispatch it
			this.dispatchEvent(new ButtonEvent(ButtonEvent.ADDED_TO_STAGE));
		}
		
		/**
		 * this method is for children of the class to use it when it's added to stage.
		 */
		protected function setMoreSettings():void {}
		
		// when you remove the class from your stage thid method will be called to coolect the garbages.
		private function onStageRemove(e:Event):void
		{
			// remove listener
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
			
			// remove _hit
			if (_hit != null)
			{
				_hit.removeEventListener(MouseEvent.MOUSE_UP, onUp);
				_hit.removeEventListener(MouseEvent.ROLL_OVER, onOver);
				_hit.removeEventListener(MouseEvent.ROLL_OUT, onOut);
				_hit.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
				_hit.removeEventListener(MouseEvent.CLICK, onClick);
				_hit.removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
				
				this.removeChild(_hit);
				_hit = null;
			}
			
			removeSettings();
			
			// dispatch it
			this.dispatchEvent(new ButtonEvent(ButtonEvent.REMOVED_FROM_STAGE));
		}
		
		/**
		 * this method is for children of the class to use it when it's removed from stage.
		 */
		protected function removeSettings():void{}
		
		private function setHit():void
		{
			// if we didn't set hit by calling hit setter, set a default hit
			if (_isFirstTimeHitSet)
			{
				// remove the old _hit
				if (_hit != null)
				{
					_hit.removeEventListener(MouseEvent.MOUSE_UP, onUp);
					_hit.removeEventListener(MouseEvent.ROLL_OVER, onOver);
					_hit.removeEventListener(MouseEvent.ROLL_OUT, onOut);
					_hit.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
					_hit.removeEventListener(MouseEvent.CLICK, onClick);
					_hit.removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
					
					this.removeChild(_hit);
					_hit = null;
				}
				
				// draw a default _hit
				_hit = new Sprite();
				_hit.graphics.beginFill(0x000000, 0);
				_hit.graphics.drawRect(0, 0, _hitWidth, _hitHeight);
				_hit.graphics.endFill();
			}
			
			_hit.alpha = 0;
			
			this.addChild(_hit);
		}
		
		private function setActivation():void
		{
			if (_hit != null)
			{
				if(_activated) // if hit is active
				{
					_hit.mouseEnabled = true;
					_hit.mouseChildren = true;
					_hit.buttonMode = _handCursor;
					
					_hit.doubleClickEnabled = true;
					
					// add listeners
					_hit.stage.addEventListener(MouseEvent.MOUSE_UP, onUp, false, 0, true);
					_hit.addEventListener(MouseEvent.ROLL_OVER, onOver, false, 0, true);
					_hit.addEventListener(MouseEvent.ROLL_OUT, onOut, false, 0, true);
					_hit.addEventListener(MouseEvent.MOUSE_DOWN, onDown, false, 0, true);
					_hit.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
					_hit.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick, false, 0, true);
					
					this.dispatchEvent(new ButtonEvent(ButtonEvent.ACTIVE));
					
					onBtnActive();
				}
				else
				{
					_hit.mouseEnabled = false;
					_hit.mouseChildren = false;
					_hit.buttonMode = false;
					
					// remove listeners
					_hit.stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
					_hit.removeEventListener(MouseEvent.ROLL_OVER, onOver);
					_hit.removeEventListener(MouseEvent.ROLL_OUT, onOut);
					_hit.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
					_hit.removeEventListener(MouseEvent.CLICK, onClick);
					_hit.removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
					
					this.dispatchEvent(new ButtonEvent(ButtonEvent.INACTIVE));
					
					onBtnInactive();
				}
			}
		}
		
		// onUp, onOver, onOut, onDown, onClick, onDoubleClick functions
		private function onUp(e:MouseEvent):void
		{
			this.dispatchEvent(new ButtonEvent(ButtonEvent.MOUSE_UP));
			
			onBtnUp(e);
		}
		/**
		 * this method is for children of the class to use it when mouse is not over the button
		 */
		protected function onBtnUp(e:MouseEvent=null):void { }
		
		private function onOver(e:MouseEvent):void
		{
			this.dispatchEvent(new ButtonEvent(ButtonEvent.ROLL_OVER));
			
			onBtnOver(e);
		}
		/**
		 * this method is for children of the class to use it when mouse is over the button.
		 */
		protected function onBtnOver(e:MouseEvent=null):void { }
		
		private function onOut(e:MouseEvent):void
		{
			this.dispatchEvent(new ButtonEvent(ButtonEvent.ROLL_OUT));
			
			onBtnOut(e);
		}
		/**
		 * this method is for children of the class to use it when mouse is out of the button.
		 */
		protected function onBtnOut(e:MouseEvent=null):void { }
		
		private function onDown(e:MouseEvent):void
		{
			this.dispatchEvent(new ButtonEvent(ButtonEvent.MOUSE_DOWN));
			
			onBtnDown(e);
		}
		/**
		 * this method is for children of the class to use it when we pressed the button and not released yet.
		 */
		protected function onBtnDown(e:MouseEvent=null):void { }
		
		private function onClick(e:MouseEvent):void
		{
			this.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
			
			onBtnClick(e);
		}
		/**
		 * this method is for children of the class to use it when the button is clicked.
		 */
		protected function onBtnClick(e:MouseEvent=null):void { }
		
		private function onDoubleClick(e:MouseEvent):void
		{
			this.dispatchEvent(new ButtonEvent(ButtonEvent.DOUBLE_CLICK));
			
			onBtnDoubleClick(e);
		}
		/**
		 * this method is for children of the class to use it when the button is double clicked.
		 */
		protected function onBtnDoubleClick(e:MouseEvent=null):void { }
		
		/**
		 * this method is for children of the class to use it when the button is active.
		 */
		protected function onBtnActive():void { }
		
		/**
		 * this method is for children of the class to use it when the button is inactive.
		 */
		protected function onBtnInactive():void { }
		
		//**********************************************************************************
		// ***************************************************************** SETTER - GETTER functions for all kinds of buttons
		//**********************************************************************************
		
		/**
		 * if hit is not set already uses the default hit area, indicates the width of the default hit area
		 * 
		 * @default 5
		 */
		public function get hitWidth():Number
		{
			return _hitWidth;
		}
		/**
		 * @private
		 */
		public function set hitWidth(b:Number):void
		{
			if(b != _hitWidth)
			{
				_hitWidth = b;
				
				if ( stage)
				{
					setHit();
					setActivation();
				}
			}
		}
		
		/**
		 * if hit is not set already uses the default hit area, indicates the height of the default hit area
		 * 
		 * @default 5
		 */
		public function get hitHeight():Number
		{
			return _hitHeight;
		}
		/**
		 * @private
		 */
		public function set hitHeight(b:Number):void
		{
			if(b != _hitHeight)
			{
				_hitHeight = b;
				
				if ( stage)
				{
					setHit();
					setActivation();
				}
			}
		}
		
		/**
		 * if <code>true</code>, hand cursor is available,
		 * if <code>false</code> hand cursor is unavailable.
		 * 
		 * @default false
		 */
		public function get handCursor():Boolean
		{
			return _handCursor;
		}
		/**
		 * @private
		 */
		public function set handCursor(b:Boolean):void
		{
			if(b != _handCursor)
			{
				_handCursor = b;
				
				if( stage) setActivation();
			}
		}
		
		/**
		 * if <code>true</code>, hit is active,
		 * if <code>false</code> it is inactive.
		 * 
		 * @default true
		 */
		public function get activated():Boolean
		{
			return _activated;
		}
		/**
		 * @private
		 */
		public function set activated(b:Boolean):void
		{
			_activated = b;
			
			if (stage) setActivation();
		}
		
		/**
		 * indicates the hit area.
		 * 
		 * @default Sprite
		 */
		public function get hit():*
		{
			return _hit;
		}
		/**
		 * @private
		 */
		public function set hit(b:*):void
		{
			_isFirstTimeHitSet = false; // to stop creating a new Sprite as hit
			
			if (_hit != null)
			{
				if(b != _hit)
				{
					// remove the old _hit
					_hit.stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
					_hit.removeEventListener(MouseEvent.ROLL_OVER, onOver);
					_hit.removeEventListener(MouseEvent.ROLL_OUT, onOut);
					_hit.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
					_hit.removeEventListener(MouseEvent.CLICK, onClick);
					_hit.removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
					
					this.removeChild(_hit);
					_hit = null;
				}
			}
			_hit = b;
			
			if (stage)
			{
				setHit();
				setActivation();
			}
		}
		
		/**
		 * indicates the id.
		 * @default	0
		 */
		public function get id():int
		{
			return _id;
		}
		/**
		 * @private
		 */
		public function set id(a:int):void
		{
			_id = a;
		}
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
	}
}