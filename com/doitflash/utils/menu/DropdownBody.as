package com.doitflash.utils.menu
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import com.doitflash.utils.bg.Bg;
	import com.doitflash.utils.bg.BgType;
	import com.doitflash.utils.bg.BgConst;
	
	import com.doitflash.utils.lists.List;
	import com.doitflash.events.ListEvent;
	import com.doitflash.events.MenuEvent;
	import com.doitflash.events.ButtonEvent;
	
	import com.doitflash.consts.LangDirection;
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	
	import flash.utils.getDefinitionByName;
	
	/**
	 * The DropdownBody class is used and initialized by <code>DropdownMenu</code> class.
	 * This class is responsible for creating the menu's body and its content. This class
	 * is actually parsing the xml data. if you are trying to extend this class, to pars
	 * a new style of an xml file, make sure to extend DropdownMenu also, because that class 
	 * will initialize this one.
	 * 
	 * @author Hadi Tavakoli - 4/8/2010 7:12 PM
	 */
	public class DropdownBody extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		
		protected var _contentWidth:Number;
		protected var _contentHeight:Number;
		
		private var _myBg:Bg;
		private var _bgAlpha:Number = 1;
		private var _body:Sprite; // the _list will drop into this
		private var _mainContent:XML; // the whole xml data needed for creating the menu
		private var _list:List;
		private var _itemsArray:Array;
		private var _listSpace:Number = 2;
		private var _listSpeed:Number = .5;
		
		protected var _scrollInstance:*;
		protected var _scrollClassString:String;
		protected var _scrollClass:Class;
		protected var _haveScroll:Boolean = false;
		private var runtimeScroll:*;
		
		// general settings for the menu texts
		private var _embedFonts:Boolean = false;
		private var _indent:Number = 5;
		private var _fontName:String = "Tahoma";
		private var _txtColor:uint = 0x000000;
		private var _txtSize:Number = 13;
		private var _txtDirection:String = LangDirection.LTR;
		
		private var _currPicked:*;
		private var _oldPicked:*;
		
		public function DropdownBody():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, stageRemoved);
			
			// use the Bg class to create bg
			createBg();
		}
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter

		/**
		 * Indicates the width of the menu's body
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
			//super.width = a;
			_width = a;
		}
		
		/**
		 * Indicates the height of the menu's body
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
			//super.height = a;
			_height = a;
		}
		
		/**
		 * Indicates the transparency value of the body.
		 */
		public function set bgAlpha(a:Number):void
		{
			_bgAlpha = a;
			_myBg.alpha = _bgAlpha;
		}
		
		/**
		 * Indicates if the body has a scrollbar ready to use.
		 */
		public function get haveScroll():Boolean
		{
			return _haveScroll;
		}
		
		/**
		 * Shows the xml data being used by this class to build the items.
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
			createBody();
		}
		
		/**
		 * Introduces the URL location of the xml file. This class will pars the xml data and sends required info to
		 * <code>DropdownItem</code>.
		 * 
		 * @see DropdownItem
		 */
		public function set contentPath(a:String):void
		{
			var _xmlLoader:URLLoader = new URLLoader();
			_xmlLoader.load(new URLRequest(a));
			_xmlLoader.addEventListener(Event.COMPLETE, loadXMLDone);
		}
		
		/**
		 * This will set if the fonts are to be embeded or not.
		 * 
		 * @see DropdownMenu#embedFonts()
		 */
		public function set embedFonts(a:Boolean):void
		{
			_embedFonts = a;
		}
		
		/**
		 * returns a reference to the currently selected item in the menu.
		 */
		public function get currPicked():Object
		{
			return _currPicked;
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		/**
		 * to import scrollbar when having the scrollbar instance and its class string name.
		 * 
		 * @param	$scroll
		 * @param	$classString
		 * 
		 * @see DropdownMenu#importScroll()
		 */
		public function importScroll($scroll:*, $classString:String):void
		{
			_scrollInstance = $scroll;
			_scrollClassString = $classString;
			
			installScrollbar();
		}
		
		/**
		 * to import scrollbar when having the scrollbar instance and its class.
		 * 
		 * @param	$scroll
		 * @param	$class
		 * 
		 * @see DropdownMenu#importScrollClass()
		 */
		public function importScrollClass($scroll:*, $class:Class):void
		{
			_scrollInstance = $scroll;
			_scrollClass = $class;
			
			installScrollbar();
		}
		
		/**
		 * if a scrollbar is installed, remove it by this function
		 * 
		 * @param	$scroll
		 * @param	$class
		 * 
		 * @see DropdownMenu#removeScroll()
		 */
		public function removeScroll():void
		{
			uninstallScrollbar();
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
		 * This method sets the Bg for the body.
		 * 
		 * @param	$type
		 * @param	$prop
		 * 
		 * @see DropdownMenu#setBodyBg()
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
						trace("There is no property named 'param' >> Class: com.doitflash.utils.menu.DropdownBody, Function: setBg")
					}
				}
			}
		}
		
		/**
		 * This method sets the general text styling for the body. these values will be overwritten
		 * by the styles from the xml.
		 * 
		 * @param	$font
		 * @param	$color
		 * @param	$size
		 * @param	$direction
		 * 
		 * @see DropdownMenu#setTxtStyle()
		 */
		public function setTxtStyle($font:String, $color:uint, $size:Number, $direction:String=LangDirection.LTR):void
		{
			_fontName = $font;
			_txtColor = $color;
			_txtSize = $size;
			_txtDirection = $direction;
		}
		
		/**
		 * Use this method to pick an item in the menu.
		 * 
		 * @param	$id
		 */
		public function pick($id:int):void
		{
			var item:Object = _itemsArray[$id];
			item.pick(false);
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected

		/**
		 * This method is responsible for parsing the xml.
		 */
		protected function parsXML():void
		{
			// overwrite default valuse from xml
			if (_mainContent.@indent != undefined && _mainContent.@indent != "") _indent = _mainContent.@indent;
			if (_mainContent.@listSpeed != undefined && _mainContent.@listSpeed != "") _listSpeed = _mainContent.@listSpeed;
			if (_mainContent.@listSpace != undefined && _mainContent.@listSpace != "") _listSpace = _mainContent.@listSpace;
			if (_mainContent.@font != undefined && _mainContent.@font != "") _fontName = _mainContent.@font;
			if (_mainContent.@color != undefined && _mainContent.@color != "") _txtColor = _mainContent.@color;
			if (_mainContent.@size != undefined && _mainContent.@size != "") _txtSize = _mainContent.@size;
			if (_mainContent.@direction != undefined && _mainContent.@direction != "") _txtDirection = _mainContent.@direction;
		}
		
		/**
		 * To actually use the xml to build the items, this is the method for the work. it uses the class <code>DropdownItem</code>.
		 */
		protected function toBuildUpItems():void
		{
			var items:XMLList = _mainContent.item;
			_itemsArray = new Array();
			
			for (var i:int = 0; i < items.length(); i++ )
			{
				var myItem:DropdownItem = new DropdownItem();
				myItem.addEventListener(ButtonEvent.CLICK, onSelect);
				myItem.id = i;
				myItem.x = 0;
				myItem.y = 0;
				myItem.width = _contentWidth;
				myItem.height = items[i].@height;
				myItem.embedFonts = _embedFonts;
				
				myItem.saveTxtSetting(_fontName, _txtColor, _txtSize, _txtDirection);
				myItem.xml = items[i];
				
				// save a reference to the item in _itemsArray
				_itemsArray.push(myItem);
				
				// add the item to the List class
				_list.add(myItem, NaN);
			}
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private

		private function installScrollbar():void
		{
			_contentWidth = _width;
			_contentHeight = _height;
			
			// if we havethe instance and the string
			if (stage && _scrollInstance && _scrollClassString != null)
			{
				if (!_haveScroll)
				{
					var RuntimeScrollClass:Class = getDefinitionByName(_scrollClassString) as Class;
					runtimeScroll = new RuntimeScrollClass();
					runtimeScroll.x = _indent;
					runtimeScroll.y = _indent;
					this.addChild(runtimeScroll as Sprite);
					runtimeScroll.maskContent = _body;
					//runtimeScroll.drawDisabledScroll = true;
					_haveScroll = true;
				}
				
				runtimeScroll.importProp = _scrollInstance.exportProp; // import the properties
				
				//trace(runtimeScroll.scrollBarWidth)
				_contentWidth = _width - 11 - runtimeScroll.btnSpace - (_indent * 2);
				_contentHeight = _height - (_indent*2);
				
				runtimeScroll.maskWidth = _contentWidth;
				runtimeScroll.maskHeight = _contentHeight;
			}
			// if we have the instance and the class
			else if (stage && _scrollInstance && _scrollClass)
			{
				if (!_haveScroll)
				{
					runtimeScroll = new _scrollClass();
					runtimeScroll.x = _indent;
					runtimeScroll.y = _indent;
					this.addChild(runtimeScroll as Sprite);
					runtimeScroll.maskContent = _body;
					//runtimeScroll.drawDisabledScroll = true;
					_haveScroll = true;
				}
				
				runtimeScroll.importProp = _scrollInstance.exportProp; // import the properties
				
				//trace(runtimeScroll.scrollBarWidth)
				_contentWidth = _width - 11 - runtimeScroll.btnSpace - (_indent * 2);
				_contentHeight = _height - (_indent*2);
				
				runtimeScroll.maskWidth = _contentWidth;
				runtimeScroll.maskHeight = _contentHeight;
			}
		}
		
		private function uninstallScrollbar():void
		{
			// if we havethe instance and the string
			if (stage && _scrollInstance && _scrollClassString != null)
			{
				if (_haveScroll)
				{
					
					this.addChild(_body);
					this.removeChild(runtimeScroll);
					
					_haveScroll = false;
				}
				
				_scrollInstance = null;
				_scrollClassString = null;
				runtimeScroll = null;
			}
			// if we have the instance and the class
			else if (stage && _scrollInstance && _scrollClass)
			{
				if (_haveScroll)
				{
					
					this.addChild(_body);
					this.removeChild(runtimeScroll);
					
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
			
			removeBg();
			cleanUp(_body);
			cleanUp(this);
		}
		
		private function stageAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, stageAdded);
			
			// draw a place holder so the background can work on the dimension
			drawPlaceHolder();
			
			_body = new Sprite();
			this.addChild(_body);
			
			createBody();
		}
		
		private function drawPlaceHolder():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x990000, 0);
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
			
			//_myBg.type = BgType.IMAGE;
			//_myBg.path = "bg.png";
			//_myBg.location = BgConst.TL;
			//_myBg.marginLeft = 0;
			//_myBg.marginTop = 0;
			//_myBg.marginRight = 0;
			//_myBg.marginBottom = 0;
			//_myBg.repeat = BgConst.NONE;
			
			//_myBg.type = BgType.SIMPLE_COLOR;
			//_myBg.simpleColor = 0x000000;
			//_myBg.strokeThickness = 1;
			//_myBg.strokeColor = 0xFFFFFF;
			//_myBg.curve(0, 0, 0, 0);
		}
		
		private function cleanUp($target:Sprite):void
		{
			for (var i:int = $target.numChildren-1; i >= 0; i--)
			{
				$target.removeChildAt(i);
			}
		}
		
		private function createBody():void
		{
			if (stage && _mainContent)
			{
				// clean the _body first
				cleanUp(_body);
				
				// pars the xml
				parsXML(); // protected
				
				// initialize the List class
				initList(); // private
				
				installScrollbar();
				
				// add items into the list
				toBuildUpItems(); // protected
			}
		}
		
		private function initList():void
		{
			_list = new List();
			_list.addEventListener(ListEvent.RESIZE, onResize);
			_list.x = 0;
			_list.y = 0;
			_list.direction = Direction.LEFT_TO_RIGHT;
			_list.orientation = Orientation.VERTICAL;
			_list.space = _listSpace;
			_list.speed = _listSpeed;
			_body.addChild(_list);
		}
		
		private function loadXMLDone(e:Event):void
		{
			_mainContent = new XML(e.target.data);
			createBody();
		}
		
		private function onResize(e:ListEvent):void
		{
			//_list.width;
			//_list.height;
		}
		
		private function onSelect(e:ButtonEvent):void
		{
			if (_oldPicked)_oldPicked.unPick();
			
			_currPicked = e.currentTarget as Object;
			_currPicked.pick();
			_oldPicked = _currPicked;
			
			this.dispatchEvent(new MenuEvent(MenuEvent.SELECTED, null, e.param));
		}
	}
	
}