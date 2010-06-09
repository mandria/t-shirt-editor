package com.doitflash.transition.effects
{
	import com.doitflash.events.TransitionEvent;
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	import com.doitflash.transition.Effects;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 4/20/2010 9:29 PMs
	 */
	public class Fade extends Effects
	{
		
		/**
		 * Constructor function
		 */
		public function Fade():void
		{
			
		}
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// getter - setter

		

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		override public function run():void
		{
			var tween1:TweenMax = TweenMax.to(this._btm1, this.duration, { alpha:0, ease:this.easeFunction(this.getEase) } );
			
			var tween2:TweenMax = TweenMax.to(this._btm2, this.duration, { alpha:1, ease:this.easeFunction(this.getEase) } );
			tween2.addEventListener(TweenEvent.COMPLETE, onTweenDone);
		}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected Functions

		

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private Functions

		private function onTweenDone(e:TweenEvent):void
		{
			this.dispatchEvent(new TransitionEvent(TransitionEvent.COMPLETE));
		}
	}
	
}