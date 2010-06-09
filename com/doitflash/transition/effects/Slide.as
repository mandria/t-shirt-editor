package com.doitflash.transition.effects
{
	import com.doitflash.events.TransitionEvent;
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	import com.doitflash.transition.Effects;
	import com.doitflash.consts.Orientation;
	import com.doitflash.consts.Direction;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 4/20/2010 9:29 PMs
	 */
	public class Slide extends Effects
	{
		private var _orientation:String = Orientation.VERTICAL;
		private var _direction:String = Direction.TOP_TO_BOTTOM;
		private var _vSpace:Number = 15;
		private var _hSpace:Number = 35;
		
		/**
		 * Constructor function
		 */
		public function Slide():void
		{
			
		}
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// getter - setter

		public function set orientation(a:String):void
		{
			_orientation = a;
		}
		
		public function set direction(a:String):void
		{
			_direction = a;
		}
		
		public function set vSpace(a:Number):void
		{
			_vSpace = a;
		}
		
		public function set hSpace(a:Number):void
		{
			_hSpace = a;
		}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		override public function run():void
		{
			var _x:Number = 0;
			var _y:Number = 0;
			
			if (_orientation == Orientation.VERTICAL || _orientation == Orientation.AUTO)
			{
				if (_direction == Direction.TOP_TO_BOTTOM)
				{
					_y = _vSpace;
					this._btm2.y = -_vSpace;
				}
				else
				{
					_y = -_vSpace;
					this._btm2.y = _vSpace;
				}
			}
			else
			{
				if (_direction == Direction.LEFT_TO_RIGHT)
				{
					_x = _hSpace;
					this._btm2.x = -_hSpace;
				}
				else
				{
					_x = -_hSpace;
					this._btm2.x = _hSpace;
				}
			}
			
			
			var tween1:TweenMax = TweenMax.to(this._btm1, this.duration, { alpha:0, x:_x, y:_y, ease:this.easeFunction(this.getEase) } );
			
			
			var tween2:TweenMax = TweenMax.to(this._btm2, this.duration, { alpha:1, x:0, y:0, ease:this.easeFunction(this.getEase), onComplete:onTweenDone } );
			//tween2.addEventListener(TweenEvent.COMPLETE, onTweenDone);
		}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected Functions

		

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private Functions

		private function onTweenDone(e:TweenEvent=null):void
		{
			this.dispatchEvent(new TransitionEvent(TransitionEvent.COMPLETE));
		}
	}
	
}