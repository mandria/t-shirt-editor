package com.doitflash.utils.scroll
{
////////////////////////////////////// import classes
	import flash.display.Sprite;
	import flash.display.Graphics;
	
	/**
	 * @private
	 * @author Ali Tavakoli
	 */
	public class RegSimpleTriangleBtn extends Buttons
	{
////////////////////////////////////// properties
		private var _myBtn:Sprite = new Sprite();
		
////////////////////////////////////// constructor function
		public function RegSimpleTriangleBtn():void
		{
			// I'm ready
		}
////////////////////////////////////// methods
		public function draw():void
		{
			//_myBtn.graphics.lineStyle(1,0xff00ffff)
			_myBtn.graphics.beginFill(color, a);
			_myBtn.graphics.moveTo(size/2, 0);
			_myBtn.graphics.lineTo(size, size);
			_myBtn.graphics.lineTo(0, size);
			_myBtn.graphics.lineTo(size/2, 0);
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