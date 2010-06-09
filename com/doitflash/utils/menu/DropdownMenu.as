package com.doitflash.utils.menu
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.doitflash.events.MenuEvent;
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Back;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Quint;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Strong;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Linear;
	import flash.utils.getDefinitionByName;
	import com.doitflash.consts.LangDirection;
	import com.doitflash.consts.Ease;
	
	/**
	 * use this DropdownMenu to create combo like menus.
	 * 
	 * @author Hadi Tavakoli - 4/8/2010 7:04 PM
	 * @see http://www.myflashlab.com/2010/01/22/scrollbar-class/
	 * 
	 * @example The following example will create a DropdownMenu and showing you how you set all different inputs.
	 * In this example we have NOT used our scrollbar class. see the other examples to show you how to import our scrollbar
	 * into the DropdownMenu class.
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.utils.menu.DropdownMenu;
	 * import com.doitflash.events.MenuEvent;
	 * import com.doitflash.consts.Ease;
	 * 
	 * var _menu:DropdownMenu = new DropdownMenu();
	 * 
	 * // add listeners
	 * _menu.addEventListener(MenuEvent.RESIZE, onResize); // this will listen to the menu width and height.
	 * _menu.addEventListener(MenuEvent.SELECTED, onItemSelected); // this listens to the selected item.
	 * 
	 * _menu.width = 300;
	 * _menu.headHeight = 30; // this is the height of the menu head.
	 * _menu.bodyHeight = 350; // this is the height of the menu's body.
	 * _menu.embedFonts = false;
	 * _menu.setSpeed = .5; // this is the speed of the menu drawer animation in seconds.
	 * _menu.setEase = Ease.Quint_easeInOut; // this is the ease type animation. Note: Ease.Regular_easeOut does not work!
	 * _menu.headAlpha = 1;
	 * _menu.bodyAlpha = 1;
	 * _menu.setHeadBg("glassyBg", { holder:_menu, glassColor:0xFFFFFF, glassAlpha:0.3, glassBlurQuality:5, glassBlur:10 } );
	 * _menu.setBodyBg("glassyBg", { holder:null, glassColor:0xFF99FF, glassAlpha:0.3, glassBlurQuality:5, glassBlur:15 } );
	 * _menu.headArrow = "img/subArrow.png"; // this is the image location of the menu drop sign.
	 * _menu.headArrowImages = ["img/subArrow.png", "img/subArrowOver.png", "img/subArrowDown.png"];
	 * _menu.setTxtStyle("Arial", 0x995500, 0xFF9900, 15, "ltr"); // this is the general text style for the menu. will be overwrited by list styles of course.
	 * _menu.contentPath = "menu.xml"; // this is the location of the xml file which holds the menu items.
	 * 
	 * this.addChild(_menu);
	 * 
	 * function onResize(e:MenuEvent):void
	 * {
	 *		trace(e.currentTarget.width, e.currentTarget.height)
	 * }
	 * 
	 * private function onItemSelected(e:MenuEvent):void
	 * {
	 * 		// Anything that you trace depends on the structure of your menu.xml
	 *		trace(e.param.id);
	 *		trace(e.param.title)
	 *		trace(e.param.label)
	 *		trace(e.param.address)
	 * }
	 * 
	 * </listing>
	 * 
	 * @example If you have purchansed our <a href="http://www.myflashlab.com/2010/01/22/scrollbar-class/">Scrollbar class</a>, you may import it into this class like how it is shown below.
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.utils.menu.DropdownMenu;
	 * import com.doitflash.events.MenuEvent;
	 * import com.doitflash.consts.Ease;
	 * import com.doitflash.utils.scroll.RegSimpleScroll;
	 * 
	 * // initialize the scrollbar and set its inputs
	 * var _myScroll:RegSimpleScroll = new RegSimpleScroll();
	 * _myScroll.btnSize = 0;
	 * _myScroll.sliderColor = 0x990000;
	 * _myScroll.drawDisabledScroll = true;
	 * 
	 * // initialize the menu
	 * var _menu:DropdownMenu = new DropdownMenu();
	 * 
	 * // add listeners
	 * _menu.addEventListener(MenuEvent.RESIZE, onResize); // this will listen to the menu width and height.
	 * _menu.addEventListener(MenuEvent.SELECTED, onItemSelected); // this listens to the selected item.
	 * 
	 * _menu.width = 300;
	 * _menu.headHeight = 30; // this is the height of the menu head.
	 * _menu.bodyHeight = 350; // this is the height of the menu's body.
	 * _menu.embedFonts = false;
	 * _menu.setSpeed = .5; // this is the speed of the menu drawer animation in seconds.
	 * _menu.setEase = Ease.Quint_easeInOut; // this is the ease type animation. Note: Ease.Regular_easeOut does not work!
	 * _menu.headAlpha = 1;
	 * _menu.bodyAlpha = 1;
	 * _menu.setHeadBg("glassyBg", { holder:_menu, glassColor:0xFFFFFF, glassAlpha:0.3, glassBlurQuality:5, glassBlur:10 } );
	 * _menu.setBodyBg("glassyBg", { holder:null, glassColor:0xFF99FF, glassAlpha:0.3, glassBlurQuality:5, glassBlur:15 } );
	 * _menu.headArrow = "img/subArrow.png"; // this is the image location of the menu drop sign.
	 * _menu.headArrowImages = ["img/subArrow.png", "img/subArrowOver.png", "img/subArrowDown.png"];
	 * _menu.setTxtStyle("Arial", 0x995500, 0xFF9900, 15, "ltr"); // this is the general text style for the menu. will be overwrited by list styles of course.
	 * _menu.contentPath = "menu.xml"; // this is the location of the xml file which holds the menu items.
	 * 
	 * // import the scrollbar now:
	 * _menu.importScrollClass(_myScroll, RegSimpleScroll);
	 * 
	 * this.addChild(_menu);
	 * 
	 * function onResize(e:MenuEvent):void
	 * {
	 *		trace(e.currentTarget.width, e.currentTarget.height)
	 * }
	 * 
	 * private function onItemSelected(e:MenuEvent):void
	 * {
	 * 		// Anything that you trace depends on the structure of your menu.xml
	 *		trace(e.param.id);
	 *		trace(e.param.title)
	 *		trace(e.param.label)
	 *		trace(e.param.address)
	 * }
	 * 
	 * </listing>
	 */
	public class DropdownMenu extends Sprite
	{
		private var _head:*;
		private var _body:*;
		private var _mask:Sprite;
		
		private var _width:Number = 100;
		private var _height:Number = 20;
		
		private var _headHeight:Number = 30;
		private var _bodyHeight:Number = 200;
		
		private var _headBgType:String;
		private var _headBgProp:Object;
		private var _headAlpha:Number = 1;
		private var _headArrow:String;
		private var _headArrowImages:Array;
		
		private var _bodyBgType:String;
		private var _bodyBgProp:Object;
		private var _bodyAlpha:Number = 1;
		
		private var _scrollInstance:*;
		private var _scrollClassString:String;
		private var _scrollClass:Class;
		private var _haveScroll:Boolean = false;
		private var runtimeScroll:*;
		
		private var _mainContent:XML;
		private var _mainContentPath:String;
		
		private var _embedFonts:Boolean = false;
		private var _fontName:String = "Arial";
		private var _txtColorA:uint = 0x000000;
		private var _txtColorB:uint = 0x990000;
		private var _txtSize:Number = 13;
		private var _txtDirection:String = LangDirection.LTR;
		
		private var _speed:Number = 1;
		private var _menuEase:String = Ease.Quart_easeInOut;
		private var _easeFunc:Function;
		
		private var _isNormal:Boolean = true; // isNormal means the menu will open normally to bottom
		
		public function DropdownMenu():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, stageRemoved);
			
			com.greensock.easing.Bounce;
			com.greensock.easing.Back;
			com.greensock.easing.Quad;
			com.greensock.easing.Quint;
			com.greensock.easing.Quart;
			com.greensock.easing.Strong;
			com.greensock.easing.Sine;
			com.greensock.easing.Expo;
			com.greensock.easing.Elastic;
			com.greensock.easing.Cubic;
			com.greensock.easing.Circ;
			com.greensock.easing.Linear;
		}
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter

		/**
		 * This is the live width of the menu
		 * @default 100
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
			if (_width != a)
			{
				_width = a;
				createMenu();
			}
		}
		
		/**
		 * This is the live height of the menu.
		 */
		override public function get height():Number
		{
			return _height;
		}
		
		/**
		 * indicates height of the menu head.
		 * @default 30
		 */
		public function set headHeight(a:Number):void
		{
			if (_headHeight != a)
			{
				_headHeight = a;
				createMenu();
			}
		}
		
		/**
		 * indicates height of the menu body.
		 * @default 200
		 */
		public function set bodyHeight(a:Number):void
		{
			if (_bodyHeight != a)
			{
				_bodyHeight = a;
				createMenu();
			}
		}
		
		/**
		 * set the transparency value of the menu's head.
		 * @default 1
		 */
		public function set headAlpha(a:Number):void
		{
			_headAlpha = a;
			
			if (_head)
			{
				_head.bgAlpha = _headAlpha;
			}
		}
		
		/**
		 * set the url location of the image being used for the menu drop arrow indicator.
		 */
		public function set headArrow(a:String):void
		{
			_headArrow = a;
			
			if (_head)
			{
				_head.arrowImg = _headArrow;
			}
		}
		
		/**
		 * set the url location of the image being used for the menu drop arrow indicator, in all three positions
		 * which are mouseOut, mouseOver and mouseDown 
		 */
		public function set headArrowImages(a:Array):void
		{
			_headArrowImages = a;
			
			if (_head)
			{
				_head.arrowImages = _headArrowImages;
			}
		}
		
		/**
		 * set the transparency value of the menu's body.
		 * @default 1
		 */
		public function set bodyAlpha(a:Number):void
		{
			_bodyAlpha = a;
			
			if (_body)
			{
				_body.bgAlpha = _bodyAlpha;
			}
		}
		
		/**
		 * shows the xml data being used for creating the menu's items.
		 */
		public function get content():XML
		{
			return _mainContent;
		}
		
		/**
		 * @private
		 */
		public function set content(a:XML):void
		{
			_mainContent = new XML(a);
			createMenu();
		}
		
		/**
		 * Send the url location of the menu's items xml.
		 * If you don't wish to use an external xml, you may consider sending the xml object through
		 * <code>content</code> method.
		 * 
		 * @see #content()
		 */
		public function set contentPath(a:String):void
		{
			_mainContentPath = a;
			createMenu();
		}
		
		/**
		 * Indicates if you want to used embeded fonts in the menu or not. Note that if you are setting this to
		 * <code>true</code> you must have embeded some fonts in your project before. if this parameter is set to
		 * <code>true</code> and you don't see the texts, that means that you have not embeded the fonts correctly or
		 * youe font names don't match.
		 * 
		 * @default false
		 */
		public function set embedFonts(a:Boolean):void
		{
			_embedFonts = a;
			createMenu();
		}
		
		/**
		 * Indicates the speed of the menu animation in seconds.
		 * 
		 * @default 1
		 */
		public function set setSpeed(a:Number):void
		{
			_speed = a;
			createMenu();
		}
		
		/**
		 * Indicates the ease type of the animation. NOTE: do not use Ease.Regular_easeOut , anything else is fine.
		 * 
		 * @see	com.doitflash.consts.Ease
		 */
		public function set setEase(a:String):void
		{
			_menuEase = a;
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		/**
		 * Opens the dropdown menu.
		 */
		public function open():void
		{
			if(_head)_head.open();
		}
		
		/**
		 * Closes the dropdown menu.
		 */
		public function close():void
		{
			if(_head)_head.close();
		}
		
		/**
		 * Optionally, you would want to use our Scrollbar Class. all you have to do
		 * is to initialize the scrollbar and import it into this method.</br></br>
		 * 
		 * This method uses <code>getDefinitionByName</code> which may not work on all ocasions, alternativly use the
		 * <code>importScrollClass</code> method.
		 * 
		 * @param	$scroll			The Scrollbar instance.
		 * @param	$classString	The scrollbar class name.
		 * 
		 * @see http://www.myflashlab.com/2010/01/22/scrollbar-class/
		 * @see #importScrollClass()
		 */
		public function importScroll($scroll:*, $classString:String):void
		{
			_scrollInstance = $scroll;
			_scrollClassString = $classString;
			
			installScrollbar();
		}
		
		/**
		 * Optionally, you would want to use our Scrollbar Class. all you have to do
		 * is to initialize the scrollbar and import it into this method.
		 * 
		 * @param	$scroll
		 * @param	$class
		 * 
		 * @see http://www.myflashlab.com/2010/01/22/scrollbar-class/
		 * @see #importScroll()
		 */
		public function importScrollClass($scroll:*, $class:Class):void
		{
			_scrollInstance = $scroll;
			_scrollClass = $class;
			
			installScrollbar();
		}
		
		/**
		 * call this method if you have a scrollbar and you want to remove it.
		 * 
		 * @see #importScroll()
		 * @see #importScrollClass()
		 */
		public function removeScroll():void
		{
			if (_body)
			{
				if (_body.haveScroll)
				{
					_body.removeScroll();
				}
			}
			
			uninstallScrollbar();
		}
		
		/**
		 * Use this method to set different kinds of backgrounds the head of your menu.</br>
		 * You do not have to buy the Bg class Seperatly. just read the freely available documents
		 * and you will be able to create other kinds of background for your menu.
		 * 
		 * @param	$type	indicates the type of background.
		 * @param	$prop	An object containing different properties of the specified bg type.
		 * 
		 * @see 	http://www.myflashlab.com/2010/01/17/bg-class/
		 */
		public function setHeadBg($type:String, $prop:Object):void
		{
			// save the bg details
			_headBgType = $type;
			_headBgProp = $prop;
			
			if (_head)
			{
				_head.setBg(_headBgType, _headBgProp);
			}
		}
		
		/**
		 * Use this method to set different kinds of backgrounds for the body of your menu.</br>
		 * You do not have to buy the Bg class Seperatly. just read the freely available documents
		 * and you will be able to create other kinds of background for your menu.
		 * 
		 * @param	$type	indicates the type of background.
		 * @param	$prop	An object containing different properties of the specified bg type.
		 * 
		 * @see 	http://www.myflashlab.com/2010/01/17/bg-class/
		 */
		public function setBodyBg($type:String, $prop:Object):void
		{
			// save the bg details
			_bodyBgType = $type;
			_bodyBgProp = $prop;
			
			if (_head)
			{
				_body.setBg(_bodyBgType, _bodyBgProp);
			}
		}
		
		/**
		 * Use this method to set the general text styling for the menu. of course each menu item can have its own
		 * style if you set each item individually from the xml file.
		 * 
		 * @param	$font			This is the font name for the text.
		 * @param	$colorA			This is the text color in close status.
		 * @param	$colorB			This is the text color in open status.
		 * @param	$size			This is the text size.
		 * @param	$direction		Indicates the language direction of the text. (not working right now, we're waiting for flash CS5 new libraries)
		 */
		public function setTxtStyle($font:String, $colorA:uint, $colorB:uint, $size:Number, $direction:String=LangDirection.LTR):void
		{
			if($font)_fontName = $font;
			if($colorA)_txtColorA = $colorA;
			if($colorB)_txtColorB = $colorB;
			if($size)_txtSize = $size;
			if($direction)_txtDirection = $direction;
		}
		
		/**
		 * Use this method to pick an item in the menu.
		 * 
		 * @param	$id
		 */
		public function pick($id:int):void
		{
			if(_body)_body.pick($id);
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected

		/**
		 * This method builds the menu head with the class <code>DropdownHead</code>. 
		 * If you are extending this class and you wish to create another head for 
		 * the menu, you need to override this method and initialize your own <code>DropdownHead</code> class.
		 * 
		 * @see DropdownHead
		 */
		protected function buildHead():void
		{
			_head = new DropdownHead();
			_head.addEventListener(MenuEvent.OPEN, onOpen);
			_head.addEventListener(MenuEvent.CLOSE, onClose);
			_head.arrowImg = _headArrow;
			_head.arrowImages = _headArrowImages;
			_head.width = _width;
			_head.height = _headHeight;
			_head.embedFonts = _embedFonts;
			_head.setBg(_headBgType, _headBgProp);
			_head.setTxtStyle(_fontName, _txtColorA, _txtColorB, _txtSize, _txtDirection);
			_head.bgAlpha = _headAlpha;
			this.addChild(_head);
		}
		
		/**
		 * This method builds the menu body with the class <code>DropdownBody</code>. 
		 * If you are extending this class and you wish to create another body for 
		 * the menu, you need to override this method and initialize your own <code>DropdownBody</code> class.
		 * 
		 * @see DropdownBody
		 */
		protected function buildBody():void
		{
			_body = new DropdownBody();
			_body.addEventListener(MenuEvent.SELECTED, onItemSelected);
			_body.width = _width;
			_body.height = _bodyHeight;
			_body.embedFonts = _embedFonts;
			_body.setBg(_bodyBgType, _bodyBgProp);
			_body.setTxtStyle(_fontName, _txtColorA, _txtSize, _txtDirection);
			_body.bgAlpha = _bodyAlpha;
			
			if (_haveScroll && _scrollClassString)
			{
				_body.importScroll(_scrollInstance, _scrollClassString);
			}
			else if (_haveScroll && _scrollClass)
			{
				_body.importScrollClass(_scrollInstance, _scrollClass);
			}
			
			if (_mainContent)
			{
				_body.content = _mainContent;
			}
			else
			{
				if(_mainContentPath)_body.contentPath = _mainContentPath;
			}
			
			this.addChild(_body);
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private

		private function easeFunction($easeString:String):Function
		{
			var currClassString:String = "";
			var currFuncString:String = "";
			var isLookingForClass:Boolean = true;
			
			for (var i:int = 0; i < $easeString.length; i++ )
			{
				if ($easeString.charAt(i) != "_")
				{
					if (isLookingForClass)
					{
						//currClassString.concat(_menuEase.charAt(i));
						currClassString += $easeString.charAt(i);
					}
					else
					{
						//currFuncString.concat(_menuEase.charAt(i));
						currFuncString += $easeString.charAt(i);
					}
				}
				else
				{
					isLookingForClass = false;
				}
			}
			
			var thisClass:Class = getDefinitionByName("com.greensock.easing." + currClassString) as Class;
			return thisClass[currFuncString];
		}
		
		private function installScrollbar():void
		{
			// if we havethe instance and the string
			if (stage && _scrollInstance && _scrollClassString != null)
			{
				if (!_haveScroll)
				{
					var RuntimeScrollClass:Class = getDefinitionByName(_scrollClassString) as Class;
					runtimeScroll = new RuntimeScrollClass();
					//this.addChild(runtimeScroll as Sprite);
					//runtimeScroll.maskContent = _mainLayer;
					//runtimeScroll.drawDisabledScroll = true;
					_haveScroll = true;
				}
				
				runtimeScroll.importProp = _scrollInstance.exportProp; // import the properties
				
				//runtimeScroll.maskWidth = _formWidth;
				//runtimeScroll.maskHeight = _formHeight;
			}
			else if(stage && _scrollInstance && _scrollClass)
			{
				if (!_haveScroll)
				{
					runtimeScroll = new _scrollClass();
					//this.addChild(runtimeScroll as Sprite);
					//runtimeScroll.maskContent = _mainLayer;
					//runtimeScroll.drawDisabledScroll = true;
					_haveScroll = true;
				}
				
				runtimeScroll.importProp = _scrollInstance.exportProp; // import the properties
				
				//runtimeScroll.maskWidth = _formWidth;
				//runtimeScroll.maskHeight = _formHeight;
			}
		}
		
		private function uninstallScrollbar():void
		{
			// if we havethe instance and the string
			if (stage && _scrollInstance && _scrollClassString != null)
			{
				if (_haveScroll)
				{
					
					//this.addChild(_mainLayer);
					//this.removeChild(runtimeScroll);
					
					_haveScroll = false;
				}
				
				_scrollInstance = null;
				_scrollClassString = null;
				runtimeScroll = null;
			}
			else if (stage && _scrollInstance && _scrollClass)
			{
				if (_haveScroll)
				{
					
					//this.addChild(_mainLayer);
					//this.removeChild(runtimeScroll);
					
					_haveScroll = false;
				}
				
				_scrollInstance = null;
				_scrollClass = null;
				runtimeScroll = null;
			}
		}
		
		private function stageRemoved(e:Event):void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageAdded);
			
			// remove the scrollbar
			uninstallScrollbar();
			
			// clean any old child!
			cleanUp(this);
		}
		
		private function stageAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, stageAdded);
			
			installScrollbar();
			createMenu();
		}
		
		private function createMenu():void
		{
			if(stage)
			{
				// clean any old child!
				cleanUp(this);
				
				buildBody();
				buildHead();
				buildMask();
				
				setPositionFirstTime();
			}
		}
		
		private function cleanUp($target:Sprite):void
		{
			for (var i:int = $target.numChildren-1; i >= 0; i--)
			{
				$target.removeChildAt(i);
			}
		}
		
		private function buildMask():void
		{
			_mask = new Sprite();
			this.addChild(_mask);
			_body.mask = _mask;
		}
		
		// sets the position of the body and head for the first time.
		private function setPositionFirstTime():void
		{
			_body.y = -_body.height + _head.height;
			_mask.y = _head.height;
			
			//_width = _mask.width;
			_height = _mask.height + _head.height;
			dispatchSize();
		}
		
		// when the dropdown menu opens
		private function onOpen(e:MenuEvent):void
		{
			var _y:Number;
			
			// check if the menu has enough space on the bottom
			if (this.y + _body.height + _head.height > stage.stageHeight)
			{
				if (_isNormal)
				{
					_body.y = _head.y;
				}
				
				_isNormal = false;
				_y = -_body.height;
			}
			else
			{
				if (!_isNormal)
				{
					_body.y = -_body.height + _head.height;
				}
				
				_isNormal = true;
				_y = _head.height;
			}
			
			var tween:TweenMax = TweenMax.to(_body, _speed, { y:_y, ease:easeFunction(_menuEase) } );
			tween.addEventListener(TweenEvent.UPDATE, onTweenUpdate);
			tween.addEventListener(TweenEvent.COMPLETE, onOpenDone);
		}
		
		private function onOpenDone(e:TweenEvent):void
		{
			_head.isOpen = true;
		}
		
		// when the dropdown menu closes
		private function onClose(e:MenuEvent):void
		{
			var _y:Number;
			
			// check if the menu has enough space on the bottom
			if (this.y + _body.height + _head.height > stage.stageHeight)
			{
				_isNormal = false;
				_y = _head.y;
			}
			else
			{
				_isNormal = true;
				_y = -_body.height + _head.height;
			}
			
			var tween:TweenMax = TweenMax.to(_body, _speed, { y: _y, ease:easeFunction(_menuEase) } );
			tween.addEventListener(TweenEvent.UPDATE, onTweenUpdate);
			tween.addEventListener(TweenEvent.COMPLETE, onCloseDone);
		}
		
		private function onCloseDone(e:TweenEvent):void
		{
			_head.isOpen = false;
		}
		
		// this will redraw the mask layer
		private function onTweenUpdate(e:TweenEvent):void
		{
			if (!stage) return;
			
			var maskW:Number;
			var maskH:Number;
			
			// check if the menu has enough space on the bottom
			if (this.y + _body.height + _head.height > stage.stageHeight)
			{
				_mask.y = 0;
				_mask.x = _head.width;
				_mask.rotation = 180;
				
				maskW = _head.width;
				maskH = -_body.y;
			}
			else
			{
				_mask.y = _head.height;
				_mask.x = 0;
				_mask.rotation = 0;
				
				maskW = _head.width;
				maskH = _body.height + _body.y - _head.height;
			}
			
			_mask.graphics.clear();
			_mask.graphics.beginFill(0x009900, 1);
			_mask.graphics.drawRect(0, 0, maskW, maskH);
			_mask.graphics.endFill();
			
			_width = maskW;
			_height = maskH + _head.height;
			dispatchSize();
		}
		
		private function dispatchSize():void
		{
			this.dispatchEvent(new MenuEvent(MenuEvent.RESIZE));
		}
		
		private function onItemSelected(e:MenuEvent):void
		{
			//trace(e.currentTarget.currPicked.id);
			//trace(e.param.title)
			//trace(e.param.label)
			//trace(e.param.address)
			
			// update the head label
			_head.updateLabel(e.param.label);
			
			var data:Object = e.param;
			data.id = e.currentTarget.currPicked.id;
			this.dispatchEvent(new MenuEvent(MenuEvent.SELECTED, null, data));
			this.close();
		}
	}
	
}