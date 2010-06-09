package com.doitflash.utils.button
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import com.doitflash.events.ButtonEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	/**
	 * 
	 * @author Hadi Tavakoli
	 */
	public class ImgBtn extends Btn
	{
		private var _upLayer:Sprite;
		private var _overLayer:Sprite;
		private var _downLayer:Sprite;
		private var _hitLayer:Sprite;
		
		private var _width:Number=5;
		private var _height:Number=5;
		
		private var _isOver:Boolean = false;
		
		public function ImgBtn():void
		{
			_upLayer = new Sprite();
			defaultSkin(_upLayer, 0x000000);
			this.addChild(_upLayer);
			
			_overLayer = new Sprite();
			defaultSkin(_overLayer, 0x444444);
			_overLayer.visible = false;
			this.addChild(_overLayer);
			
			_downLayer = new Sprite();
			defaultSkin(_downLayer, 0x666666);
			_downLayer.visible = false;
			this.addChild(_downLayer);
			
			_hitLayer = new Sprite();
			defaultSkin(_hitLayer, 0x666666);
			this.hit = _hitLayer;
			
			setDimension();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(a:Number):void
		{
			_width = a;
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(a:Number):void
		{
			_height = a;
		}
		
		private function defaultSkin($target:Sprite, $color:uint):void
		{
			$target.graphics.clear();
			$target.graphics.beginFill($color, 1);
			$target.graphics.drawRect(0, 0, 20, 10);
			$target.graphics.endFill();
		}
		
		private function setDimension():void
		{
			_width = Math.max(_upLayer.width, _overLayer.width, _downLayer.width);
			_height = Math.max(_upLayer.height, _overLayer.height, _downLayer.height);
		}
		
		/**
		 * sets three external image files for three button status.
		 * @param	$up		must be specified, png, jpeg, jpg, gif are supported
		 * @param	$over	if not set, it will use the image from $up
		 * @param	$down	if not set, it will use the image from $up
		 */
		public function skin($up:String, $over:String=null, $down:String=null, $hit:String=null):void
		{
			if($up != null)
			{
				// start loading the skinds
				toLoad($up, _upLayer);
				
				($over != null)? toLoad($over, _overLayer): toLoad($up, _overLayer);
				($down != null)? toLoad($down, _downLayer): toLoad($up, _downLayer);
				($hit != null)? toLoad($hit, null, true): toLoad($up, null, true);
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
		
		/**
		 * @private
		 */
		public function toDefault():void
		{
			_overLayer.visible = false;
			_upLayer.visible = true;
			_downLayer.visible = false;
		}
		
		/**
		 * @private
		 */
		public function toSelect():void
		{
			_overLayer.visible = false;
			_upLayer.visible = false;
			_downLayer.visible = true;
		}
		
		private function toLoad($path:String, $target:Sprite, $addListener:Boolean=false):void
		{
			if($target != null)$target.graphics.clear();
			
			var loader:Loader = new Loader();
			if($addListener)loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest($path))
			if($target != null)$target.addChild(loader);
		}
		
		private function onComplete(e:Event):void
		{
			_hitLayer.graphics.clear();
			_hitLayer.graphics.beginFill(0x000000, 0);
			_hitLayer.graphics.drawRect(0, 0, e.currentTarget.content.width, e.currentTarget.content.height);
			_hitLayer.graphics.endFill();
			
			this.hit = _hitLayer;
			
			setDimension();
			this.dispatchEvent(new ButtonEvent(ButtonEvent.SKIN_LOADED));
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