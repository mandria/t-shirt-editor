/*
* ResizableMovieClip.as
* Version 1.1 modded by mandrake
*/

package com.ipnotica.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	public class ResizableMovieClip extends MovieClip
	{
		private var _item:DisplayObject; // the most critical thing - the movieclip/sprite/loader that you want to be resizable
		private var _container:MovieClip = new MovieClip(); // contains the _item (see code below for more details)
		
		public var _resizeBug:DisplayObject = new ResizeBug(); 
		public var _rotateBug:DisplayObject = new RotateBug();
				
		private var _draggable:Boolean;
		private var _dragging:Boolean = false; // is this MovieClip currently being dragged (moved) around the screen?
		private var _resizing:Boolean = false; // is this MovieClip currently being resized?
		private var _rotating:Boolean = false; // is this MovieClip currently being rotated
		private var _proportionalResizing:Boolean;
		private var _containerRotationOffset:Number = 0; // after every rotation a new offset is stored here
				
		/*
		* item:DisplayObject - the DisplayObject that you want to be resizable (typically a Loader or MovieClip ) 
		* proportionalResizing:Boolean - true to force the item to resize proportionally
		* draggable:Boolean  - true to make the item movable by clicking and dragging
		* 
		*/
		public function ResizableMovieClip(item:DisplayObject, 										  
										   proportionalResizing:Boolean = true, draggable:Boolean = true)
		{				
			_proportionalResizing = proportionalResizing;
			_draggable = draggable;
						
			/* The container will contain _item. The only reason for this is to center _item.
			* Unfortunately AS3 does not provide us a method to set the registration point 
			* so this is an ugly necessity.			
			*/
			addChild(_container); 
						
			/* _item is DisplayObject that you want to make resizable.
			* Usually this is of type Loader or MovieClip. No matter what the type, they will
			* all be downcast to the DisplayObject type.
			*/
			_item = item;			
			_container.addChild(_item as DisplayObject);
			
			/* The following 2 lines centers _item within _container. So, when _item is rotated it rotates on its 
			* center point. 
			*/ 
			_item.x = -_item.width / 2;
			_item.y = -_item.height / 2;
			
			addEventListener(MouseEvent.CLICK, handleClick, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown, false, 0, true);
			
			/* 
			* The stage property is only available after this MovieClip added to the Stage. 
			* Therefore the init() method is required to initialize some things that require the stage property
			*/
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			
		}
		
		/*
		* Event handler reigstrations and variables requiring the use of the stage property
		* can only be set AFTER this class has been added to the stage, because before then, the
		* stage property of this class is unavailable.
		*/
		public function init(e:Event):void
		{					
			stage.addEventListener(MouseEvent.MOUSE_UP, handleStageMouseUp, false, 0, true);
			stage.addEventListener(MouseEvent.CLICK, handleStageClick, false, 0, true);
			
			// Add the rotate bug, position it and activate it
			_rotateBug = parent.addChild(_rotateBug);
			_rotateBug.visible = false;
			_rotateBug.x = _item.x + _item.width;
			_rotateBug.addEventListener(MouseEvent.MOUSE_DOWN, handleRotateBugMouseDown, false, 0, true);
			
			// Add the resize bug, position it and activate it
			_resizeBug = parent.addChild(_resizeBug);
			_resizeBug.visible = false;
			_resizeBug.x = _item.x + _item.width;
			_resizeBug.y = _item.y + _item.height;
			_resizeBug.addEventListener(MouseEvent.MOUSE_DOWN, handleResizeBugMouseDown, false, 0, true);
			
		}
				
		/* 
		* This method MUST be called before setting an instance of this MovieClip to null.
		* Not doing so may result in memory and performance issues.
		*/
		public function destroy():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleStageMouseMove);			
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleStageMouseUp);
			stage.removeEventListener(MouseEvent.CLICK, handleStageClick);
			
			parent.removeChild(_rotateBug);
			parent.removeChild(_resizeBug);
			parent.removeChild(this); 
		}
				
		/*
		* Shows the borders, the resize bug and the rotate bug
		*/
		public function showControls():void
		{
			highlightBorders();
			_resizeBug.visible =true;
			_rotateBug.visible = true;
		}
		
		/*
		* Hides the borders, the resize bug and the rotate bug
		*/
		public function hideControls():void
		{
			unHighlightBorders();
			_resizeBug.visible = false;
			_rotateBug.visible = false;
		}						
				
		/*
		* Sets the x value of this MovieClip
		* 
		* You MUST ALWAYS use this method to set the x value, 
		* instead of setting it directly. If you do not, then
		* the controls i.e. the resize bug and the rotate bug will
		* not follow the graphic.
		*/ 
		public function setX(val:Number):void
		{
			x = val;
			refreshControlPositions();
		}
		
		/*
		* Sets the y value of this MovieClip
		* 
		* You MUST ALWAYS use this method to set the y value, 
		* instead of setting it directly. If you do not, then
		* the controls i.e. the resize bug and the rotate bug will
		* not follow the graphic.
		*/ 
		public function setY(val:Number):void
		{
			y = val;
			refreshControlPositions();			
		}
		
		/*
		* Sets the width value of this MovieClip
		* 
		* You MUST ALWAYS use this method to set the width value, 
		* instead of setting it directly. If you do not, then
		* the controls i.e. the resize bug and the rotate bug will
		* not follow the graphic.
		*
		*/ 
		public function setWidth(val:Number):void
		{
			width = val;
			refreshControlPositions();
		}
		
		/*
		* Sets the height value of this MovieClip
		* 
		* You MUST always use this method to set the height value, 
		* instead of setting it directly. If you do not, then
		* the controls i.e. the resize bug and the rotate bug will
		* not follow the graphic.
		*
		*/ 
		public function setHeight(val:Number):void
		{
			height = val;
			refreshControlPositions();
		}
		
		public function set proportionalResizing(val:Boolean):void
		{
			_proportionalResizing = val;
		}
		
		public function get proportionalResizing():Boolean
		{
			return _proportionalResizing;
		}
		
		public function refreshControlPositions():void
		{			
			_resizeBug.x = x + width  / 2;
			_resizeBug.y = y + height / 2;
			_rotateBug.x = x + width  / 2;
			_rotateBug.y = y;
		}
		
		/*
		* Draws the rectangle around this MovieClip
		*/
		public function highlightBorders():void
		{
			graphics.clear();
			graphics.lineStyle(2, 0, 1, false, "none", "none", "miter", 4); 
			graphics.drawRect(_container.x - _container.width/2- 1, _container.y - _container.height / 2 - 1,
							  _container.width+2, _container.height + 2);
		}
		
		public function unHighlightBorders():void
		{
			graphics.clear();
		}
										
		private function handleMouseDown(e:MouseEvent):void
		{
			if(_draggable)
			{				
				_dragging = true;
				startDrag();
			}
			
			/*
			* Bring elements to the top of the display list
			*/
			parent.addChild(this);
			parent.addChild(_resizeBug);
			parent.addChild(_rotateBug);
						
			// Begin listening for certain events 
			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleStageMouseMove, false, 0, true);			
						
			// Make sure the controls e.g. resize bug are in the right place
			refreshControlPositions();
			showControls();
			
		}
		
		private function handleClick(e:MouseEvent):void
		{			
			e.stopImmediatePropagation(); // we don't want the event e to be "intercepted" by handleStageClick() 
			showControls();
			
		}							
			
		private function handleStageMouseUp(e:MouseEvent):void
		{			
			if(_draggable)
			{	
				_dragging = false;
				stopDrag();
			}			
			
			refreshControlPositions();
			
			_resizing = false;
			_rotating = false;	
			if(e.target is ResizeBug || e.target is RotaterHead || e.target is RotateBug)
			{}
			else
			{
				hideControls();
			}	
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleStageMouseMove);
		}
		
		private function handleStageMouseMove(e:MouseEvent):void
		{					
		
		
			if(_resizing)
			{
				var h2wRatio:Number = width / height;
				
				// Make sure that the graphic height does not get too small
				// If it does then return it to the orignal height/width
				if(height > 5 && width > 5)
				{					
					height = (e.stageY - y) * 2;
					
					if(_proportionalResizing)
					{
						width =  height * h2wRatio;
					}
					else
					{
						width = (e.stageX - x) * 2;
					}
				}
				else
				{
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleStageMouseMove);
					scaleX = 1;
					scaleY = 1;
				}	
			}
				
			else if(_rotating)
			{							
				var dx:Number = stage.mouseX - x;
				var dy:Number = stage.mouseY - y;
				var rads:Number = Math.atan2(dy, dx);
							
				_container.rotation = (rads * 180 / Math.PI);
				_container.rotation += _containerRotationOffset;
			
			}
			
			refreshControlPositions();								
			highlightBorders();
		}
				
		private function handleStageClick(e:MouseEvent):void
		{			
			if(e.target is ResizeBug || e.target is RotaterHead || e.target is RotateBug)
			{}
			else
			{
				hideControls();
			}
		}						
		
		private function handleResizeBugMouseDown(e:MouseEvent):void
		{							
			_resizing = true;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleStageMouseMove, false, 0, true);
		}
				
		private function handleRotateBugMouseDown(e:MouseEvent):void
		{
			_rotating = true;
			_containerRotationOffset = _container.rotation;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleStageMouseMove, false, 0, true);
		}
		
	}
}