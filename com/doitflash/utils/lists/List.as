/*

	import com.doitflash.utils.lists.List;
	import com.doitflash.events.ListEvent;
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	
	var myList:List = new List();
	myList.addEventListener(ListEvent.RESIZE, onResize);
	myList.x = 400;
	myList.y = 300;
	myList.direction = Direction.LEFT_TO_RIGHT;
	myList.orientation = Orientation.VERTICAL;
	myList.space = 3;
	myList.speed = .3;
	this.addChild(myList);
	
	// create some sample items
	for (var i:int = 0; i < 5; i++ )
	{
		var tmpItem:Sprite = new Sprite();
		tmpItem.addEventListener(MouseEvent.ROLL_OVER, onOver);
		tmpItem.addEventListener(MouseEvent.ROLL_OUT, onOut);
		tmpItem.addEventListener(MouseEvent.CLICK, onClick);
		tmpItem.buttonMode = true;
		tmpItem.graphics.beginFill(0x990000);
		tmpItem.graphics.drawRect(0, 0, 5+(i*20), 5+(i*20));
		tmpItem.graphics.endFill();
		
		myList.add(tmpItem);
	}
	
	function onOver(e:MouseEvent):void
	{
		e.currentTarget.scaleX = 2;
		e.currentTarget.scaleY = 2;
	}
		
	function onOut(e:MouseEvent):void
	{
		e.currentTarget.scaleX = 1;
		e.currentTarget.scaleY = 1;
	}
		
	function onClick(e:MouseEvent):void
	{
		//trace(e.currentTarget.parent.id)
		//trace(e.currentTarget.parent.index)
		
		//myList.removeByIndex(e.currentTarget.parent.index);
		//myList.removeById(e.currentTarget.parent.id);	
	}
		
	function onResize(e:ListEvent):void
	{
		//trace(myList.width, myList.height)
	}

*/
package com.doitflash.utils.lists
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.doitflash.events.ListEvent;
	
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 3/18/2010 12:08 PM
	 */
	public class List extends Sprite
	{
		private var _body:Sprite;
		
		private var _direction:String = Direction.LEFT_TO_RIGHT;
		private var _orientation:String = Orientation.VERTICAL;
		
		private var _width:Number=0;
		private var _height:Number=0;
		
		private var _itemsArray:Array = new Array();
		private var _idCount:int = 0;
		private var _space:Number = 3;
		private var _speed:Number = .2;
		
		private var myTweenX:TweenMax;
		private var myTweenY:TweenMax;
		
		public function List():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
			
			_body = new Sprite();
			this.addChild(_body);
		}
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter

		public function set direction(a:String):void
		{
			_direction = a;
		}
		
		public function set orientation(a:String):void
		{
			_orientation = a;
		}
		
		public function get space():Number
		{
			return _space;
		}
		
		public function set space(a:Number):void
		{
			_space = a;
		}
		
		public function get speed():Number
		{
			return _speed;
		}
		
		public function set speed(a:Number):void
		{
			_speed = a;
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

		public function add($item:*, $index:Number=NaN):void
		{
			if (!$index)$index = _itemsArray.length;
			
			var itemHolder:ItemHolder = new ItemHolder();
			itemHolder.id = _idCount;
			itemHolder.index = $index;
			itemHolder.addContent($item);
			_body.addChild(itemHolder);
			
			_idCount++;
			
			// save the item in array
			_itemsArray.splice($index, 0 , itemHolder);
		}
		
		public function removeByIndex($index:int):void
		{
			// find the item inside the array
			var item:ItemHolder = _itemsArray[$index];
			
			// remove it from the array
			_itemsArray.splice($index, 1);
			
			// fade it out
			//var tween:TweenMax = TweenMax.to(item, .1, { alpha:0 } );
			//tween.addEventListener(TweenEvent.COMPLETE, onRemoveComplete);
			_body.removeChild(item);
		}
		
		public function removeById($id:int):void
		{
			// find the item inside the array
			for (var i:int = 0; i < _itemsArray.length; i++ )
			{
				var item:ItemHolder = _itemsArray[i];
				if (item.id == $id)
				{
					// remove it from the array
					_itemsArray.splice(item.index, 1);
					
					// fade it out
					_body.removeChild(item);
				}
				
			}
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
			
			this.addEventListener(Event.ENTER_FRAME, itemArrange);
		}
		
		private function itemArrange(e:Event):void
		{
			_width = 0;
			_height = 0;
			
			for (var i:int = 0; i < _itemsArray.length; i++ )
			{
				var currItem:ItemHolder = _itemsArray[i];
				currItem.index = i;
				var lastItem:ItemHolder = _itemsArray[i - 1];
				
				var _x:Number = 0;
				var _y:Number = 0;
				
				switch(_direction)
				{	
					case Direction.LEFT_TO_RIGHT:
					
						if (_orientation == Orientation.VERTICAL)
						{
							
							if (lastItem)
							{
								_y = lastItem.y + lastItem.height + _space;
								
							}
							
							myTweenY = TweenMax.to(currItem, _speed, { y:_y } );
							
							_width = Math.max(_width, currItem.width);
							_height += currItem.height;
							
							
						}
						else if (_orientation == Orientation.HORIZONTAL)
						{
							if (lastItem)
							{
								_x = lastItem.x + lastItem.width + _space;
							}
							
							myTweenX = TweenMax.to(currItem, _speed, { x:_x } );
							
							_width += currItem.width;
							_height = Math.max(_height, currItem.height);
						}
					
					break;
					case Direction.RIGHT_TO_LEFT:
					
						if (_orientation == Orientation.VERTICAL)
						{
							_x = -currItem.width;
							myTweenX = TweenMax.to(currItem, _speed, { x:_x } );
							
							if (lastItem)
							{
								_y = lastItem.y + lastItem.height + _space;
							}
							myTweenY = TweenMax.to(currItem, _speed, { y:_y } );
							
							_width = Math.max(_width, currItem.width);
							_height += currItem.height;
						}
						else if (_orientation == Orientation.HORIZONTAL)
						{
							_x = -currItem.width;
							
							if (lastItem)
							{
								_x = lastItem.x - currItem.width - _space;
							}
							
							myTweenX = TweenMax.to(currItem, _speed, { x:_x } );
							
							_width += currItem.width;
							_height = Math.max(_height, currItem.height);
						}
					
					break;
					/*case Direction.TOP_TO_BOTTOM:
					
						if (_orientation == Orientation.VERTICAL)
						{
							
						}
						else if (_orientation == Orientation.HORIZONTAL)
						{
							
							
						}
					
					break;
					case Direction.BOTTOM_TO_TOP:
					
						if (_orientation == Orientation.VERTICAL)
						{
							
						}
						else if (_orientation == Orientation.HORIZONTAL)
						{
							
							
						}
					
					break;*/
				}
				
				
			}
			
			this.dispatchEvent(new ListEvent(ListEvent.RESIZE));
		}
	}
	
}