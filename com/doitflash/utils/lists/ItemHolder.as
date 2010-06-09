package com.doitflash.utils.lists
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Hadi Tavakoli
	 */
	public class ItemHolder extends Sprite 
	{
		private var _id:int;
		private var _index:int;
		
		private var _width:Number=0;
		private var _height:Number=0;
		
		private var _content:*;
		private var _body:Sprite;
		
		public function ItemHolder():void
		{
			_body = new Sprite();
			this.addChild(_body);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter

		public function get id():int
		{
			return _id;
		}
		
		public function set id(a:int):void
		{
			_id = a;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(a:int):void
		{
			_index = a;
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function get height():Number
		{
			return _height;
		}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		public function addContent(a:DisplayObject):void
		{
			_content = a;
			this.addEventListener(Event.ENTER_FRAME, saveContentSize);
			_body.addChild(a);
		}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected functions

		

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private functions

		private function onStageRemove(e:Event):void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			
		}
		
		private function onStageAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onStageAdded);
		}
		
		private function saveContentSize(e:Event):void
		{
			_width = _content.width;
			_height = _content.height;
		}
	}
	
}