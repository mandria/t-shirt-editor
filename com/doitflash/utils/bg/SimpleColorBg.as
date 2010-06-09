package com.doitflash.utils.bg
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.myflashlab.classes.tools.bg.ComplexRectacgle;
	
	/**
	 * @author Hadi Tavakoli
	 * @private
	 */
	public class SimpleColorBg extends Sprite 
	{
		private var _bgWidth:Number;
		private var _bgHeight:Number;
		private var _simpleColor:uint;
		private var _strokeThickness:Number;
		private var _strokeColor:uint;
		
		private var _curveTopLeft:Number = 0;
		private var _curveTopRight:Number = 0;
		private var _curveBottomLeft:Number = 0;
		private var _curveBottomRight:Number = 0;
		
		/**
		 * Constructor function
		 */
		public function SimpleColorBg():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageHandeler);
			
		}
		
///////////////////////////////////////////////////////////////////////////// getter - setter
		
		public function set w(a:Number):void
		{
			if (_bgWidth != a) // make sure the value is updated
			{
				_bgWidth = a;
				create();
			}
		}
		
		public function set h(a:Number):void
		{
			if (_bgHeight != a) // make sure the value is updated
			{
				_bgHeight = a;
				create();
			}
		}
		
		public function set simpleColor(a:uint):void
		{
			if (_simpleColor != a) // make sure the value is updated
			{
				_simpleColor = a;
				create();
			}
		}
		
		public function set strokeThickness(a:Number):void
		{
			if (_strokeThickness != a)
			{
				_strokeThickness = a;
				create();
			}
		}
		
		public function set strokeColor(a:uint):void
		{
			if (_strokeColor != a)
			{
				_strokeColor = a;
				create();
			}
		}
		
///////////////////////////////////////////////////////////////////////////// methods

		public function curve($topLeft:Number=0, $topRight:Number=0, $bottomLeft:Number=0, $bottomRight:Number=0):void
		{
			_curveTopLeft = $topLeft;
			_curveTopRight = $topRight;
			_curveBottomLeft = $bottomLeft;
			_curveBottomRight = $bottomRight;
			
			create();
		}
		
///////////////////////////////////////////////////////////////////////////// private function
		
		private function stageHandeler(e:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, stageHandeler);
			
			create();
		}
		
		private function create():void
		{
			if (stage)
			{
				/*this.graphics.clear();
				this.graphics.beginFill(_simpleColor);
				this.graphics.drawRoundRectComplex(0, 0, _bgWidth, _bgHeight, _curveTopLeft, _curveTopRight, _curveBottomLeft, _curveBottomRight);
				this.graphics.endFill();*/
				
				cleanUp(this);
				
				var sp:Sprite = new ComplexRectacgle(_bgWidth, _bgHeight, _curveTopLeft, _curveTopRight, _curveBottomLeft, _curveBottomRight, _simpleColor, _simpleColor, _strokeThickness, _strokeColor);
				this.addChild(sp);
			}
		}
		
		private function cleanUp($target:Sprite):void
		{
			for (var i:int = 0; i < $target.numChildren; i++)
			{
				$target.removeChildAt(i);
			}
		}
	}
	
}