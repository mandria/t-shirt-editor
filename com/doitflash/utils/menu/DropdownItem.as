package com.doitflash.utils.menu
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.utils.setTimeout;
	
	import com.doitflash.consts.LangDirection;
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	import com.doitflash.events.ButtonEvent;
	import com.doitflash.utils.button.BgBtn;
	
	import com.doitflash.utils.bg.BgType;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 4/9/2010 6:41 PM
	 */
	public class DropdownItem extends Sprite
	{
		private var _id:int;
		
		private var _width:Number = 150;
		private var _height:Number = 30;
		
		private var _xml:XML;
		
		// general settings for the menu texts
		private var _embedFonts:Boolean = false;
		//private var _indent:Number = 5;
		private var _fontName:String = "Tahoma";
		private var _txtColor:uint = 0x000000;
		private var _txtSize:Number = 13;
		private var _txtDirection:String = LangDirection.LTR;
		private var _bgAlpha:Number = 1;
		
		private var _label:String = "item";
		private var _address:String = "#";
		private var _title:String = "title";
		
		private var _btn:BgBtn;
		private var _defaultPick:Boolean = false;
		
		public function DropdownItem():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, stageRemoved);
		}
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Getter - Setter

		/**
		 * Indicates the id of this item
		 */
		public function get id():int
		{
			return _id;
		}
		
		/**
		 * @private
		 */
		public function set id(a:int):void
		{
			_id = a;
		}
		
		/**
		 * Indicates the width of this item
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
		 * Indicates the height of this item
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
		 * This will set if the fonts are to be embeded or not.
		 * 
		 * @see DropdownMenu#embedFonts()
		 */
		public function set embedFonts (a:Boolean):void
		{
			_embedFonts = a;
		}
		
		/**
		 * This will receive all item's details and save them.
		 */
		public function set xml(a:XML):void
		{
			_xml = a;
			
			// overwrite the values from xml if available
			if (_xml.@font != undefined && _xml.@font != "") _fontName = _xml.@font;
			if (_xml.@color != undefined && _xml.@color != "") _txtColor = _xml.@color;
			if (_xml.@size != undefined && _xml.@size != "") _txtSize = _xml.@size;
			if (_xml.@direction != undefined && _xml.@direction != "") _txtDirection = _xml.@direction;
			if (_xml.@defaultPick != undefined && _xml.@defaultPick != "") _defaultPick = convertToBoolean(_xml.@defaultPick);
			if (_xml.@alpha != undefined && _xml.@alpha != "") _bgAlpha = _xml.@alpha;
			
			if (_xml.@label != undefined && _xml.@label != "") _label = _xml.@label;
			if (_xml.@address != undefined && _xml.@address != "") _address = _xml.@address;
			if (_xml.@title != undefined && _xml.@title != "") _title = _xml.@title;
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Methods

		/**
		 * This method saves the final text styling to be used for this item.
		 * 
		 * @param	$font
		 * @param	$color
		 * @param	$size
		 * @param	$direction
		 */
		public function saveTxtSetting($font:String, $color:uint, $size:Number, $direction:String):void
		{
			_fontName = $font;
			_txtColor = $color;
			_txtSize = $size;
			_txtDirection = $direction;
		}
		
		/**
		 * This method picks this item.
		 * @param	$manual
		 */
		public function pick($manual:Boolean=true):void
		{
			if($manual)_btn.removeEventListener(ButtonEvent.INACTIVE, onInactive);
			_btn.activated = false;
		}
		
		/**
		 * use this method to unpick this item.
		 */
		public function unPick():void
		{
			_btn.addEventListener(ButtonEvent.INACTIVE, onInactive);
			_btn.activated = true;
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Protected

		

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// Private

		private function stageRemoved(e:Event):void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageAdded);
		}
		
		private function stageAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, stageAdded);
			
			drawPlaceHolder();
			
			buildBtn();
			
			buildTxt();
		}
		
		private function drawPlaceHolder():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0xFF9900, 0);
			//this.graphics.lineStyle(1, 0x9988AA)
			this.graphics.drawRect(0, 0, _width, _height);
			this.graphics.endFill();
		}
		
		private function buildBtn():void
		{
			_btn = new BgBtn(_width, _height);
			_btn.alpha = _bgAlpha;
			_btn.handCursor = true;
			_btn.id = _id;
			
			//_btn.setUpSkin("glassyBg", { holder:this, glassColor:0xFFFFFF, glassAlpha:0.3, glassBlurQuality:3, glassBlur:10 } );
			//_btn.setOverSkin("simpleColorBg", { simpleColor:0x789955, strokeThickness:1, strokeColor:0x0000 } );
			//_btn.setDownSkin("simpleColorBg", { simpleColor:0xFF0055, strokeThickness:1, strokeColor:0x0000 } );
			applyButtonSkins(); // reads skins from xml
			
			_btn.addEventListener(ButtonEvent.CLICK, onClick);
			_btn.addEventListener(ButtonEvent.INACTIVE, onInactive);
			_btn.addEventListener(ButtonEvent.ACTIVE, onActive);
			
			if (_defaultPick)_btn.activated = false;
			this.addChild(_btn);
		}
		
		private function applyButtonSkins():void
		{
			var obj:Object = new Object();
			var type:String = _xml.upSkin.@type;
			for (var i:int = 0; i < _xml.upSkin.@ * .length(); i++ )
			{
				if (_xml.upSkin.@ * [i].name() != "type")
				{
					var name:String = _xml.upSkin.@ * [i].name();
					var value:String = _xml.upSkin.@ * [i];
					obj[name] = value;
					
					obj.holder = this;
				}
			}
			if (type)_btn.setUpSkin(type, obj);
			type = null;
			obj = null;
				
			obj = new Object();
			type = _xml.overSkin.@type;
			for (i = 0; i < _xml.overSkin.@ * .length(); i++ )
			{
				if (_xml.overSkin.@ * [i].name() != "type")
				{
					name = _xml.overSkin.@ * [i].name();
					value = _xml.overSkin.@ * [i];
					obj[name] = value;
					
					obj.holder = this;
				}
			}
			if (type)_btn.setOverSkin(type, obj);
			type = null;
			obj = null;
				
			obj = new Object();
			type = _xml.downSkin.@type;
			for (i = 0; i < _xml.downSkin.@ * .length(); i++ )
			{
				if (_xml.downSkin.@ * [i].name() != "type")
				{
					name = _xml.downSkin.@ * [i].name();
					value = _xml.downSkin.@ * [i];
					obj[name] = value;
					
					obj.holder = this;
				}
			}
			if (type)_btn.setDownSkin(type, obj);
			type = null;
		}
		
		private function convertToBoolean($value:String):Boolean
		{
			if ($value == "true")
			{
				return true
			}
			
			return false;
		}
		
		private function buildTxt():void
		{
			var format:TextFormat = new TextFormat();
			format.color = _txtColor;
			format.size = _txtSize;
			format.font = _fontName;
			
			var text:TextField = new TextField();
			text.embedFonts = _embedFonts;
			text.selectable = false;
			text.mouseEnabled = false;
			text.defaultTextFormat = format;
			text.autoSize = TextFieldAutoSize.LEFT;
			text.antiAliasType = AntiAliasType.ADVANCED;
			text.htmlText = _label;
			
			this.addChild(text);
			
			text.x = 5;
			text.y = _height / 2 - text.height / 2;
		}
		
		private function onInactive(e:ButtonEvent):void
		{
			_defaultPick = true;
			this.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK, e.item, {label:_label, address:_address, title:_title}));
		}
		
		private function onActive(e:ButtonEvent):void
		{
			_defaultPick = false;
		}
		
		private function onClick(e:ButtonEvent):void
		{
			this.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK, e.item, {label:_label, address:_address, title:_title}));
		}
	}
	
}