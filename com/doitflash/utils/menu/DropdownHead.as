package com.doitflash.utils.menu
{
	import com.doitflash.transition.Transition;
	import com.doitflash.events.TransitionEvent;
	import com.doitflash.transition.EffectType;
	import com.doitflash.consts.Ease;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import com.doitflash.events.MenuEvent;
	import flash.events.MouseEvent;
	
	import com.doitflash.utils.bg.Bg;
	import com.doitflash.utils.bg.BgType;
	import com.doitflash.utils.bg.BgConst;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	
	import com.doitflash.consts.LangDirection;
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	
	/**
	 * The DropdownHead class is used and initialized by <code>DropdownMenu</code> class.
	 * This class is responsible for creating the menu's head. right now the head shows the selected
	 * text only. if you are trying to extend this class, make sure to extend DropdownMenu also, 
	 * because that class will initialize this one.
	 * 
	 * @author Hadi Tavakoli - 4/8/2010 7:12 PM
	 * 
	 * @see DropdownMenu
	 */
	public class DropdownHead extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		
		private var _myBg:Bg;
		private var _bgAlpha:Number = 1;
		private var _arrowImg:String;
		private var _arrowImages:Array;
		private var _arrow:*;
		
		private var _isOpen:Boolean = false;
		
		// general settings for the menu texts
		private var _embedFonts:Boolean = false;
		private var _fontName:String = "Arial";
		private var _txtColorA:uint = 0x000000;
		private var _txtColorB:uint = 0x990000;
		private var _txtSize:Number = 13;
		private var _txtDirection:String = LangDirection.LTR;
		
		private var _labelField:TextField;
		private var _format:TextFormat;
		private var _label:String = "#Selected Item#";
		
		
		public function DropdownHead():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, stageRemoved);
			
			// use the Bg class to create bg
			createBg();
		}
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter

		/**
		 * Indicates the width of the menu's head
		 */
		override public function get width():Number
		{
			return _width;
		}
		
		/**
		 * @private
		 */
		override public function set width(a:Number):void
		{
			_width = a;
		}
		
		/**
		 * Indicates the height of the menu's head
		 */
		override public function get height():Number
		{
			return _height;
		}
		
		/**
		 * @private
		 */
		override public function set height(a:Number):void
		{
			_height = a;
		}
		
		/**
		 * Indicates the transparency value of the head.
		 */
		public function set bgAlpha(a:Number):void
		{
			_bgAlpha = a;
			_myBg.alpha = _bgAlpha;
		}
		
		/**
		 * Indicates if the menu is open or closed.
		 */
		public function get isOpen():Boolean
		{
			return _isOpen;
		}
		
		/**
		 * @private
		 */
		public function set isOpen(a:Boolean):void
		{
			_isOpen = a;
		}
		
		/**
		 * This will set the URL location of the menu arrow.
		 */
		public function set arrowImg(a:String):void
		{
			_arrowImg = a;
		}
		
		/**
		 * This will set the URL location of the menu arrows. in mouseUp, mouseOver and mouseDown positions.
		 */
		public function set arrowImages(a:Array):void
		{
			_arrowImages = a;
		}
		
		/**
		 * This will set if the fonts are to be embeded or not.
		 * 
		 * @see DropdownMenu#embedFonts()
		 */
		public function set embedFonts (a:Boolean):void
		{
			_embedFonts = a;
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		/**
		 * call this method to open the menu.
		 */
		public function open():void
		{
			onOpen();
		}
		
		/**
		 * call this method to close the menu.
		 */
		public function close():void
		{
			onClose();
		}
		
		/**
		 * call this method to remove the Bg. You may have not noticed but for better performance, when the menu is closed,
		 * it's Bg is removed to save cpu!
		 */
		public function removeBg():void
		{
			_myBg.type = BgType.SIMPLE_COLOR;
			_myBg.simpleColor = 0x000000;
			_myBg.strokeThickness = 0;
		}
		
		/**
		 * This method sets the Bg for the head.
		 * 
		 * @param	$type
		 * @param	$prop
		 * 
		 * @see DropdownMenu#setHeadBg()
		 */
		public function setBg($type:String=null, $prop:Object=null):void
		{
			if ($type != null && $prop != null)
			{
				// set the type for the bg
				_myBg.type = $type;
				
				$prop.holder = this;
				// apply the properties
				for (var param:* in $prop)
				{
					try
					{
						_myBg[param] = $prop[param];
					}
					catch (err:Error)
					{
						trace("There is no property named 'param' >> Class: com.doitflash.utils.menu.DropdownHead, Function: setBg")
					}
				}
			}
		}
		
		/**
		 * This method sets the general text styling for the head.
		 * 
		 * @param	$font
		 * @param	$colorA
		 * @param	$colorB
		 * @param	$size
		 * @param	$direction
		 * 
		 * @see DropdownMenu#setTxtStyle()
		 */
		public function setTxtStyle($font:String, $colorA:uint, $colorB:uint, $size:Number, $direction:String=LangDirection.LTR):void
		{
			_fontName = $font;
			_txtColorA = $colorA;
			_txtColorB = $colorB;
			_txtSize = $size;
			_txtDirection = $direction;
		}
		
		/**
		 * When a new item is selected, this method will update the head text.
		 * 
		 * @param	$label
		 */
		public function updateLabel($label:String):void
		{
			if (!stage) return;
			
			/* to create a transition, we need two objects, so here we create a clone
			from the textField and add it to the stage and we will actually remove
			the primary textField after updating its text! */
			
			// create the cloned textField
			var clonedText:TextField = new TextField();
			clonedText.autoSize = TextFieldAutoSize.LEFT;
			clonedText.antiAliasType = AntiAliasType.ADVANCED;
			clonedText.embedFonts = _embedFonts;
			clonedText.selectable = false;
			clonedText.defaultTextFormat = _labelField.getTextFormat();
			clonedText.text = _labelField.text;
			clonedText.mouseEnabled = false;
			clonedText.x = _labelField.x;
			clonedText.y = _labelField.y;
			this.addChild(clonedText);
			
			// now update and remove the primary textField
			_label = $label;
			_labelField.text = _label;
			//this.removeChild(_labelField);
			_labelField.alpha = 0;
			
			// do the transition
			var transObj:Object = new Object();
			transObj.type = EffectType.Slide;
			transObj.setEase = Ease.Quart_easeInOut;
			transObj.orientation = Orientation.VERTICAL;
			transObj.direction = Direction.TOP_TO_BOTTOM;
			transObj.vSpace = 15;
			transObj.hSpace = 35;
			var trans:Transition = new Transition(clonedText, _labelField, 0.5, transObj, onTransDone);
		}
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected

		/**
		 * This method creates the clickable arrow for the menu.
		 * 
		 * @see DropdownArrow
		 */
		protected function buildArrow():void
		{
			_arrow = new DropdownArrow(_arrowImg, _arrowImages);
			_arrow.addEventListener(DropdownArrow.COMPLETE, setArrowPosition);
			_arrow.buttonMode = true;
			this.addChild(_arrow);
		}
		
		/**
		 * This method actually builds the text field for the head label.
		 */
		protected function buildPreview():void
		{
			_format = new TextFormat();
			_format.font = _fontName;
			_format.size = _txtSize;
			_format.color = _txtColorA;
			
			_labelField = new TextField();
			_labelField.autoSize = TextFieldAutoSize.LEFT;
			_labelField.antiAliasType = AntiAliasType.ADVANCED;
			_labelField.embedFonts = _embedFonts;
			_labelField.selectable = false;
			_labelField.defaultTextFormat = _format;
			_labelField.text = _label;
			_labelField.mouseEnabled = false;
			this.addChild(_labelField);
			
			setLabelPosition();
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private

		private function stageRemoved(e:Event):void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageAdded);
			
			removeBg();
			cleanUp(this);
			
		}
		
		private function stageAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, stageAdded);
			
			// draw a place holder so the background can work on the dimension
			drawPlaceHolder();
			
			buildArrow();
			
			buildPreview();
			
			// add listeners
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.buttonMode = false;
			
			//this.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClose);
		}
		
		private function cleanUp($target:Sprite):void
		{
			for (var i:int = $target.numChildren-1; i >= 0; i--)
			{
				$target.removeChildAt(i);
			}
		}
		
		private function drawPlaceHolder():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
		}
		
		private function createBg():void
		{
			_myBg = new Bg();
			_myBg.alpha = _bgAlpha;
			this.addChild(_myBg);
			
			//_myBg.type = BgType.GLASSY;
			//_myBg.glassColor = 0x5e7cc1;
			//_myBg.glassAlpha = 0.3;
			//_myBg.glassBlur = 15;
			//_myBg.glassBlurQuality = 1;
			//_myBg.holder = this;
			//_myBg.type = BgType.SIMPLE_COLOR;
			//_myBg.simpleColor = 0x000000;
			//_myBg.strokeThickness = 1;
			//_myBg.strokeColor = 0xFFFFFF;
			//_myBg.curve(0, 0, 0, 0);
		}
		
		private function setArrowPosition(e:Event):void
		{
			e.currentTarget.x = _width - e.currentTarget.width;
		}
		
		private function setLabelPosition():void
		{
			_labelField.x = 5;
			_labelField.y = _height / 2 - _labelField.height / 2;
		}
		
		private function onOver(e:MouseEvent):void
		{
			_arrow.over(e);
		}
		
		private function onOut(e:MouseEvent):void
		{
			_arrow.out(e);
		}
		
		private function onClick(e:MouseEvent=null):void
		{
			if (_isOpen)
			{
				onClose(e);
				
			}
			else
			{
				onOpen(e);
				
			}
		}
		
		private function onTransDone(e:TransitionEvent=null):void
		{
			_labelField.alpha = 1;
			setLabelPosition();
		}
		
		private function onOpen(e:MouseEvent=null):void
		{
			// let the parent know that the menu is opened
			this.dispatchEvent(new MenuEvent(MenuEvent.OPEN));
			
			// update the text color
			_labelField.setTextFormat(new TextFormat(_fontName, _txtSize, _txtColorB));
			
			// let the arrow know that the menu is opened
			_arrow.open();
		}
		
		private function onClose(e:MouseEvent=null):void
		{
			// let the parent know that the menu is closed
			this.dispatchEvent(new MenuEvent(MenuEvent.CLOSE));
			
			// update the text color to its default
			_labelField.setTextFormat(_format);
			
			// let the arrow know that the menu is closed
			_arrow.close();
		}
	}
	
}