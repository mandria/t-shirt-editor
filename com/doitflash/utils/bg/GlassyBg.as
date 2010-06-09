package com.doitflash.utils.bg
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.filters.BlurFilter;
	import com.doitflash.fl.motion.Color;
	
	/**
	 * @author Hadi Tavakoli
	 * @private
	 */
	public class GlassyBg extends Sprite 
	{
		private var _holder:*;
		
		private var _bgWidth:Number = 5;
		private var _bgHeight:Number = 5;
		private var _glassColor:uint;
		private var _glassAlpha:Number;
		private var _glassBlur:Number;
		private var _glassBlurQuality:Number;
		private var _backScene:DisplayObject;
		
		private var _curveTopLeft:Number = 0;
		private var _curveTopRight:Number = 0;
		private var _curveBottomLeft:Number = 0;
		private var _curveBottomRight:Number = 0;
		
		private var _bmd:BitmapData;
		private var _bitmap:Bitmap;
		
		private var _tx:Number = 0;
		private var _ty:Number = 0;
		
		private var _offSetX:Number = 0;
		private var _offSetY:Number = 0;
		
		/**
		 * Constructor function
		 */
		public function GlassyBg():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageHandeler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeHandeler);
			
			// add listener to keep the glass updated.
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
///////////////////////////////////////////////////////////////////////////// getter - setter
		
		public function set w(a:Number):void
		{
			if (_bgWidth != a) // make sure the value is updated
			{
				_bgWidth = a;
				setBmd();
			}
		}
		
		public function set h(a:Number):void
		{
			if (_bgHeight != a) // make sure the value is updated
			{
				_bgHeight = a;
				setBmd();
			}
		}
		
		public function set glassColor(a:uint):void
		{
			if (_glassColor != a) // make sure the value is updated
			{
				_glassColor = a;
				create();
			}
		}
		
		public function set glassAlpha(a:Number):void
		{
			if (_glassAlpha != a) // make sure the value is updated
			{
				_glassAlpha = a;
				create();
			}
		}
		
		public function set glassBlur(a:Number):void
		{
			if (_glassBlur != a)
			{
				_glassBlur = a;
				create();
			}
		}
		
		public function set glassBlurQuality(a:Number):void
		{
			if ( _glassBlurQuality != a)
			{
				_glassBlurQuality = a;
				create();
			}
		}
		
		public function set holder(a:*):void
		{
			_holder = a;
			create();
		}
		
		/*public function set offsetX(a:Number):void
		{
			if (_offSetX != a)
			{
				_offSetX = a;
				create();
			}
		}
		
		public function set offsetY(a:Number):void
		{
			if (_offSetY != a)
			{
				_offSetY = a;
				create();
			}
		}*/
		
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
			
			_backScene = this.stage;
			setBmd();
		}
		
		private function removeHandeler(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function setBmd():void
		{
			// empty any old bitmapData to save cpu
			//if (_bmd) _bmd.dispose();
			
			// set the new bitmapData with the new width and height
			_bmd = new BitmapData(_bgWidth, _bgHeight, true, 0x00000000);
			
			
			//if(_holder) update(_holder.x, _holder.y);
		}
		
		public function update(x:Number, y:Number):void
		{
			if (stage)
			{
				// calculate the offset
				toFindOffset(_holder);
				
				_holder.visible = false;
				_tx = -x - _offSetX;
				_ty = -y - _offSetY;
				create();
				_holder.visible = true;
				
				// reset the offset values
				_offSetX = 0;
				_offSetY = 0;
			}
		}
		
		private function toFindOffset($holder:*):void
		{
			var currDisplay:* = $holder;
			
			for (var i:int = 0; i < 20; i++)
			{
				currDisplay = currDisplay.parent;
				
				if (currDisplay != this.stage)
				{
					_offSetX += currDisplay.x;
					_offSetY += currDisplay.y;
				}
				else
				{
					// kill the loop operation
					return;
				}
			}
		}
		
		private function create():void
		{
			if (stage)
			{
				
				var matrix:Matrix = new Matrix(1, 0, 0, 1, _tx, _ty);
				
				var color:Color = new Color();
				color.tintColor = _glassColor;
				color.tintMultiplier = _glassAlpha;
				
				_bmd.draw(_backScene, matrix, color);
				_bmd.applyFilter(_bmd, _bmd.rect, new Point(0, 0), new BlurFilter(_glassBlur, _glassBlur, _glassBlurQuality));
				
				this.graphics.clear();
				this.graphics.beginBitmapFill(_bmd, null, true, true);
				this.graphics.drawRoundRectComplex(0, 0, _bgWidth, _bgHeight, _curveTopLeft, _curveTopRight, _curveBottomLeft, _curveBottomRight);
				this.graphics.endFill();
			}
		}
		
		private function enterFrame(e:Event):void
		{
			if (_holder)
			{
				update(_holder.x, _holder.y);
			}
		}
	}
	
}