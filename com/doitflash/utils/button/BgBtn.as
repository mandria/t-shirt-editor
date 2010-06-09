package com.doitflash.utils.button
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import com.doitflash.events.ButtonEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import com.doitflash.utils.bg.Bg;
	import com.doitflash.utils.bg.BgType;
	import com.doitflash.utils.bg.BgConst;
	
	/**
	 * 
	 * @author Hadi Tavakoli - 4/10/2010 5:58 PM
	 */
	public class BgBtn extends Btn
	{
		private var _upLayer:Bg;
		private var _overLayer:Bg;
		private var _downLayer:Bg;
		private var _hitLayer:Sprite;
		
		private var _width:Number;
		private var _height:Number;
		
		private var _isOver:Boolean = false;
		
		public function BgBtn($width:Number, $height:Number):void
		{
			_width = $width;
			_height = $height;
			
			_hitLayer = new Sprite();
			_hitLayer.graphics.clear();
			_hitLayer.graphics.beginFill(0x000000, 1);
			_hitLayer.graphics.drawRect(0, 0, _width, _height);
			_hitLayer.graphics.endFill();
			this.hit = _hitLayer;
			
			_upLayer = new Bg();
			_upLayer.auto = false;
			_upLayer.w = _width-1;
			_upLayer.h = _height;
			this.addChild(_upLayer);
			
			_overLayer = new Bg();
			_overLayer.auto = false;
			_overLayer.w = _width-1;
			_overLayer.h = _height;
			_overLayer.visible = false;
			this.addChild(_overLayer);
			
			_downLayer = new Bg();
			_downLayer.auto = false;
			_downLayer.w = _width-1;
			_downLayer.h = _height;
			_downLayer.visible = false;
			this.addChild(_downLayer);
		}
		
		public function setUpSkin($type:String=null, $prop:Object=null):void
		{
			if ($type != null && $prop != null)
			{
				// set the type for the bg
				_upLayer.type = $type;
				
				// apply the properties
				for (var param:* in $prop)
				{
					try
					{
						_upLayer[param] = $prop[param];
					}
					catch (err:Error)
					{
						trace("There is no property named 'param' >> Class: com.doitflash.utils.button.BgBtn, Function: setUpSkin")
					}
				}
			}
		}
		
		public function setOverSkin($type:String=null, $prop:Object=null):void
		{
			if ($type != null && $prop != null)
			{
				// set the type for the bg
				_overLayer.type = $type;
				
				// apply the properties
				for (var param:* in $prop)
				{
					try
					{
						_overLayer[param] = $prop[param];
					}
					catch (err:Error)
					{
						trace("There is no property named 'param' >> Class: com.doitflash.utils.button.BgBtn, Function: setOverSkin")
					}
				}
			}
		}
		
		public function setDownSkin($type:String=null, $prop:Object=null):void
		{
			if ($type != null && $prop != null)
			{
				// set the type for the bg
				_downLayer.type = $type;
				
				// apply the properties
				for (var param:* in $prop)
				{
					try
					{
						_downLayer[param] = $prop[param];
					}
					catch (err:Error)
					{
						trace("There is no property named 'param' >> Class: com.doitflash.utils.button.BgBtn, Function: setDownSkin")
					}
				}
			}
		}
		
		/**
		 * @private
		 */
		public function callUp(e:MouseEvent):void
		{
			onBtnUp(e);
		}
		
		/**
		 * @private
		 */
		public function callOver(e:MouseEvent):void
		{
			onBtnOver(e);
		}
		
		/**
		 * @private
		 */
		public function callOut(e:MouseEvent):void
		{
			onBtnOut(e);
		}
		
		/**
		 * @private
		 */
		public function callDown(e:MouseEvent):void
		{
			onBtnDown(e);
		}
		
		override protected function onBtnOver(e:MouseEvent=null):void
		{
			_isOver = true;
			
			if (!e.buttonDown)
			{
				_overLayer.visible = true;
				_upLayer.visible = false;
				_downLayer.visible = false;
			}
		}
		
		override protected function onBtnOut(e:MouseEvent=null):void
		{
				_isOver = false;
				
				if (!e.buttonDown)
				{
					_overLayer.visible = false;
					_upLayer.visible = true;
					_downLayer.visible = false;
				}
			
		}
		
		override protected function onBtnDown(e:MouseEvent=null):void
		{
			_overLayer.visible = false;
			_upLayer.visible = false;
			_downLayer.visible = true;
		}
		
		override protected function onBtnUp(e:MouseEvent=null):void
		{
			if (_isOver)
			{
				onBtnOver(e);
			}
			else
			{
				onBtnOut(e);
			}
			
		}
		
		override protected function onBtnActive():void 
		{
			_isOver = false;
			_overLayer.visible = false;
			_upLayer.visible = true;
			_downLayer.visible = false;
		}
		
		override protected function onBtnInactive():void 
		{ 
			onBtnDown();
		}
	}
	
}