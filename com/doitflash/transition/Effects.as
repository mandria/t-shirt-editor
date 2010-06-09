package com.doitflash.transition
{
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import com.doitflash.events.TransitionEvent;
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	import com.greensock.easing.*;
	import com.doitflash.consts.Ease;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 4/20/2010 9:29 PMs
	 */
	public class Effects extends EventDispatcher
	{
		private var _duration:Number = .5;
		
		protected var _btm1:Bitmap;
		protected var _btm2:Bitmap;
		
		private var _menuEase:String = Ease.Quart_easeInOut;
		
		/**
		 * Constructor function
		 */
		public function Effects():void
		{
			com.greensock.easing.Bounce;
			com.greensock.easing.Back;
			com.greensock.easing.Quad;
			com.greensock.easing.Quint;
			com.greensock.easing.Quart;
			com.greensock.easing.Strong;
			com.greensock.easing.Sine;
			com.greensock.easing.Expo;
			com.greensock.easing.Elastic;
			com.greensock.easing.Cubic;
			com.greensock.easing.Circ;
			com.greensock.easing.Linear;
		}
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// getter - setter

		public function get duration():Number
		{
			return _duration;
		}
		
		public function set duration(a:Number):void
		{
			_duration = a;
		}
		
		public function get getEase():String
		{
			return _menuEase;
		}
		
		/**
		 * Indicates the ease type of the animation. NOTE: do not use Ease.Regular_easeOut , anything else is fine.
		 * 
		 * @see	com.doitflash.consts.Ease
		 */
		public function set setEase(a:String):void
		{
			_menuEase = a;
		}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		public function bitmaps($btm1:Bitmap, $btm2:Bitmap):void
		{
			// save the bitmaps
			_btm1 = $btm1;
			_btm2 = $btm2;
		}
		
		public function run():void
		{
			_btm1.alpha = 0;
			_btm2.alpha = 1;
			onTransDone();
		}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected Functions

		protected function easeFunction($easeString:String):Function
		{
			var currClassString:String = "";
			var currFuncString:String = "";
			var isLookingForClass:Boolean = true;
			
			for (var i:int = 0; i < $easeString.length; i++ )
			{
				if ($easeString.charAt(i) != "_")
				{
					if (isLookingForClass)
					{
						currClassString += $easeString.charAt(i);
					}
					else
					{
						currFuncString += $easeString.charAt(i);
					}
				}
				else
				{
					isLookingForClass = false;
				}
			}
			
			var thisClass:Class = getDefinitionByName("com.greensock.easing." + currClassString) as Class;
			return thisClass[currFuncString];
		}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private Functions

		private function onTransDone(e:TweenEvent=null):void
		{
			this.dispatchEvent(new TransitionEvent(TransitionEvent.COMPLETE));
		}
	}
	
}