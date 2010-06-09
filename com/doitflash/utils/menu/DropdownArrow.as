package com.doitflash.utils.menu
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.doitflash.utils.button.ImgBtn;
	import com.doitflash.events.ButtonEvent;
	
	/**
	 * DropdownArrow class loads the arrow image of the head.
	 * 
	 * @author Hadi Tavakoli - 4/9/2010 5:06 PM
	 */
	public class DropdownArrow extends Sprite 
	{
		public static const COMPLETE:String = "imgLoadCompleted";
		
		private var _path:String;
		private var _imagesPath:Array;
		private var _btn:ImgBtn;
		
		private var _isOpen:Boolean = false;
		
		public function DropdownArrow($arrowPath:String=null, $arrowImagesPath:Array=null):void
		{
			_path = $arrowPath;
			_imagesPath = $arrowImagesPath;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onStageRemoved);
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter

		

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		public function over(e:MouseEvent):void
		{
			if(!_isOpen)_btn.callOver(e);
		}
		
		public function out(e:MouseEvent):void
		{
			if(!_isOpen)_btn.callOut(e);
		}
		
		public function open():void
		{
			_isOpen = true;
			_btn.toSelect();
		}
		
		public function close():void
		{
			_isOpen = false;
			_btn.toDefault();
		}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected

		

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private

		private function onStageRemoved(e:Event):void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			
			
		}
		
		private function onStageAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			
			// load the image
			toLoadImg();
		}
		
		private function toLoadImg():void
		{
			var up:String = _path;
			var over:String = _path;
			var down:String = _path;
			
			if (_imagesPath)
			{
				up = _imagesPath[0];
				over = _imagesPath[1];
				down = _imagesPath[2];
			}
			
			_btn = new ImgBtn();
			_btn.activated = false;
			_btn.addEventListener(ButtonEvent.SKIN_LOADED, onComplete);
			_btn.skin(up, over, down, up);
			this.addChild(_btn);
		}
		
		private function onComplete(e:ButtonEvent):void
		{
			_btn.toDefault();
			this.dispatchEvent(new Event(DropdownArrow.COMPLETE));
		}
	}
	
}