package com.doitflash.utils.scroll
{
////////////////////////////////////// import classes
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.doitflash.events.ScrollEvent;
	
	import com.greensock.plugins.*;
	import com.greensock.*; 
	import com.greensock.events.*;
	import com.greensock.easing.*;
	//import com.greensock.easing.EaseLookup;
	
	/**
	 * @private
	 * @author Ali Tavakoli
	 */
	public class Buttons extends Sprite
	{
////////////////////////////////////// properties
		private var _curve:Number;
		private var _width:Number;
		private var _height:Number;
		private var _size:Number;
		private var _color:uint;
		private var _alpha:Number;
		
		// effects variables
		private var _target:*;
		
		private var _tween:TweenMax;
		//private var _isButtonDownAlready:Boolean;
		
			// input variables
		private var _effectType:String;
		private var _effectColor:uint;
		private var _effectAlpha:Number;
		private var _effectAniInterval:Number;
		
		private var _glowBlur:Number;
		private var _glowStrength:Number;
		
////////////////////////////////////// constructor function
		public function Buttons():void
		{
			TweenPlugin.activate([ColorTransformPlugin]);
			
			// set default variables
			//_isButtonDownAlready = false;
			
			_effectType = EffectConst.COLOR;
			_effectColor = 0xFFFFFF;
			_effectAlpha = 1;
			_effectAniInterval = .5;
			
			_glowBlur = 5;
			_glowStrength = 1;
			
			
			// let's add listeners
			addListeners();
		}
////////////////////////////////////// methods
		// here is the addListeners function
		private function addListeners():void
		{
			// let's add buttons MouseEvent
			this.addEventListener(MouseEvent.ROLL_OVER, onOver, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		// here is the onOver function
		protected function onOver(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseIsOut);
			
			if(!e.buttonDown)
			{
				//if(!_isButtonDownAlready) // if our mouse is dawn already and going over an other button, the roll over effect should not work 
				//{
					
					
					// see what's the effect type to apply it
					switch(_effectType)
					{
						// COLOR effect
						case EffectConst.COLOR:
							
							_tween = TweenMax.to(e.currentTarget, _effectAniInterval, {colorTransform:{tint:_effectColor, tintAmount:_effectAlpha}});
						break;
						
						// GLOW effect
						case EffectConst.GLOW:
							
							_tween = TweenMax.to(e.currentTarget, _effectAniInterval, {glowFilter:{color:_effectColor, alpha:_effectAlpha, blurX:_glowBlur, blurY:_glowBlur, strength:_glowStrength}});
						break;
						
						// COLOR_GLOW effect
						case EffectConst.COLOR_GLOW:
							
							_tween = TweenMax.to(e.currentTarget, _effectAniInterval, {glowFilter:{color:_effectColor, alpha:_effectAlpha, blurX:_glowBlur, blurY:_glowBlur, strength:_glowStrength}, colorTransform:{tint:_effectColor, tintAmount:_effectAlpha}});
						break;
					}
					
					//this.dispatchEvent(new ScrollEvent(ScrollEvent.ROLL_OVER));
				//}
			}
		}
		// here is the onOut function
		protected function onOut(e:MouseEvent):void
		{
			//if(!_isButtonDownAlready) // if our mouse is dawn already and going out from an other button, the roll out effect should not work 
			//{
				// if button is not down revert the effect
				if(!e.buttonDown)
				{
					// see what's the effect type to revert it
					switch(_effectType)
					{
						// COLOR effect
						case EffectConst.COLOR:
							
							_tween = TweenMax.to(e.currentTarget, _effectAniInterval, {colorTransform:{tint:_effectColor, tintAmount:0}});
						break;
						
						// GLOW effect
						case EffectConst.GLOW:
							
							_tween = TweenMax.to(e.currentTarget, _effectAniInterval, {glowFilter:{color:_effectColor, alpha:0, blurX:0, blurY:0, strength:0, remove:true}});
						break;
						
						// COLOR_GLOW effect
						case EffectConst.COLOR_GLOW:
							
							_tween = TweenMax.to(e.currentTarget, _effectAniInterval, {glowFilter:{color:_effectColor, alpha:0, blurX:0, blurY:0, strength:0, remove:true}, colorTransform:{tint:_effectColor, tintAmount:0}});
						break;
					}
					
					// see when the animation isfinished
					_tween.addEventListener(TweenEvent.COMPLETE, onTweenComplete);
				}
				// else add MOUSE_UP listener to do mouseIsOut function
				else
				{
					//_isButtonDownAlready = true;
					_target =  e.currentTarget;
					stage.addEventListener(MouseEvent.MOUSE_UP, mouseIsOut);
				}
			//}
			
			//this.dispatchEvent(new ScrollEvent(ScrollEvent.ROLL_OUT));
		}
		// mouseIsOut function
		private function mouseIsOut(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseIsOut);
			//_isButtonDownAlready = false;
			
			// see what's the effect type to revert it
			switch(_effectType)
			{
				// COLOR effect
				case EffectConst.COLOR:
				
					_tween = TweenMax.to(_target, _effectAniInterval, {colorTransform:{tint:_effectColor, tintAmount:0}});
				break;
				
				// GLOW effect
				case EffectConst.GLOW:
					
					_tween = TweenMax.to(_target, _effectAniInterval, {glowFilter:{color:_effectColor, alpha:0, blurX:0, blurY:0, strength:0, remove:true}});
				break;
				
				// COLOR_GLOW effect
				case EffectConst.COLOR_GLOW:
					
					_tween = TweenMax.to(_target, _effectAniInterval, {glowFilter:{color:_effectColor, alpha:0, blurX:0, blurY:0, strength:0, remove:true}, colorTransform:{tint:_effectColor, tintAmount:0}});
				break;
			}
			
			// see when the animation is finished
			_tween.addEventListener(TweenEvent.COMPLETE, onTweenComplete);
		}
		// onTweenComplete function
		private function onTweenComplete(e:TweenEvent):void
		{
			_tween.removeEventListener(TweenEvent.COMPLETE, onTweenComplete);
			
			this.dispatchEvent(new ScrollEvent(ScrollEvent.TWEEN_COMPLETE));
		}
		// here is the onClick function
		protected function onClick(e:MouseEvent):void
		{
			//this.dispatchEvent(new ScrollEvent(ScrollEvent.CLICK));
		}
		// here is the removeListeners function
		public function removeListeners():void
		{
			// let's remove buttons MouseEvent
			this.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseIsOut);
			this.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		// main setters and getters
		
			// set curve
		public function set curve(c:Number):void
		{
			_curve = c;
		}
		public function get curve():Number
		{
			return _curve;
		}
			// set width
		public function set w(w:Number):void
		{
			_width = w;
		}
		public function get w():Number
		{
			return _width;
		}
			// set height
		public function set h(h:Number):void
		{
			_height = h;
		}
		public function get h():Number
		{
			return _height;
		}
			// set size
		public function set size(s:Number):void
		{
			_size = s;
		}
		public function get size():Number
		{
			return _size;
		}
			// set color
		public function set color(c:uint):void
		{
			_color = c;
		}
		public function get color():uint
		{
			return _color;
		}
			// set alpha
		public function set a(a:Number):void
		{
			_alpha = a;
		}
		public function get a():Number
		{
			return _alpha;
		}
		
		// effect setters
		public function set effectType(e:String):void
		{
			_effectType = e;
		}
		public function set effectColor(e:uint):void
		{
			_effectColor = e;
		}
		public function set effectAlpha(e:Number):void
		{
			_effectAlpha = e;
		}
		public function set effectAniInterval(e:Number):void
		{
			_effectAniInterval = e;
		}
		
			// glow effect setter
		public function set glowBlur(e:Number):void
		{
			_glowBlur = e;
		}
		public function set glowStrength(e:Number):void
		{
			_glowStrength = e;
		}
		
//////////////////////////////////////
	}
}