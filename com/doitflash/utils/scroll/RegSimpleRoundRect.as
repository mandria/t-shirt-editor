package com.doitflash.utils.scroll
{
////////////////////////////////////// import classes
	import flash.display.Sprite;
	import flash.display.Graphics;
	
	/**
	 * @private
	 * @author Ali Tavakoli
	 */
	public class RegSimpleRoundRect extends Buttons
	{
////////////////////////////////////// properties
		private var _myBtn:Sprite = new Sprite();
////////////////////////////////////// constructor function
		public function RegSimpleRoundRect():void
		{
			// I'm ready
		}
////////////////////////////////////// methods
		public function draw():void
		{
			curve = Math.min(w, h, curve);
			
			//_myBtn.graphics.lineStyle(5, 0x0000FF, .5, false);
			_myBtn.graphics.beginFill(color, a);
			_myBtn.graphics.drawRoundRect(0, 0, w, h, curve);
			_myBtn.graphics.endFill();
			addChild(_myBtn);
		}
		
		public function clearShape():void
		{
			_myBtn.graphics.clear();
			removeChild(_myBtn);
		}
//////////////////////////////////////
	}
}