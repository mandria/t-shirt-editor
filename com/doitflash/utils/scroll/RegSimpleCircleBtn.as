package com.doitflash.utils.scroll
{
////////////////////////////////////// import classes
	import flash.display.Sprite;
	import flash.display.Graphics;
	
	/**
	 * @private
	 * @author Ali Tavakoli
	 */
	public class RegSimpleCircleBtn extends Buttons
	{
////////////////////////////////////// properties
		private var _myBtn:Sprite = new Sprite();
		
////////////////////////////////////// constructor function
		public function RegSimpleCircleBtn():void
		{
			// I'm ready
		}
////////////////////////////////////// methods
		public function draw():void
		{
			//_myBtn.graphics.lineStyle(1,0xff00ffff)
			_myBtn.graphics.beginFill(color, a);
			_myBtn.graphics.drawCircle(size/2, size/2, size/2);
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