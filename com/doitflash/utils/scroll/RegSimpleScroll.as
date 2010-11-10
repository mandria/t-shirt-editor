package com.doitflash.utils.scroll
{
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// import classes
////////////////////////////////////////////////////////////////////////////////////
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	//import flash.system.System;
	//import fl.transitions.Tween;
	//import fl.transitions.easing.*;
	//import fl.transitions.TweenEvent;
	/*import gs.plugins.*;
	import gs.events.*;
	import gs.easing.*;
	import gs.*;*/
	
	import com.greensock.plugins.*;
	import com.greensock.*; 
	import com.greensock.events.*;
	import com.greensock.easing.*;
	//import com.greensock.easing.EaseLookup;
	
	import com.doitflash.utils.scroll.*;
	import com.doitflash.events.ScrollEvent;
	import com.doitflash.consts.Orientation;
	import com.doitflash.consts.Easing;
	
	//import flash.utils.getTimer;
	
	/**
	 * RegSimpleScroll is a class to create different kinds of scrollbars in different looks.
	 * @see ScrollBar
	 * @see com.doitflash.events.ScrollEvent
	 * @see com.doitflash.consts.Orientation
	 * @see com.doitflash.consts.Easing
	 * @see EffectConst
	 * @see RegSimpleConst
	 * 
	 * @author Ali Tavakoli - 1/27/2010 5:09 PM
	 * modified - 8/21/2010 7:12 PM
	 * @version 3.0
	 * 
	 * @example The following example shows you how to create a simple scrollbar,
	 * I have called all of the scrollbar inputs in this example to show you the available setters,
	 * but scrollbar works perfect even if you just set one input and it's nothing but your content.
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.events.ScrollEvent;
	 * import com.doitflash.consts.Orientation;
	 * import com.doitflash.consts.Easing;
	 * import com.doitflash.utils.scroll.EffectConst;
	 * import com.doitflash.utils.scroll.RegSimpleConst;
	 * import com.doitflash.utils.scroll.RegSimpleScroll;
	 * 
	 * var _regSimpleScroll:RegSimpleScroll =  new RegSimpleScroll();
	 * var _myContent:MyContent = new MyContent(); // the content you want to scroll
	 * 
	 * this.addChild(_regSimpleScroll);
	 * 
	 * _regSimpleScroll.addEventListener(ScrollEvent.ENTER_FRAME, onScrollEnterFrame); // this listener works like a simple on Enter Frame
	 * _regSimpleScroll.addEventListener(ScrollEvent.MASK_WIDTH, onMaskWidth); // listens when ever the mask width changes by calling maskWidth setter
	 * _regSimpleScroll.addEventListener(ScrollEvent.MASK_HEIGHT, onMaskHeight); // listens when ever the mask height changes by calling maskHeight setter
	 * 
	 * // set inputs
	 * _regSimpleScroll.maskContent = _myContent;
	 * _regSimpleScroll.maskWidth = 200;
	 * _regSimpleScroll.maskHeight = 200;
	 * 
	 * _regSimpleScroll.orientation = Orientation.AUTO; // accepted values: Orientation.AUTO, Orientation.VERTICAL, Orientation.HORIZONTAL
	 * _regSimpleScroll.scrollSpace = 5; // max value is RegSimpleConst.SCROLL_MAX_SPACE
	 * _regSimpleScroll.drawDisabledScroll = true;
	 * _regSimpleScroll.scrollEaseType = Easing.Elastic_easeOut;
	 * _regSimpleScroll.scrollAniInterval = 3;
	 * _regSimpleScroll.scrollBlurEffect = true;
	 * _regSimpleScroll.scrollManualY = 0; // min value is 0, max value is 100
	 * _regSimpleScroll.scrollManualX = 0; // min value is 0, max value is 100
	 * _regSimpleScroll.mouseWheelSpeed = 2;
	 * 
	 * 	// bg
	 * _regSimpleScroll.bgEffectType = EffectConst.COLOR; // accepted values: EffectConst.COLOR, EffectConst.GLOW, EffectConst.COLOR_GLOW
	 * _regSimpleScroll.bgEffectColor = 0xAD2C2C;
	 * _regSimpleScroll.bgEffectAlpha = 1;
	 * _regSimpleScroll.bgEffectAniInterval = .5;
	 * _regSimpleScroll.bgGlowBlur = 0; // no glow blur
	 * _regSimpleScroll.bgGlowStrength = 0; // no glow strength
	 * 
	 * _regSimpleScroll.bgCurve = 10; // max value is bg width
	 * _regSimpleScroll.bgW = 10;	// max value is RegSimpleConst.BG_MAX_WIDTH
	 * _regSimpleScroll.bgColor = 0x333333;
	 * _regSimpleScroll.bgAlpha = .5;
	 * 
	 * 	// slider
	 * _regSimpleScroll.sliderEffectType = EffectConst.COLOR_GLOW; // accepted values: EffectConst.COLOR, EffectConst.GLOW, EffectConst.COLOR_GLOW
	 * _regSimpleScroll.sliderEffectColor = 0xAD2C2C;
	 * _regSimpleScroll.sliderEffectAlpha = 1;
	 * _regSimpleScroll.sliderEffectAniInterval = .5;
	 * _regSimpleScroll.sliderGlowBlur = 5;
	 * _regSimpleScroll.sliderGlowStrength = 1;
	 * 
	 * _regSimpleScroll.sliderSpace = 0; // max value is (bg width/2) or (bg height/2)
	 * _regSimpleScroll.sliderCurve = 10; // max value is slider width
	 * _regSimpleScroll.sliderW = 10; // max value is RegSimpleConst.SLIDER_MAX_WIDTH
	 * _regSimpleScroll.sliderH = 0; // 0 means auto height, min value is RegSimpleConst.SLIDER_MIN_HEIGHT, max value is bg height
	 * _regSimpleScroll.sliderColor = 0x333333;
	 * _regSimpleScroll.sliderAlpha = 1;
	 * _regSimpleScroll.sliderAniInterval = 1;
	 * 
	 * 	// btn
	 * _regSimpleScroll.btnEffectType = EffectConst.COLOR_GLOW; // accepted values: EffectConst.COLOR, EffectConst.GLOW, EffectConst.COLOR_GLOW
	 * _regSimpleScroll.btnEffectColor = 0xAD2C2C;
	 * _regSimpleScroll.btnEffectAlpha = 1;
	 * _regSimpleScroll.btnEffectAniInterval = 1;
	 * _regSimpleScroll.btnGlowBlur = 5;
	 * _regSimpleScroll.btnGlowStrength = 1;
	 * 
	 * _regSimpleScroll.btnSpace = 5; // max value is RegSimpleConst.BTN_MAX_SPACE
	 * _regSimpleScroll.btnLayout = RegSimpleConst.TRIANGLE; // accepted values: RegSimpleConst.TRIANGLE, RegSimpleConst.CIRCLE
	 * _regSimpleScroll.btnSize = 10; // 0 means no buttons, max value is RegSimpleConst.BTN_MAX_SIZE, min value is RegSimpleConst.BTN_MIN_SIZE
	 * _regSimpleScroll.btnColor = 0x333333;
	 * _regSimpleScroll.btnAlpha = 1;
	 * _regSimpleScroll.btnScrollSpeed = 2;
	 * 
	 * function onScrollEnterFrame(e:ScrollEvent):void
	 * {
	 * 		trace(_regSimpleScroll.scrollManualY);
	 * }
	 * 
	 * function onMaskWidth(e:ScrollEvent):void
	 * {
	 * 		trace(_regSimpleScroll.maskWidth);
	 * }
	 * 
	 * function onMaskHeight(e:ScrollEvent):void
	 * {
	 * 		trace(_regSimpleScroll.maskHeight);
	 * }
	 * </listing>
	 * 
	 * @example The following example shows you how to create a simple scrollbar,
	 * then export it and duplicating it for an other content.
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.events.ScrollEvent;
	 * import com.doitflash.consts.Orientation;
	 * import com.doitflash.consts.Easing;
	 * import com.doitflash.utils.scroll.EffectConst;
	 * import com.doitflash.utils.scroll.RegSimpleConst;
	 * import com.doitflash.utils.scroll.RegSimpleScroll;
	 * 
	 * var _regSimpleScroll:RegSimpleScroll =  new RegSimpleScroll();
	 * var _regSimpleScroll2:RegSimpleScroll =  new RegSimpleScroll(); // scrollbar that you want to duplicate from the first one
	 * 
	 * var _myContent:MyContent = new MyContent(); // the first content you want to scroll by the first scrollbar
	 * var _myContent2:MyContent2 = new MyContent2(); // the second content you want to scroll by the second scrollbar (the duplicated scrollbar from the first scrollbar)
	 * 
	 * this.addChild(_regSimpleScroll);
	 * this.addChild(_regSimpleScroll2);
	 * _regSimpleScroll2.x = 250;
	 * 
	 * // set inputs for the first scrollbar
	 * 
	 * _regSimpleScroll.maskContent = _myContent;
	 * _regSimpleScroll.maskWidth = 200;
	 * _regSimpleScroll.maskHeight = 200;
	 * _regSimpleScroll.scrollEaseType = Easing.Elastic_easeOut;
	 * _regSimpleScroll.scrollBlurEffect = true;
	 * 
	 * _regSimpleScroll.bgEffectColor = 0xAD2C2C;
	 * _regSimpleScroll.bgCurve = 10; // max value is bg width
	 * _regSimpleScroll.bgColor = 0x333333;
	 * 
	 * _regSimpleScroll.sliderEffectType = EffectConst.COLOR_GLOW; // accepted values: EffectConst.COLOR, EffectConst.GLOW, EffectConst.COLOR_GLOW
	 * _regSimpleScroll.sliderEffectColor = 0xAD2C2C;
	 * _regSimpleScroll.sliderGlowBlur = 5;
	 * _regSimpleScroll.sliderGlowStrength = 1;
	 * _regSimpleScroll.sliderCurve = 10; // max value is slider width
	 * 
	 * _regSimpleScroll.btnEffectType = EffectConst.COLOR_GLOW; // accepted values: EffectConst.COLOR, EffectConst.GLOW, EffectConst.COLOR_GLOW
	 * _regSimpleScroll.btnEffectColor = 0xAD2C2C;
	 * _regSimpleScroll.btnGlowBlur = 5;
	 * _regSimpleScroll.btnGlowStrength = 1;
	 * _regSimpleScroll.btnColor = 0x333333;
	 * 
	 * 
	 * 
	 * // set inputs for the second scrollbar
	 * 
	 * _regSimpleScroll2.maskContent = _myContent2; // you just need to set its content
	 * 
	 * _regSimpleScroll2.importProp = _regSimpleScroll.exportProp; // now import other inputs from the first scrollbar
	 * 
	 * </listing>
	 */
	public class RegSimpleScroll extends ScrollBar
	{
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// properties
////////////////////////////////////////////////////////////////////////////////////
		// needed variables
		
			// contentMover function (ENTER_FRAME) variables
		private var _isVBtnOnly:Boolean;
		private var _isHBtnOnly:Boolean;
		private var _isVBtn1Down:Boolean = false;
		private var _isVBtn2Down:Boolean = false;
		private var _isHBtn1Down:Boolean = false;
		private var _isHBtn2Down:Boolean = false;
		private var _isBtnScrollXSet:Boolean = false;
		private var _isBtnScrollYSet:Boolean = false;
		
		private var _isFirstTimeXSet:Boolean = true;
		private var _isFirstTimeYSet:Boolean = true;
		private var _isSliderXSet:Boolean = false;
		private var _isSliderYSet:Boolean = false;
		private var _runSliderXAni:Boolean = false;
		private var _runSliderYAni:Boolean = false;
		private var _isOldSliderXSet:Boolean = false;
		private var _isOldSliderYSet:Boolean = false;
		private var _isVSliderStopped:Boolean;
		private var _isHSliderStopped:Boolean;
		private var _isSliderStopped:Boolean = true;
		
		private var _checkContentWH:Boolean = true;
		protected var _checkMaskWH:Boolean = true; // to check mask size or not, used in contentMover()
		private var _isMouseOver:Boolean;
		
		private var _oldMaskW:Number;
		private var _oldMaskH:Number;
		
		private var _vScrollTween:TweenMax;
		private var _hScrollTween:TweenMax;
		private var _scrollTween:TweenMax;
		private var _vSliderTween:TweenMax;
		private var _hSliderTween:TweenMax;
		private var _oldVSliderY:Number;
		private var _oldHSliderX:Number;
		private var _oldContentH:Number;
		private var _oldContentW:Number;
		
		
			// main variables
		private var _vScrollHolder:Sprite;
		private var _hScrollHolder:Sprite;
		
		private var _isDisabledVScroll:Boolean = false;
		private var _isDisabledHScroll:Boolean = false;
		
		private var _scrollRemoved:Boolean = false; // if we removed this class from stage, it has remove all of its functions (like ENTER_FRAME function) and elements
		
		private var _target:*;
		
		// input variables
		private var _orientation:String = Orientation.AUTO; // input values: AUTO, VERTICAL, HORIZONTAL
		private var _scrollSpace:Number = 5; // max value is RegSimpleConst.SCROLL_MAX_SPACE
		private var _drawDisabledScroll:Boolean = false;
		private var _scrollEaseType:String = Easing.Regular_easeOut;
		private var _scrollAniInterval:Number = 1;
		private var _scrollBlurEffect:Boolean = false;
		private var _scrollManualY:Number = 0; // min value is 0, max value is 100
		private var _scrollManualX:Number = 0; // min value is 0, max value is 100
		private var _mouseWheelSpeed:Number = 0;
		
			// bg
		private var _myVBg:RegSimpleRoundRect;
		private var _myHBg:RegSimpleRoundRect;
		
		private var _bgEffectType:String = EffectConst.COLOR; // input values: COLOR, GLOW, COLOR_GLOW;
		private var _bgEffectColor:uint = 0xFFFFFF;
		private var _bgEffectAlpha:Number = 1;
		private var _bgEffectAniInterval:Number = 1;
		private var _bgGlowBlur:Number = 3;
		private var _bgGlowStrength:Number = 1;
		
		private var _bgH:Number = maskHeight - ((_btnSize + _btnSpace)*2);
		private var _bgCurve:Number = 0; // max value is _bgW
		private var _bgW:Number = 10;	// max value is RegSimpleConst.BG_MAX_WIDTH
		private var _bgColor:uint = 0xCCCCCC;
		private var _bgAlpha:Number = .5;
		
			// slider
		private var _myVSlider:RegSimpleRoundRect;
		private var _myHSlider:RegSimpleRoundRect;
		private var _sliderVSpace:Number;
		private var _sliderHSpace:Number;
		
		private var _sliderEffectType:String = EffectConst.COLOR; // input values: COLOR, GLOW, COLOR_GLOW
		private var _sliderEffectColor:uint = 0xFFFFFF;
		private var _sliderEffectAlpha:Number = 1;
		private var _sliderEffectAniInterval:Number = 1;
		private var _sliderGlowBlur:Number = 3;
		private var _sliderGlowStrength:Number = 1;
		
		private var _sliderSpace:Number = 0; // max value is _bgW/2 or _bgH/2
		private var _sliderCurve:Number = 0; // max value is _sliderW
		private var _sliderW:Number = 10; // max value is RegSimpleConst.SLIDER_MAX_WIDTH
		private var _sliderH:Number = 0; // 0 means auto height, min value is RegSimpleConst.SLIDER_MIN_HEIGHT, max value is _bgH
		private var _sliderColor:uint = 0xCCCCCC;
		private var _sliderAlpha:Number = 1;
		private var _sliderAniInterval:Number = .5;
		
			// btn
		private var _myVTriangleBtn:RegSimpleTriangleBtn;
		private var _myVCircleBtn:RegSimpleCircleBtn;
		private var _myVTriangleBtn2:RegSimpleTriangleBtn;
		private var _myVCircleBtn2:RegSimpleCircleBtn;
		private var _myHTriangleBtn:RegSimpleTriangleBtn;
		private var _myHCircleBtn:RegSimpleCircleBtn;
		private var _myHTriangleBtn2:RegSimpleTriangleBtn;
		private var _myHCircleBtn2:RegSimpleCircleBtn;
		
		private var _btnEffectType:String = EffectConst.COLOR; // input values: COLOR, GLOW, COLOR_GLOW
		private var _btnEffectColor:uint = 0xFFFFFF;
		private var _btnEffectAlpha:Number = 1;
		private var _btnEffectAniInterval:Number = 1;
		private var _btnGlowBlur:Number = 3;
		private var _btnGlowStrength:Number = 1;
		
		private var _btnSpace:Number = 5; // max value is RegSimpleConst.BTN_MAX_SPACE
		private var _btnLayout:String = RegSimpleConst.TRIANGLE; // input values: TRIANGLE, CIRCLE
		private var _btnSize:Number = 10; // 0 means no buttons, max value is RegSimpleConst.BTN_MAX_SIZE, min value is RegSimpleConst.BTN_MIN_SIZE
		private var _btnColor:uint = 0x666666;
		private var _btnAlpha:Number = 1;
		private var _btnScrollSpeed:Number = 2;
		
		private var _easeType:Function = EaseLookup.find(_scrollEaseType);
		
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// constructor function
////////////////////////////////////////////////////////////////////////////////////
		/**
		 * Constructor function
		 */
		public function RegSimpleScroll():void
		{
			// I'm ready
		}
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////// methods
////////////////////////////////////////////////////////////////////////////////////

		//**********************************************************************************
		// ***************************************************************** MAIN METHODS
		//**********************************************************************************
		
		// here is the setMoreSettings function
		override protected function setMoreSettings():void
		{
			// let's set the settings
			gc();
			setMainSettings();
			setScrollHolder();
		}
		
		// here is the removeSettings function
		override protected function removeSettings():void
		{
			_scrollRemoved = true; // set it true to remove the ENTER_FRAME function (contentMover) in "gc" function
			
			// let's remove the settings
			gc();
		}
		
		// here is the setMainSettings function
		private function setMainSettings():void
		{
			// add scrollbar ENTER_FRAME listener
			this.addEventListener(Event.ENTER_FRAME, contentMover, false, 0, true);
			
			// add mouse wheel listeners to contentBg and maskContent
			contentBg.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel, false, 0, true);
			maskContent.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel, false, 0, true);
			
			// if we have applied blur effect to the content, content cacheAsBitmap must be true to work properly
			(_scrollBlurEffect) ? maskContent.cacheAsBitmap = true : maskContent.cacheAsBitmap = false;
			
			// set _oldContentH and _oldContentW
			_oldContentH = maskContent.height;
			_oldContentW = maskContent.width;
			
			// set _bgW if it passed the maximum value
			_bgW = Math.min(RegSimpleConst.BG_MAX_WIDTH, _bgW);
			
			// set _sliderW if it passed the maximum value
			_sliderW = Math.min(RegSimpleConst.SLIDER_MAX_WIDTH, _sliderW);
			
			// set _btnSize if it was less than the minimum value
			if(_btnSize != 0)
			{
				_btnSize = Math.max(RegSimpleConst.BTN_MIN_SIZE, _btnSize);
				
				// set _btnSize if it passed the maximum value
				if(_btnSize > maskHeight/2 - 1 && _btnSize <= maskWidth/2 - 1) // set _btnSize according to maskHeight
				{
					_btnSize = maskHeight/2 - 1;
				}
				else if(_btnSize > maskWidth/2 - 1 && _btnSize <= maskHeight/2 - 1) // set _btnSize according to maskWidth
				{
					_btnSize = maskWidth/2 - 1;
				}
				else if(_btnSize > maskWidth/2 - 1 && _btnSize > maskHeight/2 - 1) // set _btnSize according to maskWidth or maskHeight
				{
					if(maskHeight > maskWidth)
					{
						_btnSize = maskWidth/2 - 1;
					}
					else
					{
						_btnSize = maskHeight/2 - 1;
					}
				}
				else
				{
					_btnSize = Math.min(RegSimpleConst.BTN_MAX_SIZE, _btnSize);
				}
			}
			
			// set _btnSpace if it passed the maximum value
			_btnSpace = Math.min(RegSimpleConst.BTN_MAX_SPACE, _btnSpace);
			
			// set _scrollSpace if it passed the maximum value
			_scrollSpace = Math.min(RegSimpleConst.SCROLL_MAX_SPACE, _scrollSpace);
		}
		
		// here is the setScrollHolder function
		private function setScrollHolder():void
		{
			switch(_orientation)
			{
				case Orientation.AUTO: // if orientation is auto
				
					if(maskContent.width > maskWidth && maskContent.height <= maskHeight)
					{
						// let's make the _hScrollHolder
						_hScrollHolder = new Sprite();
						this.addChild(_hScrollHolder);
						_hScrollHolder.y = maskHeight + _scrollSpace;
						
						if(_drawDisabledScroll) // if we wanted to have the vertical scroll too, but it's disabled
						{
							// let's make the _vScrollHolder
							_vScrollHolder = new Sprite();
							this.addChild(_vScrollHolder);
							_vScrollHolder.x = maskWidth + _scrollSpace;
							
							_vScrollHolder.alpha = .5;
							
							_isDisabledVScroll = true; // to understand that we have disabled vertical scroll
							_isDisabledHScroll = false;
						}
						
						// set the settings
						checkScrollSettings();
					}
					else if(maskContent.width <= maskWidth && maskContent.height > maskHeight)
					{
						// let's make the _vScrollHolder
						_vScrollHolder = new Sprite();
						this.addChild(_vScrollHolder);
						_vScrollHolder.x = maskWidth + _scrollSpace;
						
						if(_drawDisabledScroll) // if we wanted to have the horizontal scroll too, but it's disabled
						{
							// let's make the _hScrollHolder
							_hScrollHolder = new Sprite();
							this.addChild(_hScrollHolder);
							_hScrollHolder.y = maskHeight + _scrollSpace;
							
							_hScrollHolder.alpha = .5;
							
							_isDisabledHScroll = true; // to understand that we have disabled horizontal scroll
							_isDisabledVScroll = false;
						}
						
						// set the settings
						checkScrollSettings();
					}
					else if(maskContent.width > maskWidth && maskContent.height > maskHeight)
					{
						// let's make the _vScrollHolder
						_vScrollHolder = new Sprite();
						this.addChild(_vScrollHolder);
						_vScrollHolder.x = maskWidth + _scrollSpace;
						
						// let's make the _hScrollHolder
						_hScrollHolder = new Sprite();
						this.addChild(_hScrollHolder);
						_hScrollHolder.y = maskHeight + _scrollSpace;
						
						// to understand that we don't have disabled scrolls
						_isDisabledHScroll = false;
						_isDisabledVScroll = false;
						
						// set the settings
						checkScrollSettings();
					}
					else
					{
						if(_drawDisabledScroll) // if we wanted to have the scrollbar
						{
							// let's make the _vScrollHolder
							_vScrollHolder = new Sprite();
							this.addChild(_vScrollHolder);
							_vScrollHolder.x = maskWidth + _scrollSpace;
							
							// let's make the _hScrollHolder
							_hScrollHolder = new Sprite();
							this.addChild(_hScrollHolder);
							_hScrollHolder.y = maskHeight + _scrollSpace;
							
							_vScrollHolder.alpha = .5;
							_hScrollHolder.alpha = .5;
							
							// to understand that we have disabled scrolls
							_isDisabledHScroll = true;
							_isDisabledVScroll = true;
							
							// set the settings
							checkScrollSettings();
						}
					}
				break;
					
				case Orientation.VERTICAL: // if orientation is vertical
					
					if(maskContent.height > maskHeight)
					{
						// let's make the _vScrollHolder
						_vScrollHolder = new Sprite();
						this.addChild(_vScrollHolder);
						_vScrollHolder.x = maskWidth + _scrollSpace;
						
						if(_drawDisabledScroll)
						{
							// to understand that we don't have disabled scrolls
							_isDisabledVScroll = false;
						}
						
						// set the settings
						checkScrollSettings();
					}
					else
					{
						if(_drawDisabledScroll)
						{
							// let's make the _vScrollHolder
							_vScrollHolder = new Sprite();
							this.addChild(_vScrollHolder);
							_vScrollHolder.x = maskWidth + _scrollSpace;
							
							_vScrollHolder.alpha = .5;
							_isDisabledVScroll = true; // to understand that we have disabled vertical scroll
							
							// set the settings
							checkScrollSettings();
						}
					}
				break;
				
				case Orientation.HORIZONTAL: // if orientation is horizontal
					
					if(maskContent.width > maskWidth)
					{
						// let's make the _hScrollHolder
						_hScrollHolder = new Sprite();
						this.addChild(_hScrollHolder);
						_hScrollHolder.y = maskHeight + _scrollSpace;
						
						if(_drawDisabledScroll)
						{
							_isDisabledHScroll = false;
						}
						
						// set the settings
						checkScrollSettings();
					}
					else
					{
						if(_drawDisabledScroll)
						{
							// let's make the _hScrollHolders
							_hScrollHolder = new Sprite();
							this.addChild(_hScrollHolder);
							_hScrollHolder.y = maskHeight + _scrollSpace;
							
							_hScrollHolder.alpha = .5;
							_isDisabledHScroll = true; // to understand that we have disabled horizontal scroll
							
							// set the settings
							checkScrollSettings();
						}
					}
				break;
			}
		}
		
		// here is the gc function
		private function gc():void
		{
			// remove the listeners
			if(_scrollRemoved)
			{
				// remove scrollbar ENTER_FRAME listener
				this.removeEventListener(Event.ENTER_FRAME, contentMover);
				
				// remove other listeners
				stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
				stage.removeEventListener(MouseEvent.MOUSE_UP, stopMoving);
			}
			
			// remove the old vertical bg
			if(_myVBg != null) // if this is not the first time we have drawn vertical bg
			{
				_myVBg.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVBg.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myVBg.removeEventListener(MouseEvent.CLICK, moveSlider);
				_myVBg.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				
				_myVBg.clearShape();
				_myVBg.removeListeners();
				_vScrollHolder.removeChild(_myVBg);
				_myVBg = null;
			}
			
			// remove the old horizontal bg
			if(_myHBg != null) // if this is not the first time we have drawn horizontal bg
			{
				_myHBg.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHBg.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myHBg.removeEventListener(MouseEvent.CLICK, moveSlider);
				_myHBg.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				
				_myHBg.clearShape();
				_myHBg.removeListeners();
				_hScrollHolder.removeChild(_myHBg);
				_myHBg = null;
			}
			
			// remove the old vertical slider
			if(_myVSlider != null) // if this is not the first time we have drawn vertical slider
			{
				_myVSlider.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVSlider.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myVSlider.removeEventListener(MouseEvent.MOUSE_DOWN, dragSlider);
				_myVSlider.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				
				_myVSlider.clearShape();
				_myVSlider.removeListeners();
				_vScrollHolder.removeChild(_myVSlider);
				_myVSlider = null;
			}
			
			// remove the old horizontal slider
			if(_myHSlider != null) // if this is not the first time we have drawn horizontal slider
			{
				_myHSlider.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHSlider.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myHSlider.removeEventListener(MouseEvent.MOUSE_DOWN, dragSlider);
				_myHSlider.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				
				_myHSlider.clearShape();
				_myHSlider.removeListeners();
				_hScrollHolder.removeChild(_myHSlider);
				_myHSlider = null;
			}
			
			// remove the old vertical btns
			if(_myVCircleBtn != null) // if this is not the first time we have drawn vertical circle
			{
				_myVCircleBtn.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVCircleBtn2.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVCircleBtn.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				_myVCircleBtn2.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myVCircleBtn.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				_myVCircleBtn2.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				
				_myVCircleBtn.clearShape();
				_myVCircleBtn.removeListeners();
				_vScrollHolder.removeChild(_myVCircleBtn);
				_myVCircleBtn = null;
				
				_myVCircleBtn2.clearShape();
				_myVCircleBtn2.removeListeners();
				_vScrollHolder.removeChild(_myVCircleBtn2);
				_myVCircleBtn2 = null;
			}
			if(_myVTriangleBtn != null) // if this is not the first time we have drawn vertical triangle
			{
				_myVTriangleBtn.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVTriangleBtn2.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVTriangleBtn.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				_myVTriangleBtn2.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myVTriangleBtn.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				_myVTriangleBtn2.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				
				_myVTriangleBtn.clearShape();
				_myVTriangleBtn.removeListeners();
				_vScrollHolder.removeChild(_myVTriangleBtn);
				_myVTriangleBtn = null;
				
				_myVTriangleBtn2.clearShape();
				_myVTriangleBtn2.removeListeners();
				_vScrollHolder.removeChild(_myVTriangleBtn2);
				_myVTriangleBtn2 = null;
			}
			
			// remove the old horizontal btns
			if(_myHCircleBtn != null) // if this is not the first time we have drawn horizontal circle
			{
				_myHCircleBtn.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHCircleBtn2.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHCircleBtn.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				_myHCircleBtn2.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myHCircleBtn.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				_myHCircleBtn2.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				
				_myHCircleBtn.clearShape();
				_myHCircleBtn.removeListeners();
				_hScrollHolder.removeChild(_myHCircleBtn);
				_myHCircleBtn = null;
				
				_myHCircleBtn2.clearShape();
				_myHCircleBtn2.removeListeners();
				_hScrollHolder.removeChild(_myHCircleBtn2);
				_myHCircleBtn2 = null;
			}
			if(_myHTriangleBtn != null) // if this is not the first time we have drawn horizontal triangle
			{
				_myHTriangleBtn.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHTriangleBtn2.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHTriangleBtn.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				_myHTriangleBtn2.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myHTriangleBtn.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				_myHTriangleBtn2.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				
				_myHTriangleBtn.clearShape();
				_myHTriangleBtn.removeListeners();
				_hScrollHolder.removeChild(_myHTriangleBtn);
				_myHTriangleBtn = null;
				
				_myHTriangleBtn2.clearShape();
				_myHTriangleBtn2.removeListeners();
				_hScrollHolder.removeChild(_myHTriangleBtn2);
				_myHTriangleBtn2 = null;
			}
			
			// remove the old _vScrollHolder
			if(_vScrollHolder != null) // if this is not the first time we have made the _vScrollHolder
			{
				this.removeChild(_vScrollHolder);
				_vScrollHolder = null;
				
			}
			
			// remove the old _hScrollHolder
			if(_hScrollHolder != null) // if this is not the first time we have made the _hScrollHolder
			{
				this.removeChild(_hScrollHolder);
				_hScrollHolder = null;
			}
		}
		
		// here is the checkScrollSettings function
		private function checkScrollSettings():void
		{
			if(_btnSize != 0)
			{
				// if we need vertical btn and horizontal scrollbar
				if(_btnSize*2 + _btnSpace + RegSimpleConst.BTN_ONLY_NUM > maskHeight && _btnSize*2 + _btnSpace + RegSimpleConst.BTN_ONLY_NUM <= maskWidth)
				{
					_isVBtnOnly = true;
					_isHBtnOnly = false;
					setBg();
					setSlider();
					setBtn();
				}
				// if we need horizontal btn and vertical scrollbar
				else if(_btnSize*2 + _btnSpace + RegSimpleConst.BTN_ONLY_NUM > maskWidth && _btnSize*2 + _btnSpace + RegSimpleConst.BTN_ONLY_NUM <= maskHeight)
				{
					_isHBtnOnly = true;
					_isVBtnOnly = false;
					setBg();
					setSlider();
					setBtn();
				}
				// if we need horizontal btn and vertical btn
				else if(_btnSize*2 + _btnSpace + RegSimpleConst.BTN_ONLY_NUM > maskWidth && _btnSize*2 + _btnSpace + RegSimpleConst.BTN_ONLY_NUM > maskHeight)
				{
					_isHBtnOnly = true;
					_isVBtnOnly = true;
					setBg();
					setSlider();
					setBtn();
				}
				// if we need horizontal scrollbar and vertical scrollbar
				else
				{
					_isVBtnOnly = false;
					_isHBtnOnly = false;
					setBg();
					setSlider();
					setBtn();
				}
			}
			else
			{
				_isVBtnOnly = false;
				_isHBtnOnly = false;
				setBg();
				setSlider();
			}
		}
		
		//**********************************************************************************
		// ***************************************************************** ELEMENTS METHODS
		//**********************************************************************************
		
		// here is the setBg function and its related functions
		private function setBg():void
		{
			// remove the old vertical bg
			if(_myVBg != null) // if this is not the first time we have drawn vertical bg
			{
				_myVBg.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVBg.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myVBg.removeEventListener(MouseEvent.CLICK, moveSlider);
				_myVBg.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				
				_myVBg.clearShape();
				_myVBg.removeListeners();
				_vScrollHolder.removeChild(_myVBg);
				_myVBg = null;
			}
			
			// remove the old horizontal bg
			if(_myHBg != null) // if this is not the first time we have drawn horizontal bg
			{
				_myHBg.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHBg.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myHBg.removeEventListener(MouseEvent.CLICK, moveSlider);
				_myHBg.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				
				_myHBg.clearShape();
				_myHBg.removeListeners();
				_hScrollHolder.removeChild(_myHBg);
				_myHBg = null;
			}
			
			// draw vertical bg
			if(_vScrollHolder != null)
			{
				if(!_isVBtnOnly)
				{
					// let's draw the bg
					_myVBg = new RegSimpleRoundRect();
					_myVBg.curve = _bgCurve;
					_myVBg.w = _bgW;
					(_btnSize == 0) ? _myVBg.h = maskHeight : _myVBg.h = maskHeight - ((_btnSize + _btnSpace)*2);
					_myVBg.color = _bgColor;
					_myVBg.a = _bgAlpha;
					_myVBg.draw();
					_vScrollHolder.addChildAt(_myVBg, 0);
					// set the scrollbar x position in different situations
					if(_sliderW > _myVBg.width && _btnSize <= _myVBg.width)
					{
						_myVBg.x = (_sliderW/2) - (_bgW/2);
					}
					else if(_btnSize > _myVBg.width && _sliderW <= _myVBg.width)
					{
						_myVBg.x = (_btnSize/2) - (_bgW/2);
					}
					else if(_sliderW > _myVBg.width && _btnSize > _myVBg.width)
					{
						(_sliderW > _btnSize) ? _myVBg.x = (_sliderW/2) - (_bgW/2) : _myVBg.x = (_btnSize/2) - (_bgW/2);
					}
					else
					{
						_myVBg.x = 0;
					}
					// set the scrollbar y position in different situations
					(_btnSize == 0) ? _myVBg.y = 0 : _myVBg.y = _btnSize + _btnSpace;
					
					// set effects values
					_myVBg.effectType = _bgEffectType;
					_myVBg.effectColor = _bgEffectColor;
					_myVBg.effectAlpha = _bgEffectAlpha;
					_myVBg.effectAniInterval = _bgEffectAniInterval;
					if(_bgEffectType == EffectConst.GLOW || _bgEffectType == EffectConst.COLOR_GLOW)
					{
						_myVBg.glowBlur = _bgGlowBlur;
						_myVBg.glowStrength = _bgGlowStrength;
					}
					
					// let's add its listener
					if(!_isDisabledVScroll)
					{
						_myVBg.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
						_myVBg.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
						
						_myVBg.addEventListener(MouseEvent.CLICK, moveSlider, false, 0, true);
						_myVBg.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel, false, 0, true);
					}
					else
					{
						_myVBg.removeListeners();
					}
				}
			}
			
			// draw horizontal bg
			if(_hScrollHolder != null)
			{
				if(!_isHBtnOnly)
				{
					// let's draw the bg
					_myHBg = new RegSimpleRoundRect();
					_myHBg.curve = _bgCurve;
					(_btnSize == 0) ? _myHBg.w = maskWidth : _myHBg.w = maskWidth - ((_btnSize + _btnSpace)*2);
					_myHBg.h = _bgW;
					_myHBg.color = _bgColor;
					_myHBg.a = _bgAlpha;
					_myHBg.draw();
					_hScrollHolder.addChildAt(_myHBg, 0);
					// set the scrollbar y position in different situations
					if(_sliderW > _myHBg.height && _btnSize <= _myHBg.height)
					{
						_myHBg.y = (_sliderW/2) - (_bgW/2);
					}
					else if(_btnSize > _myHBg.height && _sliderW <= _myHBg.height)
					{
						_myHBg.y = (_btnSize/2) - (_bgW/2);
					}
					else if(_sliderW > _myHBg.height && _btnSize > _myHBg.height)
					{
						(_sliderW > _btnSize) ? _myHBg.y = (_sliderW/2) - (_bgW/2) : _myHBg.y = (_btnSize/2) - (_bgW/2);
					}
					else
					{
						_myHBg.y = 0;
					}
					// set the scrollbar x position in different situations
					(_btnSize == 0) ? _myHBg.x = 0 : _myHBg.x = _btnSize + _btnSpace;
					
					// set effects values
					_myHBg.effectType = _bgEffectType;
					_myHBg.effectColor = _bgEffectColor;
					_myHBg.effectAlpha = _bgEffectAlpha;
					_myHBg.effectAniInterval = _bgEffectAniInterval;
					if(_bgEffectType == EffectConst.GLOW || _bgEffectType == EffectConst.COLOR_GLOW)
					{
						_myHBg.glowBlur = _bgGlowBlur;
						_myHBg.glowStrength = _bgGlowStrength;
					}
					
					// let's add its listener
					if(!_isDisabledHScroll)
					{
						_myHBg.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
						_myHBg.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
						
						_myHBg.addEventListener(MouseEvent.CLICK, moveSlider, false, 0, true);
						_myHBg.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel, false, 0, true);
					}
					else
					{
						_myHBg.removeListeners();
					}
				}
			}
		}
		// moveSlider function
		private function moveSlider(e:MouseEvent):void
		{
			// set slider movement variables
			var __setSliderY:Number;
			var __sliderAvailableH:Number;
			var __vSliderY:Number;
			var __oldVSliderY:Number;
			
			var __setSliderX:Number;
			var __sliderAvailableW:Number;
			var __hSliderX:Number;
			var __oldHSliderX:Number;
			
			if(_myVSlider != null && _myHSlider == null) // if we have _vScrollHolder
			{
				// let's move slider
				if(e.currentTarget == _myVBg)
				{
					// set percentage according to mouse y position
					_scrollManualY = Math.round( (_myVBg.mouseY / _myVBg.height)*100 );
					
					// set slider y according to percentage
					__sliderAvailableH = (_myVBg.height - _myVSlider.height) - (_sliderVSpace*2);
					__setSliderY = (_scrollManualY/100)*__sliderAvailableH;
					
					__oldVSliderY = _myVSlider.y;
					
					__vSliderY = (_myVBg.y + Math.min(_sliderVSpace, _myVBg.height/2)) + __setSliderY;
					
					_vSliderTween = TweenMax.to(_myVSlider, _sliderAniInterval, {bezier:[{y:__oldVSliderY}, {y:__vSliderY}]});
				}
			}
			else if(_myHSlider != null && _myVSlider == null) // if we have _hScrollHolder
			{
				// let's move slider
				if(e.currentTarget == _myHBg)
				{
					// set percentage according to mouse x position
					_scrollManualX = Math.round( (_myHBg.mouseX / _myHBg.width)*100 );
					
					// set slider x according to percentage
					__sliderAvailableW = (_myHBg.width - _myHSlider.width) - (_sliderHSpace*2);
					__setSliderX = (_scrollManualX/100)*__sliderAvailableW;
					
					__oldHSliderX = _myHSlider.x;
					
					__hSliderX = (_myHBg.x + Math.min(_sliderHSpace, _myHBg.width/2)) + __setSliderX;
					
					_hSliderTween = TweenMax.to(_myHSlider, _sliderAniInterval, {bezier:[{x:__oldHSliderX}, {x:__hSliderX}]});
				}
			}
			else if(_myHSlider != null && _myVSlider != null) // if we have _hScrollHolder and _vScrollHolder
			{
				// let's move slider
				if(e.currentTarget == _myVBg)
				{
					// set percentage according to mouse y position
					_scrollManualY = Math.round( (_myVBg.mouseY / _myVBg.height)*100 );
					
					// set slider y according to percentage
					__sliderAvailableH = (_myVBg.height - _myVSlider.height) - (_sliderVSpace*2);
					__setSliderY = (_scrollManualY/100)*__sliderAvailableH;
					
					__oldVSliderY = _myVSlider.y;
					
					__vSliderY = (_myVBg.y + Math.min(_sliderVSpace, _myVBg.height/2)) + __setSliderY;
					
					_vSliderTween = TweenMax.to(_myVSlider, _sliderAniInterval, {bezier:[{y:__oldVSliderY}, {y:__vSliderY}]});
				}
				else if (e.currentTarget == _myHBg)
				{
					// set percentage according to mouse x position
					_scrollManualX = Math.round( (_myHBg.mouseX / _myHBg.width)*100 );
					
					// set slider x according to percentage
					__sliderAvailableW = (_myHBg.width - _myHSlider.width) - (_sliderHSpace*2);
					__setSliderX = (_scrollManualX/100)*__sliderAvailableW;
					
					__oldHSliderX = _myHSlider.x;
					
					__hSliderX = (_myHBg.x + Math.min(_sliderHSpace, _myHBg.width/2)) + __setSliderX;
					
					_hSliderTween = TweenMax.to(_myHSlider, _sliderAniInterval, {bezier:[{x:__oldHSliderX}, {x:__hSliderX}]});
				}
			}
		}
		
		// here is the setSlider function and its related functions
		private function setSlider():void
		{
			// remove the old vertical slider
			if(_myVSlider != null) // if this is not the first time we have drawn vertical slider
			{
				_myVSlider.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVSlider.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myVSlider.removeEventListener(MouseEvent.MOUSE_DOWN, dragSlider);
				_myVSlider.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				
				_myVSlider.clearShape();
				_myVSlider.removeListeners();
				_vScrollHolder.removeChild(_myVSlider);
				_myVSlider = null;
			}
			
			// remove the old horizontal slider
			if(_myHSlider != null) // if this is not the first time we have drawn horizontal slider
			{
				_myHSlider.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHSlider.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myHSlider.removeEventListener(MouseEvent.MOUSE_DOWN, dragSlider);
				_myHSlider.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				
				_myHSlider.clearShape();
				_myHSlider.removeListeners();
				_hScrollHolder.removeChild(_myHSlider);
				_myHSlider = null;
			}
			
			// draw vertical slider
			if(_vScrollHolder != null && !_isDisabledVScroll)
			{
				if(!_isVBtnOnly)
				{
					// set _sliderVSpace according to _myVBg width or RegSimpleConst.BTN_ONLY_NUM
					_sliderVSpace = Math.min(_sliderSpace, _myVBg.width/2);
					(RegSimpleConst.BTN_ONLY_NUM + _sliderVSpace >  _myVBg.height) ? _sliderVSpace = 0 : _sliderVSpace;
					
					// let's draw the slider
					_myVSlider = new RegSimpleRoundRect();
					_myVSlider.curve = _sliderCurve;
					if(_sliderH == 0)
					{
						// set _myVSlider height according to the maskContent height
						_myVSlider.h = Math.max(RegSimpleConst.SLIDER_MIN_HEIGHT, (maskHeight*_myVBg.height)/maskContent.height - _sliderVSpace*2);
					}
					else if(_sliderH + (_sliderVSpace*2) > _myVBg.height || _sliderH < RegSimpleConst.SLIDER_MIN_HEIGHT)
					{
						_myVSlider.h = RegSimpleConst.SLIDER_MIN_HEIGHT;
					}
					else
					{
						_myVSlider.h = _sliderH;
					}
					_myVSlider.w = _sliderW;
					_myVSlider.color = _sliderColor;
					_myVSlider.a = _sliderAlpha;
					_myVSlider.draw();
					_vScrollHolder.addChildAt(_myVSlider, 1);
					_myVSlider.x = (_myVBg.width/2 - _myVSlider.width/2) + _myVBg.x;
					_myVSlider.y = _myVBg.y + Math.min(_sliderVSpace, _myVBg.height/2);
					
					if(!_isOldSliderYSet){_oldVSliderY = _myVSlider.y};
					
					// set effects values
					_myVSlider.effectType = _sliderEffectType;
					_myVSlider.effectColor = _sliderEffectColor;
					_myVSlider.effectAlpha = _sliderEffectAlpha;
					_myVSlider.effectAniInterval = _sliderEffectAniInterval;
					if(_sliderEffectType == EffectConst.GLOW || _sliderEffectType == EffectConst.COLOR_GLOW)
					{
						_myVSlider.glowBlur = _sliderGlowBlur;
						_myVSlider.glowStrength = _sliderGlowStrength;
					}
					
					// let's add its listeners
					_myVSlider.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
					_myVSlider.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
					
					_myVSlider.addEventListener(MouseEvent.MOUSE_DOWN, dragSlider, false, 0, true);
					_myVSlider.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel, false, 0, true);
				}
			}
			
			// draw horizontal slider
			if(_hScrollHolder != null && !_isDisabledHScroll)
			{
				if(!_isHBtnOnly)
				{
					// set _sliderHSpace according to _myHBg height or RegSimpleConst.BTN_ONLY_NUM
					_sliderHSpace = Math.min(_sliderSpace, _myHBg.height/2);
					(RegSimpleConst.BTN_ONLY_NUM + _sliderHSpace >  _myHBg.width) ? _sliderHSpace = 0 : _sliderHSpace;
					
					// let's draw the slider
					_myHSlider = new RegSimpleRoundRect();
					_myHSlider.curve = _sliderCurve;
					if(_sliderH == 0)
					{
						// set _myHSlider width according to the maskContent width
						 _myHSlider.w = Math.max(RegSimpleConst.SLIDER_MIN_HEIGHT, (maskWidth*_myHBg.width)/maskContent.width - _sliderHSpace*2);
					}
					else if(_sliderH + (_sliderVSpace*2) > _myHBg.width || _sliderH < RegSimpleConst.SLIDER_MIN_HEIGHT)
					{
						_myHSlider.w = RegSimpleConst.SLIDER_MIN_HEIGHT;
					}
					else
					{
						_myHSlider.w = _sliderH;
					}
					_myHSlider.h = _sliderW;
					_myHSlider.color = _sliderColor;
					_myHSlider.a = _sliderAlpha;
					_myHSlider.draw();
					_hScrollHolder.addChildAt(_myHSlider, 1);
					_myHSlider.y = (_myHBg.height/2 - _myHSlider.height/2) + _myHBg.y;
					_myHSlider.x = _myHBg.x + Math.min(_sliderHSpace, _myHBg.width/2);
					
					if(!_isOldSliderXSet){_oldHSliderX = _myHSlider.x};
					
					// set effects values
					_myHSlider.effectType = _sliderEffectType;
					_myHSlider.effectColor = _sliderEffectColor;
					_myHSlider.effectAlpha = _sliderEffectAlpha;
					_myHSlider.effectAniInterval = _sliderEffectAniInterval;
					if(_sliderEffectType == EffectConst.GLOW || _sliderEffectType == EffectConst.COLOR_GLOW)
					{
						_myHSlider.glowBlur = _sliderGlowBlur;
						_myHSlider.glowStrength = _sliderGlowStrength;
					}
					
					// let's add its listener
					_myHSlider.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
					_myHSlider.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
					
					_myHSlider.addEventListener(MouseEvent.MOUSE_DOWN, dragSlider, false, 0, true);
					_myHSlider.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel, false, 0, true);
				}
			}
		}
		// dragSlider function
		private function dragSlider(e:MouseEvent):void
		{
			// remove the slider tween if we have clicked on the bg and slider is animating
			//_vSliderTween = TweenMax.removeTween(_vSliderTween);
			_vSliderTween = null;
			
			//_hSliderTween = TweenMax.removeTween(_hSliderTween);
			_hSliderTween = null;
			
			// set drag variables
			var __vDragX:Number;
			var __vDragY:Number;
			var __vDragW:Number;
			var __vDragH:Number;
			
			var __hDragX:Number;
			var __hDragY:Number;
			var __hDragW:Number;
			var __hDragH:Number;
			
			if(_myVSlider != null && _myHSlider == null) // if we have _vScrollHolder
			{
				// set drag values
				__vDragX = _myVBg.x + ( (_myVBg.width/2) - (_myVSlider.width/2) );
				__vDragY = _myVBg.y + _sliderVSpace;
				__vDragW = 0;
				__vDragH = (_btnSize == 0) ? maskHeight - _myVSlider.height - (_sliderVSpace*2) : maskHeight - ((_btnSize + _btnSpace)*2) - _myVSlider.height - (_sliderVSpace*2);
			
				// let's drag
				if(e.currentTarget == _myVSlider)
				{
					_myVSlider.startDrag(false, new Rectangle(__vDragX,__vDragY,__vDragW,__vDragH));
				}
			}
			else if(_myHSlider != null && _myVSlider == null) // if we have _hScrollHolder
			{
				// set drag values
				__hDragX = _myHBg.x + _sliderHSpace;
				__hDragY = _myHBg.y + ( (_myHBg.height/2) - (_myHSlider.height/2) );
				__hDragW = (_btnSize == 0) ? maskWidth - _myHSlider.width - (_sliderHSpace*2) : maskWidth - ((_btnSize + _btnSpace)*2) - _myHSlider.width - (_sliderHSpace*2);
				__hDragH = 0;
				
				// let's drag
				if(e.currentTarget == _myHSlider)
				{
					_myHSlider.startDrag(false, new Rectangle(__hDragX,__hDragY,__hDragW,__hDragH));
				}
			}
			else if(_myHSlider != null && _myVSlider != null) // if we have _hScrollHolder and _vScrollHolder
			{
				// set drag values
				__vDragX = _myVBg.x + ( (_myVBg.width/2) - (_myVSlider.width/2) );
				__vDragY = _myVBg.y + _sliderVSpace;
				__vDragW = 0;
				__vDragH = (_btnSize == 0) ? maskHeight - _myVSlider.height - (_sliderVSpace*2) : maskHeight - ((_btnSize + _btnSpace)*2) - _myVSlider.height - (_sliderVSpace*2);
				
				__hDragX = _myHBg.x + _sliderHSpace;
				__hDragY = _myHBg.y + ( (_myHBg.height/2) - (_myHSlider.height/2) );
				__hDragW = (_btnSize == 0) ? maskWidth - _myHSlider.width - (_sliderHSpace*2) : maskWidth - ((_btnSize + _btnSpace)*2) - _myHSlider.width - (_sliderHSpace*2);
				__hDragH = 0;
				
				// let's drag
				if(e.currentTarget == _myVSlider)
				{
					_myVSlider.startDrag(false, new Rectangle(__vDragX,__vDragY,__vDragW,__vDragH));
				}
				else if (e.currentTarget == _myHSlider)
				{
					_myHSlider.startDrag(false, new Rectangle(__hDragX,__hDragY,__hDragW,__hDragH));
				}
			}
			
			// add its listener
			stage.addEventListener(MouseEvent.MOUSE_UP, stopDragging, false, 0, true);
		}
		// stopDragging function
		private function stopDragging(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
			
			if(_myVSlider != null){_myVSlider.stopDrag()};
			if(_myHSlider != null){_myHSlider.stopDrag()};
		}
		// mouseWheel function
		private function mouseWheel(e:MouseEvent):void
		{
			// set mouseWheel variables
			var __delta:Number;
			
			var __vSliderMin:Number;
			var __vSliderMax:Number;
			
			var __hSliderMin:Number;
			var __hSliderMax:Number;
			
			if(_myVSlider != null && _myHSlider == null) // if we have _vScrollHolder
			{
				// set min and max space that slider can move within
				__vSliderMin = _myVBg.y + _sliderVSpace;
				__vSliderMax = (_btnSize != 0) ? maskHeight - (_btnSize + _btnSpace) - _myVSlider.height - _sliderVSpace : maskHeight - _myVSlider.height - _sliderVSpace;
				
				// set delta amount
				__delta = (e.delta < 0) ? e.delta - _mouseWheelSpeed : e.delta + _mouseWheelSpeed;
				
				if (e.currentTarget == _myVBg || e.currentTarget == _myVSlider || e.currentTarget == maskContent || e.currentTarget == contentBg)
				{
					_myVSlider.y -= __delta;
					
					(_myVSlider.y < __vSliderMin) ? _myVSlider.y = __vSliderMin : _myVSlider.y;
					(_myVSlider.y > __vSliderMax) ? _myVSlider.y = __vSliderMax : _myVSlider.y;
				}
			}
			else if(_myHSlider != null && _myVSlider == null) // if we have _hScrollHolder
			{
				// set min and max space that slider can move within
				__hSliderMin = _myHBg.x + _sliderHSpace;
				__hSliderMax = (_btnSize != 0) ? maskWidth - (_btnSize + _btnSpace) - _myHSlider.width - _sliderHSpace : maskWidth - _myHSlider.width - _sliderHSpace;
				
				// set delta amount
				__delta = (e.delta < 0) ? e.delta - _mouseWheelSpeed : e.delta + _mouseWheelSpeed;
				
				if (e.currentTarget == _myHBg || e.currentTarget == _myHSlider || e.currentTarget == maskContent || e.currentTarget == contentBg)
				{
					_myHSlider.x -= __delta;
					
					(_myHSlider.x < __hSliderMin) ? _myHSlider.x = __hSliderMin : _myHSlider.x;
					(_myHSlider.x > __hSliderMax) ? _myHSlider.x = __hSliderMax : _myHSlider.x;
				}
			}
			else if(_myHSlider != null && _myVSlider != null) // if we have _hScrollHolder and _vScrollHolder
			{
				// set min and max space that slider can move within
				__vSliderMin = _myVBg.y + _sliderVSpace;
				__vSliderMax = (_btnSize != 0) ? maskHeight - (_btnSize + _btnSpace) - _myVSlider.height - _sliderVSpace : maskHeight - _myVSlider.height - _sliderVSpace;
				
				// set delta amount
				__delta = (e.delta < 0) ? e.delta - _mouseWheelSpeed : e.delta + _mouseWheelSpeed;
				
				if (e.currentTarget == _myVBg || e.currentTarget == _myVSlider || e.currentTarget == maskContent || e.currentTarget == contentBg)
				{
					_myVSlider.y -= __delta;
					
					(_myVSlider.y < __vSliderMin) ? _myVSlider.y = __vSliderMin : _myVSlider.y;
					(_myVSlider.y > __vSliderMax) ? _myVSlider.y = __vSliderMax : _myVSlider.y;
				}
				
				
				// set min and max space that slider can move within
				__hSliderMin = _myHBg.x + _sliderHSpace;
				__hSliderMax = (_btnSize != 0) ? maskWidth - (_btnSize + _btnSpace) - _myHSlider.width - _sliderHSpace : maskWidth - _myHSlider.width - _sliderHSpace;
				
				// set delta amount
				__delta = (e.delta < 0) ? e.delta - _mouseWheelSpeed : e.delta + _mouseWheelSpeed;
				
				if (e.currentTarget == _myHBg || e.currentTarget == _myHSlider)
				{
					_myHSlider.x -= __delta;
					
					(_myHSlider.x < __hSliderMin) ? _myHSlider.x = __hSliderMin : _myHSlider.x;
					(_myHSlider.x > __hSliderMax) ? _myHSlider.x = __hSliderMax : _myHSlider.x;
				}
			}
		}
		
		// here is the setBtn function and its related functions
		private function setBtn():void
		{
			// remove the old vertical btns
			if(_myVCircleBtn != null) // if this is not the first time we have drawn vertical circle
			{
				_myVCircleBtn.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVCircleBtn2.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVCircleBtn.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				_myVCircleBtn2.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myVCircleBtn.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				_myVCircleBtn2.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				
				_myVCircleBtn.clearShape();
				_myVCircleBtn.removeListeners();
				_vScrollHolder.removeChild(_myVCircleBtn);
				_myVCircleBtn = null;
				
				_myVCircleBtn2.clearShape();
				_myVCircleBtn2.removeListeners();
				_vScrollHolder.removeChild(_myVCircleBtn2);
				_myVCircleBtn2 = null;
			}
			if(_myVTriangleBtn != null) // if this is not the first time we have drawn vertical triangle
			{
				_myVTriangleBtn.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVTriangleBtn2.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myVTriangleBtn.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				_myVTriangleBtn2.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myVTriangleBtn.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				_myVTriangleBtn2.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				
				_myVTriangleBtn.clearShape();
				_myVTriangleBtn.removeListeners();
				_vScrollHolder.removeChild(_myVTriangleBtn);
				_myVTriangleBtn = null;
				
				_myVTriangleBtn2.clearShape();
				_myVTriangleBtn2.removeListeners();
				_vScrollHolder.removeChild(_myVTriangleBtn2);
				_myVTriangleBtn2 = null;
			}
			
			// remove the old horizontal btns
			if(_myHCircleBtn != null) // if this is not the first time we have drawn horizontal circle
			{
				_myHCircleBtn.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHCircleBtn2.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHCircleBtn.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				_myHCircleBtn2.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myHCircleBtn.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				_myHCircleBtn2.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				
				_myHCircleBtn.clearShape();
				_myHCircleBtn.removeListeners();
				_hScrollHolder.removeChild(_myHCircleBtn);
				_myHCircleBtn = null;
				
				_myHCircleBtn2.clearShape();
				_myHCircleBtn2.removeListeners();
				_hScrollHolder.removeChild(_myHCircleBtn2);
				_myHCircleBtn2 = null;
			}
			if(_myHTriangleBtn != null) // if this is not the first time we have drawn horizontal triangle
			{
				_myHTriangleBtn.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHTriangleBtn2.removeEventListener(MouseEvent.ROLL_OVER, objOver);
				_myHTriangleBtn.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				_myHTriangleBtn2.removeEventListener(MouseEvent.ROLL_OUT, objOut);
				
				_myHTriangleBtn.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				_myHTriangleBtn2.removeEventListener(MouseEvent.MOUSE_DOWN, moveContent);
				
				_myHTriangleBtn.clearShape();
				_myHTriangleBtn.removeListeners();
				_hScrollHolder.removeChild(_myHTriangleBtn);
				_myHTriangleBtn = null;
				
				_myHTriangleBtn2.clearShape();
				_myHTriangleBtn2.removeListeners();
				_hScrollHolder.removeChild(_myHTriangleBtn2);
				_myHTriangleBtn2 = null;
			}
			
			// draw vertical btns
			if(_vScrollHolder != null)
			{
				// let's draw the buttons
				switch(_btnLayout)
				{
					case RegSimpleConst.TRIANGLE: // if layout is triangle
					
						_myVTriangleBtn = new RegSimpleTriangleBtn();
						_myVTriangleBtn.size = _btnSize;
						_myVTriangleBtn.color = _btnColor;
						_myVTriangleBtn.a = _btnAlpha;
						_myVTriangleBtn.draw();
						_vScrollHolder.addChild(_myVTriangleBtn);
						(_isVBtnOnly) ? _myVTriangleBtn.x = 0 : _myVTriangleBtn.x = (_myVBg.width/2 - _btnSize/2) + _myVBg.x;
						
						_myVTriangleBtn2 = new RegSimpleTriangleBtn();
						_myVTriangleBtn2.size = _btnSize;
						_myVTriangleBtn2.color = _btnColor;
						_myVTriangleBtn2.a = _btnAlpha;
						_myVTriangleBtn2.draw();
						_vScrollHolder.addChild(_myVTriangleBtn2);
						if(_isVBtnOnly)
						{
							_myVTriangleBtn2.x = _btnSize;
							_myVTriangleBtn2.y = maskHeight;
						}
						else
						{
							_myVTriangleBtn2.x = ((_myVBg.width/2 - _btnSize/2) + _btnSize) + _myVBg.x;
							_myVTriangleBtn2.y = (_myVBg.height + _btnSpace + _btnSize) + _btnSize + _btnSpace;
						}
						_myVTriangleBtn2.rotation = 180;
						
						// set effects values
						_myVTriangleBtn.effectType = _btnEffectType;
						_myVTriangleBtn.effectColor = _btnEffectColor;
						_myVTriangleBtn.effectAlpha = _btnEffectAlpha;
						_myVTriangleBtn.effectAniInterval = _btnEffectAniInterval;
						if(_btnEffectType == EffectConst.GLOW || _btnEffectType == EffectConst.COLOR_GLOW)
						{
							_myVTriangleBtn.glowBlur = _btnGlowBlur;
							_myVTriangleBtn.glowStrength = _btnGlowStrength;
						}
						
						_myVTriangleBtn2.effectType = _btnEffectType;
						_myVTriangleBtn2.effectColor = _btnEffectColor;
						_myVTriangleBtn2.effectAlpha = _btnEffectAlpha;
						_myVTriangleBtn2.effectAniInterval = _btnEffectAniInterval;
						if(_btnEffectType == EffectConst.GLOW || _btnEffectType == EffectConst.COLOR_GLOW)
						{
							_myVTriangleBtn2.glowBlur = _btnGlowBlur;
							_myVTriangleBtn2.glowStrength = _btnGlowStrength;
						}
						
						// let's add its listeners
						if(!_isDisabledVScroll)
						{
							_myVTriangleBtn.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
							_myVTriangleBtn2.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
							_myVTriangleBtn.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
							_myVTriangleBtn2.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
							
							_myVTriangleBtn.addEventListener(MouseEvent.MOUSE_DOWN, moveContent, false, 0, true);
							_myVTriangleBtn2.addEventListener(MouseEvent.MOUSE_DOWN, moveContent, false, 0, true);
						}
						else
						{
							_myVTriangleBtn.removeListeners();
							_myVTriangleBtn2.removeListeners();
						}
					break;
						
					case RegSimpleConst.CIRCLE: // if layout is circle
						
						_myVCircleBtn = new RegSimpleCircleBtn();
						_myVCircleBtn.size = _btnSize;
						_myVCircleBtn.color = _btnColor;
						_myVCircleBtn.a = _btnAlpha;
						_myVCircleBtn.draw();
						_vScrollHolder.addChild(_myVCircleBtn);
						(_isVBtnOnly) ? _myVCircleBtn.x = 0 : _myVCircleBtn.x = (_myVBg.width/2 - _btnSize/2) + _myVBg.x;
						
						_myVCircleBtn2 = new RegSimpleCircleBtn();
						_myVCircleBtn2.size = _btnSize;
						_myVCircleBtn2.color = _btnColor;
						_myVCircleBtn2.a = _btnAlpha;
						_myVCircleBtn2.draw();
						_vScrollHolder.addChild(_myVCircleBtn2);
						if(_isVBtnOnly)
						{
							_myVCircleBtn2.x = _btnSize;
							_myVCircleBtn2.y = maskHeight;
						}
						else
						{
							_myVCircleBtn2.x = ((_myVBg.width/2 - _btnSize/2) + _btnSize) + _myVBg.x;
							_myVCircleBtn2.y = (_myVBg.height + _btnSpace + _btnSize) + _btnSize + _btnSpace;
						}
						_myVCircleBtn2.rotation = 180;
						
						// set effects values
						_myVCircleBtn.effectType = _btnEffectType;
						_myVCircleBtn.effectColor = _btnEffectColor;
						_myVCircleBtn.effectAlpha = _btnEffectAlpha;
						_myVCircleBtn.effectAniInterval = _btnEffectAniInterval;
						if(_btnEffectType == EffectConst.GLOW || _btnEffectType == EffectConst.COLOR_GLOW)
						{
							_myVCircleBtn.glowBlur = _btnGlowBlur;
							_myVCircleBtn.glowStrength = _btnGlowStrength;
						}
						
						_myVCircleBtn2.effectType = _btnEffectType;
						_myVCircleBtn2.effectColor = _btnEffectColor;
						_myVCircleBtn2.effectAlpha = _btnEffectAlpha;
						_myVCircleBtn2.effectAniInterval = _btnEffectAniInterval;
						if(_btnEffectType == EffectConst.GLOW)
						{
							_myVCircleBtn2.glowBlur = _btnGlowBlur;
							_myVCircleBtn2.glowStrength = _btnGlowStrength;
						}
						
						// let's add its listeners
						if(!_isDisabledVScroll)
						{
							_myVCircleBtn.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
							_myVCircleBtn2.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
							_myVCircleBtn.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
							_myVCircleBtn2.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
							
							_myVCircleBtn.addEventListener(MouseEvent.MOUSE_DOWN, moveContent, false, 0, true);
							_myVCircleBtn2.addEventListener(MouseEvent.MOUSE_DOWN, moveContent, false, 0, true);
						}
						else
						{
							_myVCircleBtn.removeListeners();
							_myVCircleBtn2.removeListeners();
						}
					break;
				}
			}
			
			// draw horizontal btns
			if(_hScrollHolder != null)
			{
				// let's draw the buttons
				switch(_btnLayout)
				{
					case RegSimpleConst.TRIANGLE: // if layout is triangle
					
						_myHTriangleBtn = new RegSimpleTriangleBtn();
						_myHTriangleBtn.size = _btnSize;
						_myHTriangleBtn.color = _btnColor;
						_myHTriangleBtn.a = _btnAlpha;
						_myHTriangleBtn.draw();
						_hScrollHolder.addChild(_myHTriangleBtn);
						(_isHBtnOnly == true) ? _myHTriangleBtn.y = _btnSize : _myHTriangleBtn.y = ((_myHBg.height/2 - _btnSize/2) + _btnSize) + _myHBg.y;
						_myHTriangleBtn.rotation = -90;
						
						_myHTriangleBtn2 = new RegSimpleTriangleBtn();
						_myHTriangleBtn2.size = _btnSize;
						_myHTriangleBtn2.color = _btnColor;
						_myHTriangleBtn2.a = _btnAlpha;
						_myHTriangleBtn2.draw();
						_hScrollHolder.addChild(_myHTriangleBtn2);
						if(_isHBtnOnly)
						{
							_myHTriangleBtn2.y =0;
							_myHTriangleBtn2.x = maskWidth;
						}
						else
						{
							_myHTriangleBtn2.y = (_myHBg.height/2 - _btnSize/2) + _myHBg.y;
							_myHTriangleBtn2.x = (_myHBg.width + _btnSpace + _btnSize) + _btnSize + _btnSpace;
						}
						_myHTriangleBtn2.rotation = 90;
						
						// set effects values
						_myHTriangleBtn.effectType = _btnEffectType;
						_myHTriangleBtn.effectColor = _btnEffectColor;
						_myHTriangleBtn.effectAlpha = _btnEffectAlpha;
						_myHTriangleBtn.effectAniInterval = _btnEffectAniInterval;
						if(_btnEffectType == EffectConst.GLOW || _btnEffectType == EffectConst.COLOR_GLOW)
						{
							_myHTriangleBtn.glowBlur = _btnGlowBlur;
							_myHTriangleBtn.glowStrength = _btnGlowStrength;
						}
						
						_myHTriangleBtn2.effectType = _btnEffectType;
						_myHTriangleBtn2.effectColor = _btnEffectColor;
						_myHTriangleBtn2.effectAlpha = _btnEffectAlpha;
						_myHTriangleBtn2.effectAniInterval = _btnEffectAniInterval;
						if(_btnEffectType == EffectConst.GLOW || _btnEffectType == EffectConst.COLOR_GLOW)
						{
							_myHTriangleBtn2.glowBlur = _btnGlowBlur;
							_myHTriangleBtn2.glowStrength = _btnGlowStrength;
						}
						
						// let's add its listeners
						if(!_isDisabledHScroll)
						{
							_myHTriangleBtn.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
							_myHTriangleBtn2.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
							_myHTriangleBtn.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
							_myHTriangleBtn2.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
							
							_myHTriangleBtn.addEventListener(MouseEvent.MOUSE_DOWN, moveContent, false, 0, true);
							_myHTriangleBtn2.addEventListener(MouseEvent.MOUSE_DOWN, moveContent, false, 0, true);
						}
						else
						{
							_myHTriangleBtn.removeListeners();
							_myHTriangleBtn2.removeListeners();
						}
					break;
						
					case RegSimpleConst.CIRCLE: // if layout is circle
						
						_myHCircleBtn = new RegSimpleCircleBtn();
						_myHCircleBtn.size = _btnSize;
						_myHCircleBtn.color = _btnColor;
						_myHCircleBtn.a = _btnAlpha;
						_myHCircleBtn.draw();
						_hScrollHolder.addChild(_myHCircleBtn);
						(_isHBtnOnly) ? _myHCircleBtn.y = 0 : _myHCircleBtn.y = (_myHBg.height/2 - _btnSize/2) + _myHBg.y;
						
						_myHCircleBtn2 = new RegSimpleCircleBtn();
						_myHCircleBtn2.size = _btnSize;
						_myHCircleBtn2.color = _btnColor;
						_myHCircleBtn2.a = _btnAlpha;
						_myHCircleBtn2.draw();
						_hScrollHolder.addChild(_myHCircleBtn2);
						if(_isHBtnOnly)
						{
							_myHCircleBtn2.y = _btnSize;
							_myHCircleBtn2.x = maskWidth;
						}
						else
						{
							_myHCircleBtn2.y = ((_myHBg.height/2 - _btnSize/2) + _btnSize) + _myHBg.y;
							_myHCircleBtn2.x = (_myHBg.width + _btnSpace + _btnSize) + _btnSize + _btnSpace;
						}
						_myHCircleBtn2.rotation = 180;
						
						// set effects values
						_myHCircleBtn.effectType = _btnEffectType;
						_myHCircleBtn.effectColor = _btnEffectColor;
						_myHCircleBtn.effectAlpha = _btnEffectAlpha;
						_myHCircleBtn.effectAniInterval = _btnEffectAniInterval;
						if(_btnEffectType == EffectConst.GLOW)
						{
							_myHCircleBtn.glowBlur = _btnGlowBlur;
							_myHCircleBtn.glowStrength = _btnGlowStrength;
						}
						
						_myHCircleBtn2.effectType = _btnEffectType;
						_myHCircleBtn2.effectColor = _btnEffectColor;
						_myHCircleBtn2.effectAlpha = _btnEffectAlpha;
						_myHCircleBtn2.effectAniInterval = _btnEffectAniInterval;
						if(_btnEffectType == EffectConst.GLOW || _btnEffectType == EffectConst.COLOR_GLOW)
						{
							_myHCircleBtn2.glowBlur = _btnGlowBlur;
							_myHCircleBtn2.glowStrength = _btnGlowStrength;
						}
						
						// let's add its listeners
						if(!_isDisabledHScroll)
						{
							_myHCircleBtn.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
							_myHCircleBtn2.addEventListener(MouseEvent.ROLL_OVER, objOver, false, 0, true);
							_myHCircleBtn.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
							_myHCircleBtn2.addEventListener(MouseEvent.ROLL_OUT, objOut, false, 0, true);
							
							_myHCircleBtn.addEventListener(MouseEvent.MOUSE_DOWN, moveContent, false, 0, true);
							_myHCircleBtn2.addEventListener(MouseEvent.MOUSE_DOWN, moveContent, false, 0, true);
						}
						else
						{
							_myHCircleBtn.removeListeners();
							_myHCircleBtn2.removeListeners();
						}
					break;
				}
			}
		}
		// moveContent function
		private function moveContent(e:MouseEvent):void
		{
			// check the vertical buttons
			if(_myVTriangleBtn != null) // if we have _myVTriangleBtn
			{
				if(e.currentTarget == _myVTriangleBtn)
				{
					// make _isVBtn1Down true so that ENTER_FRAME function can set the slider y
					_isVBtn1Down = true;
				}
				else if(e.currentTarget == _myVTriangleBtn2)
				{
				// make _isVBtn2Down true so that ENTER_FRAME function can set the slider y
					_isVBtn2Down = true;
				}
			}
			else if(_myVCircleBtn != null) // if we have _myVCircleBtn
			{
				if(e.currentTarget == _myVCircleBtn)
				{
					// make _isVBtn1Down true so that ENTER_FRAME function can set the slider y
					_isVBtn1Down = true;
				}
				else if(e.currentTarget == _myVCircleBtn2)
				{
					// make _isVBtn2Down true so that ENTER_FRAME function can set the slider y
					_isVBtn2Down = true;
				}
			}
			
			// check the horizontal buttons
			if(_myHTriangleBtn != null) // if we have _myHTriangleBtn
			{
				if(e.currentTarget == _myHTriangleBtn)
				{
					// make _isHBtn1Down true so that ENTER_FRAME function can set the slider x
					_isHBtn1Down = true;
				}
				else if(e.currentTarget == _myHTriangleBtn2)
				{
					// make _isHBtn2Down true so that ENTER_FRAME function can set the slider x
					_isHBtn2Down = true;
				}
			}
			else if(_myHCircleBtn != null) // if we have _myHCircleBtn
			{
				if(e.currentTarget == _myHCircleBtn)
				{
					// make _isHBtn1Down true so that ENTER_FRAME function can set the slider x
					_isHBtn1Down = true;
				}
				else if(e.currentTarget == _myHCircleBtn2)
				{
					// make _isHBtn2Down true so that ENTER_FRAME function can set the slider x
					_isHBtn2Down = true;
				}
			}
			
			// add its listener
			stage.addEventListener(MouseEvent.MOUSE_UP, stopMoving, false, 0, true);
		}
		// stopMoving function
		private function stopMoving(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopMoving);
			
			// make _isBtn1Down and _isBtn2Down false so that ENTER_FRAME function don't set the slider y or x any more
			_isVBtn1Down = false;
			_isVBtn2Down = false;
			
			_isHBtn1Down = false;
			_isHBtn2Down = false;
		}
		
		// objOver function
		private function objOver(e:MouseEvent):void
		{
			if(!e.buttonDown)
			{
				_isMouseOver = true; // to stop making _checkContentWH true in contentMover function, when mouse is over the elements and slider is moving
				_checkContentWH = false; // to stop checking width and height of the maskContent in the contentMover function
				
				if(_target != undefined){ _target.removeEventListener(ScrollEvent.TWEEN_COMPLETE, onTweenComplete) };
			}
		}
		// objOut function
		private function objOut(e:MouseEvent):void
		{
			e.currentTarget.addEventListener(ScrollEvent.TWEEN_COMPLETE, onTweenComplete, false, 0, true);
			_target =  e.currentTarget;
		}
		// onTweenComplete function
		private function onTweenComplete(e:ScrollEvent):void
		{
			_isMouseOver = false; // to make _checkContentWH true in contentMover function, when mouse is not over the elements and slider is moving
			
			if(_isSliderStopped){ _checkContentWH = true }; // to start checking width and height of the maskContent in the contentMover function
		}
		
		// here is the contentMover function
		private function contentMover(e:Event):void
		{
			this.dispatchEvent(new ScrollEvent(ScrollEvent.ENTER_FRAME));
			
			// check maskContent height and width
			if(_checkContentWH)
			{
				if(maskContent.height != _oldContentH && maskContent.width == _oldContentW)
				{
					setMoreSettings();
					
					// when we have slider
					_isSliderYSet = false;
					_isSliderXSet = false;
					
					// when we have btnOnly
					_isBtnScrollXSet = false;
					_isBtnScrollYSet = false;
					
					_runSliderYAni = true;
					_runSliderXAni = false; // now that just the maskHeight is modified, we don't want to run horizontal slider animation
					
					_oldContentH = maskContent.height;
					_oldContentW = maskContent.width;
				}
				else if(maskContent.width != _oldContentW && maskContent.height == _oldContentH)
				{
					setMoreSettings();
					
					// when we have slider
					_isSliderYSet = false;
					_isSliderXSet = false;
					
					// when we have btnOnly
					_isBtnScrollXSet = false;
					_isBtnScrollYSet = false;
					
					_runSliderYAni = false; // now that just the maskWidth is modified, we don't want to run vertical slider animation
					_runSliderXAni = true;
					
					_oldContentH = maskContent.height;
					_oldContentW = maskContent.width;
				}
				else if(maskContent.width != _oldContentW && maskContent.height != _oldContentH)
				{
					setMoreSettings();
					
					// when we have slider
					_isSliderYSet = false;
					_isSliderXSet = false;
					
					// when we have btnOnly
					_isBtnScrollXSet = false;
					_isBtnScrollYSet = false;
					
					_runSliderYAni = true;
					_runSliderXAni = true;
					
					_oldContentH = maskContent.height;
					_oldContentW = maskContent.width;
				}
			}
			
			if (_checkMaskWH) // to check if the mask size changed set the content position again according to the percentage
			{
				// we don't need to call any function here like _checkContentWH, because mask size only changes when WE ourself change it by calling maskWidth() or maskHeight(), so we do any other function by using them if we needed
				if(maskHeight != _oldMaskH && maskWidth == _oldMaskW)
				{
					// when we have slider
					_isSliderYSet = false;
					_isSliderXSet = false;
					
					// when we have btnOnly
					_isBtnScrollXSet = false;
					_isBtnScrollYSet = false;
					
					_runSliderYAni = true;
					_runSliderXAni = false; // now that just the maskHeight is modified, we don't want to run horizontal slider animation
					
					_oldMaskH = maskHeight;
					
				}
				else if(maskWidth != _oldMaskW && maskHeight == _oldMaskH)
				{
					// when we have slider
					_isSliderYSet = false;
					_isSliderXSet = false;
					
					// when we have btnOnly
					_isBtnScrollXSet = false;
					_isBtnScrollYSet = false;
					
					_runSliderYAni = false; // now that just the maskWidth is modified, we don't want to run vertical slider animation
					_runSliderXAni = true;
					
					_oldMaskW = maskWidth;
				}
				else if(maskWidth != _oldMaskW && maskHeight != _oldMaskH)
				{
					// when we have slider
					_isSliderYSet = false;
					_isSliderXSet = false;
					
					// when we have btnOnly
					_isBtnScrollXSet = false;
					_isBtnScrollYSet = false;
					
					_runSliderYAni = true;
					_runSliderXAni = true;
					
					_oldMaskH = maskHeight;
					_oldMaskW = maskWidth;
				}
			}
			
			// check scroll availability
			if(_myVSlider != null || _myHSlider != null)
			{
				// set scroll variables
				var __setSliderY:Number;
				var __vSliderMax:Number;
				var __vSliderMin:Number;
				var __sliderAvailableH:Number;
				var __contentAvailableH:Number;
				var __contentY:Number;
				var __oldContentY:Number;
				var __vSliderSpeed:Number;
				
				var __setSliderX:Number;
				var __hSliderMax:Number;
				var __hSliderMin:Number;
				var __sliderAvailableW:Number;
				var __contentAvailableW:Number;
				var __contentX:Number;
				var __oldContentX:Number;
				var __hSliderSpeed:Number;
				
				// if we have _vScrollHolder
				if(_myVSlider != null && _myHSlider == null)
				{
					// set slider y if it's not set
					if(!_isSliderYSet)
					{
						if(_scrollManualY > 100 || _scrollManualY < 0 || _scrollManualY == 0)
						{
							_scrollManualY = 0;
							if(!_isOldSliderYSet){_myVSlider.y = _oldVSliderY};
							
							_isSliderYSet = true;
						}
						else
						{
							// set __setSliderY according to _scrollManualY
							__setSliderY = (_scrollManualY/100)*((_myVBg.height - _myVSlider.height) - (_sliderVSpace*2));
							_myVSlider.y = (_myVBg.y + Math.min(_sliderVSpace, _myVBg.height/2)) + __setSliderY;
							
							if(_isFirstTimeYSet)
							{
								// set the maskContent.y accoring to _myVSlider.y
								// get __contentY
								__sliderAvailableH = (_btnSize == 0) ? maskHeight - _myVSlider.height - (_sliderVSpace*2) : maskHeight - ((_btnSize + _btnSpace)*2) - _myVSlider.height - (_sliderVSpace*2);
								__contentAvailableH =  maskContent.height - maskHeight;
								
								//_scrollPerc = ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace)) / __sliderAvailableH) we use it to get __contentY
								__contentY = (_btnSize == 0) ? -(((_myVSlider.y-_sliderVSpace)/__sliderAvailableH)*__contentAvailableH)
														: -(((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace))/__sliderAvailableH)*__contentAvailableH);
								maskContent.y = __contentY;
							}
							
							_oldVSliderY = _myVSlider.y;
							
							if(_runSliderYAni) // if we want to run the animation
							{
								// change the _oldVSliderY value, so that the next if function can work to set the content y after maskHeight modification
								_oldVSliderY --;
							}
							
							_isFirstTimeYSet = false;
							_isSliderYSet = true;
						}
					}
					
					// if we moved the _myVSlider
					if(_oldVSliderY != _myVSlider.y)
					{
						_checkContentWH = false; // to stop checking width and height of the maskContent
						_isSliderStopped = false; // to set _checkContentWH to true value when slider is stopped
						
						_isVSliderStopped = false; // slider is moving so don't run else function
						
						// remove the old tween
						//_vScrollTween = TweenMax.removeTween(_vScrollTween);
						_vScrollTween = null;
						
						// set percentage
						_scrollManualY = (_btnSize == 0) ? Math.round( ((_myVSlider.y-_sliderVSpace)/((_myVBg.height - _myVSlider.height) - (_sliderVSpace*2)))*100 )
														 : Math.round( ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace))/((_myVBg.height - _myVSlider.height) - (_sliderVSpace*2)))*100 );
						
						
						// get __contentY and __oldContentY
						__sliderAvailableH = (_btnSize == 0) ? maskHeight - _myVSlider.height - (_sliderVSpace*2) : maskHeight - ((_btnSize + _btnSpace)*2) - _myVSlider.height - (_sliderVSpace*2);
						__contentAvailableH =  maskContent.height - maskHeight;
						
						//_scrollPerc = ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace)) / __sliderAvailableH) we use it to get __contentY
						__contentY = (_btnSize == 0) ? -(((_myVSlider.y-_sliderVSpace)/__sliderAvailableH)*__contentAvailableH)
													 : -(((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace))/__sliderAvailableH)*__contentAvailableH);
													
						__oldContentY = (_btnSize == 0) ? -(( (_oldVSliderY-_sliderVSpace) /__sliderAvailableH)*__contentAvailableH)
													    : -(( (_oldVSliderY-(_btnSize+_btnSpace+_sliderVSpace)) /__sliderAvailableH)*__contentAvailableH);
						
						// set the _oldVSliderY to the new _myVSlider.y
						_isOldSliderYSet = true; // to stop giving value to it when we create a new slider
						_oldVSliderY = _myVSlider.y;
						
						// if we have chosen to have scroll blur effect, understand the slider speed
						__vSliderSpeed = (__contentY - __oldContentY) / _scrollAniInterval;
						__vSliderSpeed = Math.sqrt(Math.pow(__vSliderSpeed, 2)); // set to always get positive number
						
						// run my tween
						_vScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {bezier:[{y:__oldContentY}, {y:__contentY}], ease:_easeType});
						if(_scrollBlurEffect && _scrollAniInterval != 0){ _vScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurY:__vSliderSpeed}, ease:_easeType}) };
					}
					else
					{
						if(!_isSliderStopped)
						{
							if(!_isMouseOver)
							{
								_checkContentWH = true; // to start checking width and height of the maskContent
								_isSliderStopped = true;
							}
						}
						
						if(_scrollBlurEffect && _scrollAniInterval != 0) // if we have scroll blur option
						{
							if(!_isVSliderStopped) // if the slider is not moving
							{
								_isVSliderStopped = true;
								
								// remove my blur tween
								_vScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurY:0, remove:true}, ease:_easeType});
							}
						}
					}
					
					// if we clicked the vertical buttons
					if(_isVBtn1Down) // if we clicked button 1
					{
						__vSliderMin = _myVBg.y + _sliderVSpace;
						
						/*if(_myVSlider.y > _sliderMin)
						{
							newY = ((_sliderMax) / 100) * _scrollManualY;
							_myVSlider.y = _myVSlider.y - (-newY + _myVSlider.y) / 10;
							(_myVSlider.y < _sliderMin) ? _myVSlider.y = _sliderMin : _myVSlider.y;
						}*/
						
						if(_myVSlider.y > __vSliderMin)
						{
							_myVSlider.y -= _btnScrollSpeed;
							
							(_myVSlider.y < __vSliderMin) ? _myVSlider.y = __vSliderMin : _myVSlider.y;
						}
					}
					else if(_isVBtn2Down) // if we clicked button 2
					{
						__vSliderMax = maskHeight - (_btnSize + _btnSpace) - _myVSlider.height - _sliderVSpace;
						
						if(_myVSlider.y < __vSliderMax)
						{
							_myVSlider.y += _btnScrollSpeed;
							
							(_myVSlider.y > __vSliderMax) ? _myVSlider.y = __vSliderMax : _myVSlider.y;
						}
					}
				}
				// if we have _hScrollHolder
				else if(_myHSlider != null && _myVSlider == null)
				{
					// set slider x if it's not set
					if(!_isSliderXSet)
					{
						
						if(_scrollManualX > 100 || _scrollManualX < 0 || _scrollManualX == 0)
						{
							_scrollManualX = 0;
							if(!_isOldSliderXSet){_myHSlider.x = _oldHSliderX};
							
							_isSliderXSet = true;
						}
						else
						{
							// set __setSliderX according to _scrollManualX
							__setSliderX = (_scrollManualX/100)*((_myHBg.width - _myHSlider.width) - (_sliderHSpace*2));
							_myHSlider.x = (_myHBg.x + Math.min(_sliderHSpace, _myHBg.width/2)) + __setSliderX;
							
							if(_isFirstTimeXSet)
							{
								// set the maskContent.x accoring to _myHSlider.x
								// get __contentY
								__sliderAvailableW = (_btnSize == 0) ? maskWidth - _myHSlider.width - (_sliderHSpace*2) : maskWidth - ((_btnSize + _btnSpace)*2) - _myHSlider.width - (_sliderHSpace*2);
								__contentAvailableW =  maskContent.width - maskWidth;
								
								//_scrollPerc = ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace)) / __sliderAvailableH) we use it to get __contentY
								__contentX = (_btnSize == 0) ? -(((_myHSlider.x-_sliderHSpace)/__sliderAvailableW)*__contentAvailableW)
														: -(((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace))/__sliderAvailableW)*__contentAvailableW);
								maskContent.x = __contentX;
							}
							
							_oldHSliderX = _myHSlider.x;
							
							if(_runSliderXAni) // if we want to run the animation
							{
								// change the _oldHSliderX value, so that the next if function can work to set the content x after maskWidth modification
								_oldHSliderX --;
							}
							
							_isFirstTimeXSet = false;
							_isSliderXSet = true;
						}
					}
					
					// if we moved the _myHSlider
					if(_oldHSliderX != _myHSlider.x)
					{
						_checkContentWH = false; // to stop checking width and height of the maskContent
						_isSliderStopped = false; // to set _checkContentWH to true value when slider is stopped
						
						_isHSliderStopped = false; // slider is moving so don't run else function
						
						// remove the old tween
						//_hScrollTween = TweenMax.removeTween(_hScrollTween);
						_hScrollTween = null;
						
						// set percentage
						_scrollManualX = (_btnSize == 0) ? Math.round( ((_myHSlider.x-_sliderHSpace)/((_myHBg.width - _myHSlider.width) - (_sliderHSpace*2)))*100 )
														 : Math.round( ((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace))/((_myHBg.width - _myHSlider.width) - (_sliderHSpace*2)))*100 );
						
						
						// get __contentY and __oldContentY
						__sliderAvailableW = (_btnSize == 0) ? maskWidth - _myHSlider.width - (_sliderHSpace*2) : maskWidth - ((_btnSize + _btnSpace)*2) - _myHSlider.width - (_sliderHSpace*2);
						__contentAvailableW =  maskContent.width - maskWidth;
						
						//_scrollPerc = ((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace)) / __sliderAvailableW) we use it to get __contentY
						__contentX = (_btnSize == 0) ? -(((_myHSlider.x-_sliderHSpace)/__sliderAvailableW)*__contentAvailableW)
													 : -(((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace))/__sliderAvailableW)*__contentAvailableW);
													
						__oldContentX = (_btnSize == 0) ? -(( (_oldHSliderX-_sliderHSpace) /__sliderAvailableW)*__contentAvailableW)
													    : -(( (_oldHSliderX-(_btnSize+_btnSpace+_sliderHSpace)) /__sliderAvailableW)*__contentAvailableW);
						
						// set the _oldHSliderX to the new _myHSlider.x
						_isOldSliderXSet = true; // to stop giving value to it when we create a new slider
						_oldHSliderX = _myHSlider.x;
						
						// if we have chosen to have scroll blur effect, understand the slider speed
						__hSliderSpeed = (__contentX - __oldContentX) / _scrollAniInterval;
						__hSliderSpeed = Math.sqrt(Math.pow(__hSliderSpeed, 2)); // set to always get positive number
						
						// run my tween
						_hScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {bezier:[{x:__oldContentX}, {x:__contentX}], ease:_easeType});
						if(_scrollBlurEffect && _scrollAniInterval != 0){ _hScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurX:__hSliderSpeed}, ease:_easeType}) };
					}
					else
					{
						if(!_isSliderStopped)
						{
							if(!_isMouseOver)
							{
								_checkContentWH = true; // to start checking width and height of the maskContent
								_isSliderStopped = true;
							}
						}
						
						if(_scrollBlurEffect && _scrollAniInterval != 0) // if we have scroll blur option
						{
							if(!_isHSliderStopped) // if the slider is not moving
							{
								_isHSliderStopped = true;
								
								// remove my blur tween
								_hScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurX:0, remove:true}, ease:_easeType});
							}
						}
					}
					
					// if we clicked the horizontal buttons
					if(_isHBtn1Down) // if we clicked buttons 1
					{
						__hSliderMin = _myHBg.x + _sliderHSpace;
						
						if(_myHSlider.x > __hSliderMin)
						{
							_myHSlider.x -= _btnScrollSpeed;
							
							(_myHSlider.x < __hSliderMin) ? _myHSlider.x = __hSliderMin : _myHSlider.x;
						}
					}
					else if(_isHBtn2Down) // if we clicked buttons 2
					{
						__hSliderMax = maskWidth - (_btnSize + _btnSpace) - _myHSlider.width - _sliderHSpace;
						
						if(_myHSlider.x < __hSliderMax)
						{
							_myHSlider.x += _btnScrollSpeed;
							
							(_myHSlider.x > __hSliderMax) ? _myHSlider.x = __hSliderMax : _myHSlider.x;
						}
					}
				}
				// if we have _hScrollHolder and _vScrollHolder
				else if(_myHSlider != null && _myVSlider != null)
				{
					// set slider y if it's not set
					if(!_isSliderYSet)
					{
						if(_scrollManualY > 100 || _scrollManualY < 0 || _scrollManualY == 0)
						{
							_scrollManualY = 0;
							if(!_isOldSliderYSet){_myVSlider.y = _oldVSliderY};
							
							_isSliderYSet = true;
						}
						else
						{
							// set __setSliderY according to _scrollManualY
							__setSliderY = (_scrollManualY/100)*((_myVBg.height - _myVSlider.height) - (_sliderVSpace*2));
							_myVSlider.y = (_myVBg.y + Math.min(_sliderVSpace, _myVBg.height/2)) + __setSliderY;
							
							if(_isFirstTimeYSet)
							{
								// set the maskContent.y accoring to _myVSlider.y
								// get __contentY
								__sliderAvailableH = (_btnSize == 0) ? maskHeight - _myVSlider.height - (_sliderVSpace*2) : maskHeight - ((_btnSize + _btnSpace)*2) - _myVSlider.height - (_sliderVSpace*2);
								__contentAvailableH =  maskContent.height - maskHeight;
								
								//_scrollPerc = ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace)) / __sliderAvailableH) we use it to get __contentY
								__contentY = (_btnSize == 0) ? -(((_myVSlider.y-_sliderVSpace)/__sliderAvailableH)*__contentAvailableH)
														: -(((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace))/__sliderAvailableH)*__contentAvailableH);
								maskContent.y = __contentY;
							}
							
							_oldVSliderY = _myVSlider.y;
							
							if(_runSliderYAni) // if we want to run the animation
							{
								// change the _oldVSliderY value, so that the next if function can work to set the content y after maskHeight modification
								_oldVSliderY --;
							}
							
							_isFirstTimeYSet = false;
							_isSliderYSet = true;
						}
					}
					
					// if we clicked the vertical buttons
					if(_isVBtn1Down) // if we clicked button 1
					{
						__vSliderMin = _myVBg.y + _sliderVSpace;
						
						if(_myVSlider.y > __vSliderMin)
						{
							_myVSlider.y -= _btnScrollSpeed;
							
							(_myVSlider.y < __vSliderMin) ? _myVSlider.y = __vSliderMin : _myVSlider.y;
						}
					}
					else if(_isVBtn2Down) // if we clicked button 2
					{
						__vSliderMax = maskHeight - (_btnSize + _btnSpace) - _myVSlider.height - _sliderVSpace;
						
						if(_myVSlider.y < __vSliderMax)
						{
							_myVSlider.y += _btnScrollSpeed;
							
							(_myVSlider.y > __vSliderMax) ? _myVSlider.y = __vSliderMax : _myVSlider.y;
						}
					}
					
					// set slider x if it's not set
					if(!_isSliderXSet)
					{
						
						if(_scrollManualX > 100 || _scrollManualX < 0 || _scrollManualX == 0)
						{
							_scrollManualX = 0;
							if(!_isOldSliderXSet){_myHSlider.x = _oldHSliderX};
							
							_isSliderXSet = true;
						}
						else
						{
							// set __setSliderX according to _scrollManualX
							__setSliderX = (_scrollManualX/100)*((_myHBg.width - _myHSlider.width) - (_sliderHSpace*2));
							_myHSlider.x = (_myHBg.x + Math.min(_sliderHSpace, _myHBg.width/2)) + __setSliderX;
							
							if(_isFirstTimeXSet)
							{
								// set the maskContent.x accoring to _myHSlider.x
								// get __contentX
								__sliderAvailableW = (_btnSize == 0) ? maskWidth - _myHSlider.width - (_sliderHSpace*2) : maskWidth - ((_btnSize + _btnSpace)*2) - _myHSlider.width - (_sliderHSpace*2);
								__contentAvailableW =  maskContent.width - maskWidth;
								
								//_scrollPerc = ((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace)) / __sliderAvailableW) we use it to get __contentX
								__contentX = (_btnSize == 0) ? -(((_myHSlider.x-_sliderHSpace)/__sliderAvailableW)*__contentAvailableW)
															 : -(((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace))/__sliderAvailableW)*__contentAvailableW);
								maskContent.x = __contentX;
							}
							
							_oldHSliderX = _myHSlider.x;
							
							if(_runSliderXAni) // if we want to run the animation
							{
								// change the _oldHSliderX value, so that the next if function can work to set the content x after maskWidth modification
								_oldHSliderX --;
							}
							
							_isFirstTimeXSet = false;
							_isSliderXSet = true;
						}
					}
					
					// if we clicked the horizontal buttons
					if(_isHBtn1Down) // if we clicked buttons 1
					{
						__hSliderMin = _myHBg.x + _sliderHSpace;
						
						if(_myHSlider.x > __hSliderMin)
						{
							_myHSlider.x -= _btnScrollSpeed;
							
							(_myHSlider.x < __hSliderMin) ? _myHSlider.x = __hSliderMin : _myHSlider.x;
						}
					}
					else if(_isHBtn2Down) // if we clicked buttons 2
					{
						__hSliderMax = maskWidth - (_btnSize + _btnSpace) - _myHSlider.width - _sliderHSpace;
						
						if(_myHSlider.x < __hSliderMax)
						{
							_myHSlider.x += _btnScrollSpeed;
							
							(_myHSlider.x > __hSliderMax) ? _myHSlider.x = __hSliderMax : _myHSlider.x;
						}
					}
					
					
					
					// if we moved the _myVSlider
					if(_oldVSliderY != _myVSlider.y && _oldHSliderX == _myHSlider.x)
					{
						_checkContentWH = false; // to stop checking width and height of the maskContent
						_isSliderStopped = false; // to set _checkContentWH to true value when slider is stopped
						
						_isVSliderStopped = false; // slider is moving so don't run else function
						
						// remove the old tween
						//_vScrollTween = TweenMax.removeTween(_vScrollTween);
						_vScrollTween = null;
						
						// set percentage
						_scrollManualY = (_btnSize == 0) ? Math.round( ((_myVSlider.y-_sliderVSpace)/((_myVBg.height - _myVSlider.height) - (_sliderVSpace*2)))*100 )
														 : Math.round( ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace))/((_myVBg.height - _myVSlider.height) - (_sliderVSpace*2)))*100 );
						
						
						// get __contentY and __oldContentY
						__sliderAvailableH = (_btnSize == 0) ? maskHeight - _myVSlider.height - (_sliderVSpace*2) : maskHeight - ((_btnSize + _btnSpace)*2) - _myVSlider.height - (_sliderVSpace*2);
						__contentAvailableH =  maskContent.height - maskHeight;
						
						//_scrollPerc = ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace)) / __sliderAvailableH) we use it to get __contentY
						__contentY = (_btnSize == 0) ? -(((_myVSlider.y-_sliderVSpace)/__sliderAvailableH)*__contentAvailableH)
													 : -(((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace))/__sliderAvailableH)*__contentAvailableH);
													
						__oldContentY = (_btnSize == 0) ? -(( (_oldVSliderY-_sliderVSpace) /__sliderAvailableH)*__contentAvailableH)
													    : -(( (_oldVSliderY-(_btnSize+_btnSpace+_sliderVSpace)) /__sliderAvailableH)*__contentAvailableH);
						
						// set the _oldVSliderY to the new _myVSlider.y
						_isOldSliderYSet = true; // to stop giving value to it when we create a new slider
						_oldVSliderY = _myVSlider.y;
						
						// if we have chosen to have scroll blur effect, understand the slider speed
						__vSliderSpeed = (__contentY - __oldContentY) / _scrollAniInterval;
						__vSliderSpeed = Math.sqrt(Math.pow(__vSliderSpeed, 2)); // set to always get positive number
						
						// run my tween
						_vScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {bezier:[{y:__oldContentY}, {y:__contentY}], ease:_easeType});
						if(_scrollBlurEffect && _scrollAniInterval != 0){ _vScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurY:__vSliderSpeed}, ease:_easeType}) };
					}
					// if we moved the _myHSlider
					else if(_oldHSliderX != _myHSlider.x && _oldVSliderY == _myVSlider.y)
					{
						_checkContentWH = false; // to stop checking width and height of the maskContent
						_isSliderStopped = false; // to set _checkContentWH to true value when slider is stopped
						
						_isHSliderStopped = false; // slider is moving so don't run else function
						
						// remove the old tween
						//_hScrollTween = TweenMax.removeTween(_hScrollTween);
						_hScrollTween = null;
						
						// set percentage
						_scrollManualX = (_btnSize == 0) ? Math.round( ((_myHSlider.x-_sliderHSpace)/((_myHBg.width - _myHSlider.width) - (_sliderHSpace*2)))*100 )
														 : Math.round( ((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace))/((_myHBg.width - _myHSlider.width) - (_sliderHSpace*2)))*100 );
						
						
						// get __contentY and __oldContentY
						__sliderAvailableW = (_btnSize == 0) ? maskWidth - _myHSlider.width - (_sliderHSpace*2) : maskWidth - ((_btnSize + _btnSpace)*2) - _myHSlider.width - (_sliderHSpace*2);
						__contentAvailableW =  maskContent.width - maskWidth;
						
						//_scrollPerc = ((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace)) / __sliderAvailableW) we use it to get __contentY
						__contentX = (_btnSize == 0) ? -(((_myHSlider.x-_sliderHSpace)/__sliderAvailableW)*__contentAvailableW)
													 : -(((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace))/__sliderAvailableW)*__contentAvailableW);
													
						__oldContentX = (_btnSize == 0) ? -(( (_oldHSliderX-_sliderHSpace) /__sliderAvailableW)*__contentAvailableW)
													    : -(( (_oldHSliderX-(_btnSize+_btnSpace+_sliderHSpace)) /__sliderAvailableW)*__contentAvailableW);
						
						// set the _oldHSliderX to the new _myHSlider.x
						_isOldSliderXSet = true; // to stop giving value to it when we create a new slider
						_oldHSliderX = _myHSlider.x;
						
						// if we have chosen to have scroll blur effect, understand the slider speed
						__hSliderSpeed = (__contentX - __oldContentX) / _scrollAniInterval;
						__hSliderSpeed = Math.sqrt(Math.pow(__hSliderSpeed, 2)); // set to always get positive number
						
						// run my tween
						_hScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {bezier:[{x:__oldContentX}, {x:__contentX}], ease:_easeType});
						if(_scrollBlurEffect && _scrollAniInterval != 0){ _hScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurX:__hSliderSpeed, blurY:0}, ease:_easeType}) };
					}
					// if we moved the _myVSlider and _myHSlider
					else if(_oldHSliderX != _myHSlider.x && _oldVSliderY != _myVSlider.y)
					{
						_checkContentWH = false; // to stop checking width and height of the maskContent
						_isSliderStopped = false; // to set _checkContentWH to true value when slider is stopped
						
						// vertical movement settings ///////////////////////////////////
						_isVSliderStopped = false; // slider is moving so don't run else function
						
						// remove the old tween
						//_vScrollTween = TweenMax.removeTween(_vScrollTween);
						_vScrollTween = null;
						
						// set percentage
						_scrollManualY = (_btnSize == 0) ? Math.round( ((_myVSlider.y-_sliderVSpace)/((_myVBg.height - _myVSlider.height) - (_sliderVSpace*2)))*100 )
														 : Math.round( ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace))/((_myVBg.height - _myVSlider.height) - (_sliderVSpace*2)))*100 );
						
						
						// get __contentY and __oldContentY
						__sliderAvailableH = (_btnSize == 0) ? maskHeight - _myVSlider.height - (_sliderVSpace*2) : maskHeight - ((_btnSize + _btnSpace)*2) - _myVSlider.height - (_sliderVSpace*2);
						__contentAvailableH =  maskContent.height - maskHeight;
						
						//_scrollPerc = ((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace)) / __sliderAvailableH) we use it to get __contentY
						__contentY = (_btnSize == 0) ? -(((_myVSlider.y-_sliderVSpace)/__sliderAvailableH)*__contentAvailableH)
													 : -(((_myVSlider.y-(_btnSize+_btnSpace+_sliderVSpace))/__sliderAvailableH)*__contentAvailableH);
													
						__oldContentY = (_btnSize == 0) ? -(( (_oldVSliderY-_sliderVSpace) /__sliderAvailableH)*__contentAvailableH)
													    : -(( (_oldVSliderY-(_btnSize+_btnSpace+_sliderVSpace)) /__sliderAvailableH)*__contentAvailableH);
						
						// set the _oldVSliderY to the new _myVSlider.y
						_isOldSliderYSet = true; // to stop giving value to it when we create a new slider
						_oldVSliderY = _myVSlider.y;
						
						// if we have chosen to have scroll blur effect, understand the slider speed
						__vSliderSpeed = (__contentY - __oldContentY) / _scrollAniInterval;
						__vSliderSpeed = Math.sqrt(Math.pow(__vSliderSpeed, 2)); // set to always get positive number
						
						// horizontal movement settings ///////////////////////////////////
						_isHSliderStopped = false; // slider is moving so don't run else function
						
						// remove the old tween
						//_hScrollTween = TweenMax.removeTween(_hScrollTween);
						_hScrollTween = null;
						
						// set percentage
						_scrollManualX = (_btnSize == 0) ? Math.round( ((_myHSlider.x-_sliderHSpace)/((_myHBg.width - _myHSlider.width) - (_sliderHSpace*2)))*100 )
														 : Math.round( ((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace))/((_myHBg.width - _myHSlider.width) - (_sliderHSpace*2)))*100 );
						
						
						// get __contentY and __oldContentY
						__sliderAvailableW = (_btnSize == 0) ? maskWidth - _myHSlider.width - (_sliderHSpace*2) : maskWidth - ((_btnSize + _btnSpace)*2) - _myHSlider.width - (_sliderHSpace*2);
						__contentAvailableW =  maskContent.width - maskWidth;
						
						//_scrollPerc = ((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace)) / __sliderAvailableW) we use it to get __contentY
						__contentX = (_btnSize == 0) ? -(((_myHSlider.x-_sliderHSpace)/__sliderAvailableW)*__contentAvailableW)
													: -(((_myHSlider.x-(_btnSize+_btnSpace+_sliderHSpace))/__sliderAvailableW)*__contentAvailableW);
													
						__oldContentX = (_btnSize == 0) ? -(( (_oldHSliderX-_sliderHSpace) /__sliderAvailableW)*__contentAvailableW)
													   : -(( (_oldHSliderX-(_btnSize+_btnSpace+_sliderHSpace)) /__sliderAvailableW)*__contentAvailableW);
						
						// set the _oldHSliderX to the new _myHSlider.x
						_isOldSliderXSet = true; // to stop giving value to it when we create a new slider
						_oldHSliderX = _myHSlider.x;
						
						// if we have chosen to have scroll blur effect, understand the slider speed
						__hSliderSpeed = (__contentX - __oldContentX) / _scrollAniInterval;
						__hSliderSpeed = Math.sqrt(Math.pow(__hSliderSpeed, 2)); // set to always get positive number
						
						// run my tween
						_scrollTween = TweenMax.to(maskContent, _scrollAniInterval, {bezier:[{x:__oldContentX, y:__oldContentY}, {x:__contentX, y:__contentY}], ease:_easeType});
						if(_scrollBlurEffect && _scrollAniInterval != 0){ _scrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurX:__hSliderSpeed, blurY:__vSliderSpeed}, ease:_easeType}) };
					}
					// if _myVSlider and _myHSlider are stopped
					else if(_oldHSliderX == _myHSlider.x && _oldVSliderY == _myVSlider.y)
					{
						if(!_isSliderStopped)
						{
							if(!_isMouseOver)
							{
								_checkContentWH = true; // to start checking width and height of the maskContent
								_isSliderStopped = true;
							}
						}
						
						// remove vertical and horizontal blur effects
						if(_scrollBlurEffect && _scrollAniInterval != 0) // if we have scroll blur option
						{
							if(!_isVSliderStopped && _isHSliderStopped) // if the vertical slider is not moving recently
							{
								_isVSliderStopped = true;
								
								// remove my blur tween
								_vScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurY:0, remove:true}, ease:_easeType});
							}
							else if(!_isHSliderStopped && _isVSliderStopped) // if the horizontal slider is not moving recently
							{
								_isHSliderStopped = true;
								
								// remove my blur tween
								_hScrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurX:0, remove:true}, ease:_easeType});
							}
							else if(!_isHSliderStopped && !_isVSliderStopped) // if both sliders are not moving recently
							{
								_isVSliderStopped = true;
								_isHSliderStopped = true;
								
								// remove my blur tween
								_scrollTween = TweenMax.to(maskContent, _scrollAniInterval, {blurFilter:{blurX:0, blurY:0, remove:true}, ease:_easeType});
							}
						}
					}
				}
			}
			else if (_myVSlider == null && _myHSlider == null)
			{
				if (!_isVBtnOnly && _isHBtnOnly)
				{
					if (maskContent.y != 0)
					{
						TweenMax.to(maskContent, .2, {bezier:[{ y:0 }]});
					}
					if (_scrollBlurEffect && _scrollAniInterval != 0) TweenMax.to(maskContent, .2, { blurFilter: { blurY:0, remove:true }} );
				}
				else if (_isVBtnOnly && !_isHBtnOnly)
				{
					if (maskContent.x != 0)
					{
						TweenMax.to(maskContent, .2, {bezier:[{ x:0 }]});
					}
					if (_scrollBlurEffect && _scrollAniInterval != 0) TweenMax.to(maskContent, .2, { blurFilter: { blurX:0, remove:true }} );
				}
				else if (!_isVBtnOnly && !_isHBtnOnly)
				{
					if (maskContent.x != 0 || maskContent.y != 0)
					{
						TweenMax.to(maskContent, .2, {bezier:[{ x:0, y:0 }]});
					}
					if (_scrollBlurEffect && _scrollAniInterval != 0) TweenMax.to(maskContent, .2, { blurFilter: { blurX:0, blurY:0, remove:true }} );
				}
			}
			
			// check BtnOnly availability
			if(_btnSize != 0)
			{
				if(_isVBtnOnly || _isHBtnOnly)
				{
					// set BtnOnly variables
					var __vScrollMax:Number;
					var __vScrollMin:Number;
					var __setContentY:Number;
					
					var __hScrollMax:Number;
					var __hScrollMin:Number;
					var __setContentX:Number;
					
					// if we need vertical buttons
					if(_isVBtnOnly && !_isHBtnOnly)
					{
						// set btn scroll y if it's not set
						if(!_isBtnScrollYSet)
						{
							if(_scrollManualY > 100 || _scrollManualY < 0 || _scrollManualY == 0)
							{
								_scrollManualY = 0;
								maskContent.y = 0;
								
								_isBtnScrollYSet = true;
							}
							else
							{
								// set __setContentY according to _scrollManualY
								__setContentY = (_scrollManualY/100)*(maskContent.height - maskHeight);
								maskContent.y =  - __setContentY;

								_isBtnScrollYSet = true;
							}
						}
						
						// set percentage
						_scrollManualY = - ( Math.round( maskContent.y/(maskContent.height - maskHeight)*100 ) );
						
						// if we clicked the vertical buttons
						if(_isVBtn1Down) // if we clicked button 1
						{
							__vScrollMin = 0;
							
							if(maskContent.y < __vScrollMin)
							{
								maskContent.y += _btnScrollSpeed;
								
								(maskContent.y > __vScrollMin) ? maskContent.y = __vScrollMin : maskContent.y;
							}
						}
						else if(_isVBtn2Down) // if we clicked button 2
						{
							__vScrollMax = maskContent.height - maskHeight;
							
							if(maskContent.y > - (__vScrollMax))
							{
								maskContent.y -= _btnScrollSpeed;
								
								(maskContent.y < - (__vScrollMax)) ? maskContent.y = - (__vScrollMax) : maskContent.y;
							}
						}
					}
					// if we need horizontal buttons
					else if(_isHBtnOnly && !_isVBtnOnly)
					{
						// set btn scroll x if it's not set
						if(!_isBtnScrollXSet)
						{
							if(_scrollManualX > 100 || _scrollManualX < 0 || _scrollManualX == 0)
							{
								_scrollManualX = 0;
								maskContent.x = 0;
								
								_isBtnScrollXSet = true;
							}
							else
							{
								// set __setContentX according to _scrollManualX
								__setContentX = (_scrollManualX/100)*(maskContent.width - maskWidth);
								maskContent.x =  - __setContentX;

								_isBtnScrollXSet = true;
							}
						}
						
						// set percentage
						_scrollManualX = - ( Math.round( maskContent.x/(maskContent.width - maskWidth)*100 ) );
						
						// if we clicked the horizontal buttons
						if(_isHBtn1Down) // if we clicked button 1
						{
							__hScrollMin = 0;
							
							if(maskContent.x < __hScrollMin)
							{
								maskContent.x += _btnScrollSpeed;
								
								(maskContent.x > __hScrollMin) ? maskContent.x = __hScrollMin : maskContent.x;
							}
						}
						else if(_isHBtn2Down) // if we clicked button 2
						{
							__hScrollMax = maskContent.width - maskWidth;
							
							if(maskContent.x > - (__hScrollMax))
							{
								maskContent.x -= _btnScrollSpeed;
								
								(maskContent.x < - (__hScrollMax)) ? maskContent.x = - (__hScrollMax) : maskContent.x;
							}
						}
					}
					// if we need horizontal and vertical buttons
					else if(_isVBtnOnly && _isHBtnOnly)
					{
						// set btn scroll y if it's not set
						if(!_isBtnScrollYSet)
						{
							if(_scrollManualY > 100 || _scrollManualY < 0 || _scrollManualY == 0)
							{
								_scrollManualY = 0;
								maskContent.y = 0;
								
								_isBtnScrollYSet = true;
							}
							else
							{
								// set __setContentY according to _scrollManualY
								__setContentY = (_scrollManualY/100)*(maskContent.height - maskHeight);
								maskContent.y =  - __setContentY;

								_isBtnScrollYSet = true;
							}
						}
						
						// set percentage
						_scrollManualY = - ( Math.round( maskContent.y/(maskContent.height - maskHeight)*100 ) );
						
						// if we clicked the vertical buttons
						if(_isVBtn1Down) // if we clicked button 1
						{
							__vScrollMin = 0;
							
							if(maskContent.y < __vScrollMin)
							{
								maskContent.y += _btnScrollSpeed;
								
								(maskContent.y > __vScrollMin) ? maskContent.y = __vScrollMin : maskContent.y;
							}
						}
						else if(_isVBtn2Down) // if we clicked button 2
						{
							__vScrollMax = maskContent.height - maskHeight;
							
							if(maskContent.y > - (__vScrollMax))
							{
								maskContent.y -= _btnScrollSpeed;
								
								(maskContent.y < - (__vScrollMax)) ? maskContent.y = - (__vScrollMax) : maskContent.y;
							}
						}
						
						
						// set btn scroll x if it's not set
						if(!_isBtnScrollXSet)
						{
							if(_scrollManualX > 100 || _scrollManualX < 0 || _scrollManualX == 0)
							{
								_scrollManualX = 0;
								maskContent.x = 0;
								
								_isBtnScrollXSet = true;
							}
							else
							{
								// set __setContentX according to _scrollManualX
								__setContentX = (_scrollManualX/100)*(maskContent.width - maskWidth);
								maskContent.x =  - __setContentX;

								_isBtnScrollXSet = true;
							}
						}
						
						// set percentage
						_scrollManualX = - ( Math.round( maskContent.x/(maskContent.width - maskWidth)*100 ) );
						
						// if we clicked the horizontal buttons
						if(_isHBtn1Down) // if we clicked button 1
						{
							__hScrollMin = 0;
							
							if(maskContent.x < __hScrollMin)
							{
								maskContent.x += _btnScrollSpeed;
								
								(maskContent.x > __hScrollMin) ? maskContent.x = __hScrollMin : maskContent.x;
							}
						}
						else if(_isHBtn2Down) // if we clicked button 2
						{
							__hScrollMax = maskContent.width - maskWidth;
							
							if(maskContent.x > - (__hScrollMax))
							{
								maskContent.x -= _btnScrollSpeed;
								
								(maskContent.x < - (__hScrollMax)) ? maskContent.x = - (__hScrollMax) : maskContent.x;
							}
						}
					}
				}
			}
			
			//if(_scrollBlurEffect){ maskContent.cacheAsBitmap = true };
			
			/*__contentAvailableH = maskContent.y - maskHeight
			
			_scrollPerc = _myVSlider.y/_scrollAvailableH;
			_contentPerc = maskContent.y/__contentAvailableH;
			
			maskContent.y = -(_scrollPerc*__contentAvailableH);*/
			//((maskHeight*_myVBg.height)/maskContent.height)*maskContent.height/_myVBg.height;
			//_contentPerc = maskContent.height-maskHeight*100;
			//maskContent.y = - _scrollPerc;
			//trace(-(_scrollPerc*__contentAvailableH));
			//_scrollTween = TweenMax.to(maskContent, 3, {bezier:[{x:0, y:317}], ease:Elastic.easeOut});
			//_scrollTarget = (_scrollPerc * (_scrollMax - _scrollMin)) + _scrollMin;
			//maskContent.y -= (maskContent.y - _scrollTarget) / _scrollEase;
			//var myTween:Tween = new Tween(maskContent, "y", Elastic.easeOut, 0, -50, 3, true);
			
			// NEW //
						/*_scrollPerc = (_myVSlider.y - _myVBg.y) / (_myVBg.height - _myVSlider.height);
						if(_scrollPerc < 0)
						{
							_scrollPerc = 0;
						}
						else if(_scrollPerc > 1)
						{
							_scrollPerc = 1;
						}
						_scrollTarget = (_scrollPerc * (_scrollMax - _scrollMin)) + _scrollMin;
						maskContent.y -= (maskContent.y - _scrollTarget)/ 5;*/
			// NEW END //
		}
		
		//**********************************************************************************
		// ***************************************************************** SETTER - GETTER
		//**********************************************************************************
		
		//==================================================================================
		// ================================================================= scroll setters
		//==================================================================================
		
		/**
		 * indicates the type of orientation.
		 * @default Orientation.AUTO
		 * @see com.doitflash.consts.Orientation
		 */
		public function get orientation():String
		{
			return _orientation;
		}
		/**
		 * @private
		 */
		public function set orientation(sc:String):void
		{
			if(sc != _orientation)
			{
				_orientation = sc;
				
				if(stage)setMoreSettings();
				
				_propSaver.orientation = _orientation; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar space from the content.
		 * @default 5
		 */
		public function get scrollSpace():Number
		{
			return _scrollSpace;
		}
		/**
		 * @private
		 */
		public function set scrollSpace(sc:Number):void
		{
			if(sc != _scrollSpace)
			{
				_scrollSpace = sc;
				
				if(stage)setMoreSettings();
				
				_propSaver.scrollSpace = _scrollSpace; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * it works only if orientation is set to <code>Orientation.AUTO</code>,
		 * if <code>true</code>, draws scrollbars(vertical/horizontal) even if we don't need them,
		 * if <code>false</code>, draws scrollbars only if we need them.
		 * @default false
		 * @see com.doitflash.consts.Orientation
		 */
		public function get drawDisabledScroll():Boolean
		{
			return _drawDisabledScroll;
		}
		/**
		 * @private
		 */
		public function set drawDisabledScroll(sc:Boolean):void
		{
			if(sc != _drawDisabledScroll)
			{
				_drawDisabledScroll = sc;
				
				if(stage)setMoreSettings();
				
				_propSaver.drawDisabledScroll = _drawDisabledScroll; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the type of scrollbar ease.
		 * @default Easing.Regular_easeOut
		 * @see com.doitflash.consts.Easing
		 */
		public function get scrollEaseType():String
		{
			return _scrollEaseType;
		}
		/**
		 * @private
		 */
		public function set scrollEaseType(sc:String):void
		{
			if(sc != _scrollEaseType)
			{
				_scrollEaseType = sc;
				
				_easeType = EaseLookup.find(_scrollEaseType);
				_propSaver.scrollEaseType = _scrollEaseType; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the content scrolling ease animation delay.
		 * @default 1
		 */
		public function get scrollAniInterval():Number
		{
			return _scrollAniInterval;
		}
		/**
		 * @private
		 */
		public function set scrollAniInterval(sc:Number):void
		{
			if(sc != _scrollAniInterval)
			{
				_scrollAniInterval = sc;
				
				_propSaver.scrollAniInterval = _scrollAniInterval; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * if <code>true</code>, blurry scroll is available,
		 * if <code>false</code>, blurry scroll is unavailable.
		 * @default false
		 */
		public function get scrollBlurEffect():Boolean
		{
			return _scrollBlurEffect;
		}
		/**
		 * @private
		 */
		public function set scrollBlurEffect(sc:Boolean):void
		{
			if(sc != _scrollBlurEffect)
			{
				// because we have applied blur effect to the content, content cacheAsBitmap must be true to work properly
				(sc) ? maskContent.cacheAsBitmap = true : maskContent.cacheAsBitmap = false;
				
				_scrollBlurEffect = sc;
				
				_propSaver.scrollBlurEffect = _scrollBlurEffect; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the location of the vertical scrollbar, values are from 0 to 100.
		 * @default 0
		 */
		public function get scrollManualY():Number
		{
			return _scrollManualY;
		}
		/**
		 * @private
		 */
		public function set scrollManualY(sc:Number):void
		{
			if(sc != _scrollManualY)
			{
				_scrollManualY = sc;
				
				_isSliderYSet = false;
				_isBtnScrollYSet = false;
				
				// if this is not the first time we have set the _scrollManualY run the scroll bar animation when we set _scrollManualY
				if(!_isFirstTimeYSet){_runSliderYAni = true};
				
				_propSaver.scrollManualY = _scrollManualY; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the location of the horizontal scrollbar, values are from 0 to 100.
		 * @default 0
		 */
		public function get scrollManualX():Number
		{
			return _scrollManualX;
		}
		/**
		 * @private
		 */
		public function set scrollManualX(sc:Number):void
		{
			if(sc != _scrollManualX)
			{
				_scrollManualX = sc;
				
				_isSliderXSet = false;
				_isBtnScrollXSet = false;
				
				// if this is not the first time we have set the _scrollManualX run the scroll bar animation when we set _scrollManualX
				if(!_isFirstTimeXSet){_runSliderXAni = true};
				
				_propSaver.scrollManualX = _scrollManualX; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the mouse wheel speed when scrolling the content.
		 * @default 0
		 */
		public function get mouseWheelSpeed():Number
		{
			return _mouseWheelSpeed;
		}
		/**
		 * @private
		 */
		public function set mouseWheelSpeed(sc:Number):void
		{
			if(sc != _mouseWheelSpeed)
			{
				_mouseWheelSpeed = sc;
				
				_propSaver.mouseWheelSpeed = _mouseWheelSpeed; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar width.
		 * @default 10
		 */
		public function get scrollBarWidth():Number
		{
			var __scrollBarWidth:Number;
			
			/*if (_vScrollHolder != null && _hScrollHolder == null)
			{
				__scrollBarWidth = _vScrollHolder.width;
			}
			else if (_hScrollHolder != null && _vScrollHolder == null)
			{
				__scrollBarWidth = _hScrollHolder.height;
			}
			else if (_hScrollHolder != null && _vScrollHolder != null)
			{
				__scrollBarWidth = _vScrollHolder.width;
			}
			else
			{
				__scrollBarWidth = 0;
			}*/
			
			__scrollBarWidth = Math.max(_sliderW, _bgW, _btnSize);
			
			return __scrollBarWidth;
		}
		
		//==================================================================================
		// ================================================================= bg setters
		//==================================================================================
		
			// effect
			
		/**
		 * indicates the type of scrollbar background roll over effect.
		 * @default EffectConst.COLOR
		 * @see EffectConst
		 */
		public function get bgEffectType():String
		{
			return _bgEffectType;
		}
		/**
		 * @private
		 */
		public function set bgEffectType(e:String):void
		{
			if(e != _bgEffectType)
			{
				_bgEffectType = e;
				if(stage)setBg();
				
				_propSaver.bgEffectType = _bgEffectType; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar background roll over effect color.
		 * @default 0xFFFFFF
		 */
		public function get bgEffectColor():uint
		{
			return _bgEffectColor;
		}
		/**
		 * @private
		 */
		public function set bgEffectColor(e:uint):void
		{
			if(e != _bgEffectColor)
			{
				_bgEffectColor = e;
				if(stage)setBg();
				
				_propSaver.bgEffectColor = _bgEffectColor; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar background roll over effect alpha.
		 * @default 1
		 */
		public function get bgEffectAlpha():Number
		{
			return _bgEffectAlpha;
		}
		/**
		 * @private
		 */
		public function set bgEffectAlpha(e:Number):void
		{
			if(e != _bgEffectAlpha)
			{
				_bgEffectAlpha = e;
				if(stage)setBg();
				
				_propSaver.bgEffectAlpha = _bgEffectAlpha; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar background roll over effect ease animation delay.
		 * @default 1
		 */
		public function get bgEffectAniInterval():Number
		{
			return _bgEffectAniInterval;
		}
		/**
		 * @private
		 */
		public function set bgEffectAniInterval(e:Number):void
		{
			if(e != _bgEffectAniInterval)
			{
				_bgEffectAniInterval = e;
				if(stage)setBg();
				
				_propSaver.bgEffectAniInterval = _bgEffectAniInterval; // pass the new value to the value of the object property
			}
		}
		
		
				// glow effect setter
		/**
		 * it works only if bgEffectType is set to <code>EffectConst.GLOW</code> or <code>EffectConst.COLOR_GLOW</code>,
		 * indicates the scrollbar background glow roll over effect blur.
		 * @default 3
		 * @see bgEffectType
		 * @see EffectConst
		 */
		public function get bgGlowBlur():Number
		{
			return _bgGlowBlur;
		}
		/**
		 * @private
		 */
		public function set bgGlowBlur(e:Number):void
		{
			if(e != _bgGlowBlur)
			{
				_bgGlowBlur = e;
				if(stage)setBg();
				
				_propSaver.bgGlowBlur = _bgGlowBlur; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * it works only if bgEffectType is set to <code>EffectConst.GLOW</code> or <code>EffectConst.COLOR_GLOW</code>,
		 * indicates the scrollbar background glow roll over effect strength.
		 * @default 1
		 * @see bgEffectType
		 * @see EffectConst
		 */
		public function get bgGlowStrength():Number
		{
			return _bgGlowStrength;
		}
		/**
		 * @private
		 */
		public function set bgGlowStrength(e:Number):void
		{
			if(e != _bgGlowStrength)
			{
				_bgGlowStrength = e;
				if(stage)setBg();
				
				_propSaver.bgGlowStrength = _bgGlowStrength; // pass the new value to the value of the object property
			}
		}
		
			// bg itself
		/**
		 * indicates the scrollbar background curve.
		 * @default 0
		 */
		public function get bgCurve():Number
		{
			return _bgCurve;
		}
		/**
		 * @private
		 */
		public function set bgCurve(bg:Number):void
		{
			if(bg != _bgCurve)
			{
				_bgCurve = bg;
				if(stage)setBg();
				
				_propSaver.bgCurve = _bgCurve; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar background width.
		 * @default 10
		 */
		public function get bgW():Number
		{
			return _bgW;
		}
		/**
		 * @private
		 */
		public function set bgW(bg:Number):void
		{
			if(bg != _bgW)
			{
				_bgW = bg;
				
				if(stage)
				{
					setMainSettings();
					setBg();
					setSlider();
					setBtn();
				}
				
				_propSaver.bgW = _bgW; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar background color.
		 * @default 0xCCCCCC
		 */
		public function get bgColor():uint
		{
			return _bgColor;
		}
		/**
		 * @private
		 */
		public function set bgColor(bg:uint):void
		{
			if(bg != _bgColor)
			{
				_bgColor = bg;
				if(stage)setBg();
				
				_propSaver.bgColor = _bgColor; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar background alpha.
		 * @default .5
		 */
		public function get bgAlpha():Number
		{
			return _bgAlpha;
		}
		/**
		 * @private
		 */
		public function set bgAlpha(bg:Number):void
		{
			if(bg != _bgAlpha)
			{
				_bgAlpha = bg;
				if(stage)setBg();
				
				_propSaver.bgAlpha = _bgAlpha; // pass the new value to the value of the object property
			}
		}
		
		//==================================================================================
		// ================================================================= slider setters
		//==================================================================================
		
			// effect
		/**
		 * indicates the type of scrollbar slider roll over effect.
		 * @default EffectConst.COLOR
		 * @see EffectConst
		 */
		public function get sliderEffectType():String
		{
			return _sliderEffectType;
		}
		/**
		 * @private
		 */
		public function set sliderEffectType(e:String):void
		{
			if(e != _sliderEffectType)
			{
				_sliderEffectType = e;
				if(stage)setSlider();
				
				_propSaver.sliderEffectType = _sliderEffectType; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar slider roll over effect color.
		 * @default 0xFFFFFF
		 */
		public function get sliderEffectColor():uint
		{
			return _sliderEffectColor;
		}
		/**
		 * @private
		 */
		public function set sliderEffectColor(e:uint):void
		{
			if(e != _sliderEffectColor)
			{
				_sliderEffectColor = e;
				if(stage)setSlider();
				
				_propSaver.sliderEffectColor = _sliderEffectColor; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar slider roll over effect alpha.
		 * @default 1
		 */
		public function get sliderEffectAlpha():Number
		{
			return _sliderEffectAlpha;
		}
		/**
		 * @private
		 */
		public function set sliderEffectAlpha(e:Number):void
		{
			if(e != _sliderEffectAlpha)
			{
				_sliderEffectAlpha = e;
				if(stage)setSlider();
				
				_propSaver.sliderEffectAlpha = _sliderEffectAlpha; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar slider roll over effect ease animation delay.
		 * @default 1
		 */
		public function get sliderEffectAniInterval():Number
		{
			return _sliderEffectAniInterval;
		}
		/**
		 * @private
		 */
		public function set sliderEffectAniInterval(e:Number):void
		{
			if(e != _sliderEffectAniInterval)
			{
				_sliderEffectAniInterval = e;
				if(stage)setSlider();
				
				_propSaver.sliderEffectAniInterval = _sliderEffectAniInterval; // pass the new value to the value of the object property
			}
		}
		
		
				// glow effect setter
		/**
		 * it works only if sliderEffectType is set to <code>EffectConst.GLOW</code> or <code>EffectConst.COLOR_GLOW</code>,
		 * indicates the scrollbar slider glow roll over effect blur.
		 * @default 3
		 * @see sliderEffectType
		 * @see EffectConst
		 */
		public function get sliderGlowBlur():Number
		{
			return _sliderGlowBlur;
		}
		/**
		 * @private
		 */
		public function set sliderGlowBlur(e:Number):void
		{
			if(e != _sliderGlowBlur)
			{
				_sliderGlowBlur = e;
				if(stage)setSlider();
				
				_propSaver.sliderGlowBlur = _sliderGlowBlur; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * it works only if sliderEffectType is set to <code>EffectConst.GLOW</code> or <code>EffectConst.COLOR_GLOW</code>,
		 * indicates the scrollbar slider glow roll over effect strength.
		 * @default 1
		 * @see sliderEffectType
		 * @see EffectConst
		 */
		public function get sliderGlowStrength():Number
		{
			return _sliderGlowStrength;
		}
		/**
		 * @private
		 */
		public function set sliderGlowStrength(e:Number):void
		{
			if(e != _sliderGlowStrength)
			{
				_sliderGlowStrength = e;
				if(stage)setSlider();
				
				_propSaver.sliderGlowStrength = _sliderGlowStrength; // pass the new value to the value of the object property
			}
		}
		
			// slider itself
		/**
		 * indicates the scrollbar slider curve.
		 * @default 0
		 */
		public function get sliderCurve():Number
		{
			return _sliderCurve;
		}
		/**
		 * @private
		 */
		public function set sliderCurve(s:Number):void
		{
			if(s != _sliderCurve)
			{
				_sliderCurve = s;
				if(stage)setSlider();
				
				_propSaver.sliderCurve = _sliderCurve; // pass the new value to the value of the object property
			}
			
		}
		
		/**
		 * indicates the scrollbar slider width.
		 * @default 10
		 */
		public function get sliderW():Number
		{
			return _sliderW;
		}
		/**
		 * @private
		 */
		public function set sliderW(s:Number):void
		{
			if(s != _sliderW)
			{
				_sliderW = s;
				
				if(stage)
				{
					setMainSettings();
					setBg();
					setSlider();
					setBtn();
				}
				
				_propSaver.sliderW = _sliderW; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar slider height, is set to 0 slider height will be automatic according to content.
		 * @default 0
		 */
		public function get sliderH():Number
		{
			return _sliderH;
		}
		/**
		 * @private
		 */
		public function set sliderH(s:Number):void
		{
			if(s != _sliderH)
			{
				_sliderH = s;
				
				_isSliderYSet = false;
				_isSliderXSet = false;
				
				if(stage)setSlider();
				
				_propSaver.sliderH = _sliderH; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar slider color.
		 * @default 0xCCCCCC
		 */
		public function get sliderColor():uint
		{
			return _sliderColor;
		}
		/**
		 * @private
		 */
		public function set sliderColor(s:uint):void
		{
			if(s != _sliderColor)
			{
				_sliderColor = s;
				if(stage)setSlider();
				
				_propSaver.sliderColor = _sliderColor; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar slider alpha.
		 * @default 1
		 */
		public function get sliderAlpha():Number
		{
			return _sliderAlpha;
		}
		/**
		 * @private
		 */
		public function set sliderAlpha(s:Number):void
		{
			if(s != _sliderAlpha)
			{
				_sliderAlpha = s;
				if(stage)setSlider();
				
				_propSaver.sliderAlpha = _sliderAlpha; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar slider space from scrollbar background.
		 * @default 0
		 */
		public function get sliderSpace():Number
		{
			return _sliderSpace;
		}
		/**
		 * @private
		 */
		public function set sliderSpace(s:Number):void
		{
			if(s != _sliderSpace)
			{
				_sliderSpace = s;
				
				_isSliderYSet = false;
				_isSliderXSet = false;
				
				if(stage)setSlider();
				
				_propSaver.sliderSpace = _sliderSpace; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the slider scrolling ease animation delay,
		 * (slider animation runs when scrollbar background was clicked to get to the point that mouse is pointing to).
		 * @default .5
		 */
		public function get sliderAniInterval():Number
		{
			return _sliderAniInterval;
		}
		/**
		 * @private
		 */
		public function set sliderAniInterval(s:Number):void
		{
			if(s != _sliderAniInterval)
			{
				_sliderAniInterval = s;
				
				_propSaver.sliderAniInterval = _sliderAniInterval; // pass the new value to the value of the object property
			}
		}
		
		//==================================================================================
		// ================================================================= btn setters
		//==================================================================================
		
			// effect
		/**
		 * indicates the type of scrollbar buttons roll over effect.
		 * @default EffectConst.COLOR
		 * @see EffectConst
		 */
		public function get btnEffectType():String
		{
			return _btnEffectType;
		}
		/**
		 * @private
		 */
		public function set btnEffectType(e:String):void
		{
			if(e != _btnEffectType)
			{
				_btnEffectType = e;
				if(stage)setBtn();
				
				_propSaver.btnEffectType = _btnEffectType; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar buttons roll over effect color.
		 * @default 0xFFFFFF
		 */
		public function get btnEffectColor():uint
		{
			return _btnEffectColor;
		}
		/**
		 * @private
		 */
		public function set btnEffectColor(e:uint):void
		{
			if(e != _btnEffectColor)
			{
				_btnEffectColor = e;
				if(stage)setBtn();
				
				_propSaver.btnEffectColor = _btnEffectColor; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar buttons roll over effect alpha.
		 * @default 1
		 */
		public function get btnEffectAlpha():Number
		{
			return _btnEffectAlpha;
		}
		/**
		 * @private
		 */
		public function set btnEffectAlpha(e:Number):void
		{
			if(e != _btnEffectAlpha)
			{
				_btnEffectAlpha = e;
				if(stage)setBtn();
				
				_propSaver.btnEffectAlpha = _btnEffectAlpha; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar buttons roll over effect ease animation delay.
		 * @default 1
		 */
		public function get btnEffectAniInterval():Number
		{
			return _btnEffectAniInterval;
		}
		/**
		 * @private
		 */
		public function set btnEffectAniInterval(e:Number):void
		{
			if(e != _btnEffectAniInterval)
			{
				_btnEffectAniInterval = e;
				if(stage)setBtn();
				
				_propSaver.btnEffectAniInterval = _btnEffectAniInterval; // pass the new value to the value of the object property
			}
		}
		
		
				// glow effect setter
		/**
		 * it works only if btnEffectType is set to <code>EffectConst.GLOW</code> or <code>EffectConst.COLOR_GLOW</code>,
		 * indicates the scrollbar buttons glow roll over effect blur.
		 * @default 3
		 * @see btnEffectType
		 * @see EffectConst
		 */
		public function get btnGlowBlur():Number
		{
			return _btnGlowBlur;
		}
		/**
		 * @private
		 */
		public function set btnGlowBlur(e:Number):void
		{
			if(e != _btnGlowBlur)
			{
				_btnGlowBlur = e;
				if(stage)setBtn();
				
				_propSaver.btnGlowBlur = _btnGlowBlur; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * it works only if btnEffectType is set to <code>EffectConst.GLOW</code> or <code>EffectConst.COLOR_GLOW</code>,
		 * indicates the scrollbar buttons glow roll over effect strength.
		 * @default 1
		 * @see btnEffectType
		 * @see EffectConst
		 */
		public function get btnGlowStrength():Number
		{
			return _btnGlowStrength;
		}
		/**
		 * @private
		 */
		public function set btnGlowStrength(e:Number):void
		{
			if(e != _btnGlowStrength)
			{
				_btnGlowStrength = e;
				if(stage)setBtn();
				
				_propSaver.btnGlowStrength = _btnGlowStrength; // pass the new value to the value of the object property
			}
		}
		
		
			// btn itself
		/**
		 * indicates the  the type of scrollbar buttons layout.
		 * @default RegSimpleConst.TRIANGLE
		 * @see RegSimpleConst
		 */
		public function get btnLayout():String
		{
			return _btnLayout;
		}
		/**
		 * @private
		 */
		public function set btnLayout(b:String):void
		{
			if(b != _btnLayout)
			{
				_btnLayout = b;
				if(stage)setBtn();
				
				_propSaver.btnLayout = _btnLayout; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar buttons size, if set to 0 buttons won't be appeared.
		 * @default 10
		 */
		public function get btnSize():Number
		{
			return _btnSize;
		}
		/**
		 * @private
		 */
		public function set btnSize(b:Number):void
		{
			if(b != _btnSize)
			{
				_btnSize = b;
				if(stage)setMoreSettings();
				
				_propSaver.btnSize = _btnSize; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar buttons color.
		 * @default 0x666666
		 */
		public function get btnColor():uint
		{
			return _btnColor;
		}
		/**
		 * @private
		 */
		public function set btnColor(b:uint):void
		{
			if(b != _btnColor)
			{
				_btnColor = b;
				if(stage)setBtn();
				
				_propSaver.btnColor = _btnColor; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar buttons alpha.
		 * @default 1
		 */
		public function get btnAlpha():Number
		{
			return _btnAlpha;
		}
		/**
		 * @private
		 */
		public function set btnAlpha(b:Number):void
		{
			if(b != _btnAlpha)
			{
				_btnAlpha = b;
				if(stage)setBtn();
				
				_propSaver.btnAlpha = _btnAlpha; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar buttons space from the scrollbar background.
		 * @default 2
		 */
		public function get btnSpace():Number
		{
			return _btnSpace;
		}
		/**
		 * @private
		 */
		public function set btnSpace(b:Number):void
		{
			if(b != _btnSpace)
			{
				_btnSpace = b;
				
				if(stage)
				{
					setMainSettings();
					checkScrollSettings();
				}
				
				_propSaver.btnSpace = _btnSpace; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the scrollbar buttons scroll speed when they are clicked.
		 * @default 2
		 */
		public function get btnScrollSpeed():Number
		{
			return _btnScrollSpeed;
		}
		/**
		 * @private
		 */
		public function set btnScrollSpeed(b:Number):void
		{
			if(b != _btnScrollSpeed)
			{
				_btnScrollSpeed = b;
				
				_propSaver.btnScrollSpeed = _btnScrollSpeed; // pass the new value to the value of the object property
			}
		}
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
	}
}