package com.doitflash.utils.bg
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Bg class extends Sprite and by setting its properties, you can have different kinds of backgrounds.
	 * @see BgType
	 * 
	 * @author Hadi Tavakoli - December 16, 2009
	 * @version 3.0
	 * @example To create a red background of type <code>BgType.SIMPLE_COLOR</code> which is 100px wide and 100px heigh:
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.utils.bg.Bg;
	 * import com.doitflash.utils.bg.BgType;
	 * import com.doitflash.utils.bg.BgConst;
	 * 
	 * var myBg:Bg = new Bg(BgType.SIMPLE_COLOR);
	 * myBg.auto = false; // default is true.
	 * myBg.w = 100;
	 * myBg.h = 100;
	 * myBg.curves = [0, 0, 0, 0];
	 * myBg.simpleColor = 0x990000;
	 * myBg.strokeThickness = 1;
	 * myBg.strokeColor = 0x000000;
	 * 
	 * mc.addChildAt(myBg, 0); // mc can be any displayObject or the stage(or the document class) itself.
	 * </listing>
	 * 
	 * @example The following example will load an external image and put it on top-left of your object which you want to put 
	 * the background on it and then repeats that image horizentally and vertically with a consideration of 5px margine from all sides.
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.utils.bg.Bg;
	 * import com.doitflash.utils.bg.BgType;
	 * import com.doitflash.utils.bg.BgConst;
	 * 
	 * var myBg:Bg = new Bg(BgType.IMAGE);
	 * myBg.path = "bg.png"; // path to the external file.
	 * myBg.location = BgConst.TL;
	 * myBg.curves = [0, 0, 0, 0];
	 * myBg.marginLeft = 0;
	 * myBg.marginTop = 0;
	 * myBg.marginRight = 0;
	 * myBg.marginBottom = 0;
	 * myBg.repeat = BgConst.REPEAT;
	 * 
	 * mc.addChildAt(myBg, 0); // mc can be any displayObject or the stage(or the document class) itself.
	 * </listing>
	 * 
	 * @example The following example will create a glassy Aero effect like vista. It can be added to any movieclip or sprite but don't try
	 * it on the stage.
	 * <listing version="3.0">
	 * import com.doitflash.utils.bg.Bg;
	 * import com.doitflash.utils.bg.BgType;
	 * 
	 * var myBg:Bg = new Bg(BgType.GLASSY);
	 * myBg.glassColor = 0x5e7cc1;
	 * myBg.glassAlpha = 0.3;
	 * myBg.glassBlur = 15;
	 * myBg.glassBlurQuality = 1;
	 * myBg.holder = mc; // This bg effect needs to know its holder which is <code>mc</code> in this example.
	 * myBg.marginLeft = 0;
	 * myBg.marginTop = 0;
	 * myBg.marginRight = 0;
	 * myBg.marginBottom = 0;
	 * myBg.curves = [0, 0, 0, 0];
	 * 
	 * mc.addChildAt(myBg, 0); // mc can be any displayObject but the stage.
	 * </listing>
	 */
	public class Bg extends Sprite
	{
		private var _containor:Sprite = new Sprite();
		private var _theBg:*;
		
		private var _isStageTheHolder:Boolean;
		
		private var _bgWidth:Number = 200;
		private var _bgHeight:Number = 200;
		private var _auto:Boolean = true;
		private var _type:String = BgType.SIMPLE_COLOR;
		
		// properties for SimpleColorBg
		private var _simpleColor:uint = 0xFFFFFF;
		private var _strokeThickness:Number = 0;
		private var _strokeColor:uint = 0x000000;
		
		// Properties for ImgBg
		private var _path:String;
		private var _location:String = BgConst.TL;
		private var _bgImgMargL:Number = 0;
		private var _bgImgMargT:Number = 0;
		private var _bgImgMargR:Number = 0;
		private var _bgImgMargB:Number = 0;
		private var _bgImgRepeat:String = BgConst.NONE;
		
		// Properties for GlassyBg
		private var _holder:*;
		private var _glassColor:uint = 0x000000;
		private var _glassAlpha:Number = 0.3;
		private var _glassBlur:Number = 15;
		private var _glassBlurQuality:Number = 1;
		
		// General properties
		private var _curveTopLeft:Number = 0;
		private var _curveTopRight:Number = 0;
		private var _curveBottomLeft:Number = 0;
		private var _curveBottomRight:Number = 0;
		
		/**
		 * Constructor function.
		 * @param $type indicates the type of background, default value is <code>BgType.SIMPLE_COLOR</code>
		 * 
		 * @see	BgType
		 */
		public function Bg($type:String=BgType.SIMPLE_COLOR):void
		{
			// save the _type value
			_type = $type;
			
			// add the containor to the class
			this.addChild(_containor);
			
			// listen and create the bg when its added to the stage
			this.addEventListener(Event.ADDED_TO_STAGE, stageHandeler);
			
			// listen to the time that the bg is removed from the project
			this.addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		}
		
//////////////////////////////////////////////////////////////////////////////////// getter - setter
		
		/**
		 * Indicates the width of the bg.
		 * @default 200
		 */
		public function get w():Number
		{
			return _bgWidth;
		}
		
		/**
		 * @private
		 */
		public function set w(a:Number):void
		{
			if (_bgWidth != a) // make sure the value is updated
			{
				_bgWidth = a;
				if (_theBg != undefined && _theBg != null)
				{
					create();
					_theBg.w = _bgWidth;
					
				}
				
			}
		}
		
		/**
		 * Indicates the height of the bg.
		 * @default 200
		 */
		public function get h():Number
		{
			return _bgHeight;
		}
		
		/**
		 * 
		 * @private
		 */
		public function set h(a:Number):void
		{
			if (_bgHeight != a) // make sure the value is updated
			{
				_bgHeight = a;
				if (_theBg != undefined && _theBg != null)
				{
					create();
					_theBg.h = _bgHeight;
				}
				
			}
		}
		
		/**
		 * if <code>true</code>, bg will automatically resize itself to the container
		 * and if <code>false</code>, bg will resize itself to the specified width and height.
		 * @default true
		 */
		public function get auto():Boolean
		{
			return _auto;
		}
		
		/**
		 * 
		 * @private
		 */
		public function set auto(a:Boolean):void
		{
			if (_auto != a)  // make sure the value is updated
			{
				_auto = a;
				create();
			}
		}
		
		/**
		 * indicates the type of background.
		 * @default BgType.SIMPLE_COLOR
		 * @see BgType
		 */
		public function set type(a:String):void
		{
			if (_type != a)
			{
				_type = a;
				create();
			}
		}
		
		/**
		 * color of the bg. works only when <code>type</code> is set to
		 * <code>BgType.SIMPLE_COLOR</code>.
		 * @default 0xFFFFFF
		 * @see BgType
		 */
		public function get simpleColor():uint
		{
			return _simpleColor;
		}
		
		/**
		 * @private
		 */
		public function set simpleColor(a:uint):void
		{
			if (_simpleColor != a) // make sure the value is updated
			{
				_simpleColor = a;
				create();
			}
		}
		
		/**
		 * Indicates the stroke thickness.
		 * @default 0
		 */
		public function get strokeThickness():Number
		{
			return _strokeThickness
		}
		
		/**
		 * @private
		 */
		public function set strokeThickness(a:Number):void
		{
			if (_strokeThickness != a)
			{
				_strokeThickness = a;
				create();
			}
		}
		
		/**
		 * Indicates the color of the stroke.
		 * @default 0x000000
		 */
		public function get strokeColor():uint
		{
			return _strokeColor;
		}
		
		/**
		 * @private
		 */
		public function set strokeColor(a:uint):void
		{
			if (_strokeColor != a)
			{
				_strokeColor = a;
				create();
			}
		}
		
		/**
		 * The path to the location of the background image. when the type is
		 * <code>BgType.IMAGE</code>.
		 * @default null
		 */
		public function get path():String
		{
			return _path;
		}
		
		/**
		 * 
		 * @private
		 */
		public function set path(a:String):void
		{
			if (_path != a) // make sure the value is updated
			{
				_path = a;
				create();
			}
		}
		
		/**
		 * choose the position of the bg file. when the type is
		 * <code>BgType.IMAGE</code>.
		 * @default BgConst.TL
		 * @see BgConst
		 */
		public function set location(a:String):void
		{
			if (_location != a)
			{
				_location = a;
				create();
			}
		}
		
		/**
		 * left margin value.
		 * @default 0
		 */
		public function set marginLeft(a:Number):void
		{
			if (_bgImgMargL != a)
			{
				_bgImgMargL = a;
				create();
			}
		}
		
		/**
		 * top margin value.
		 * @default 0
		 */
		public function set marginTop(a:Number):void
		{
			if (_bgImgMargT != a)
			{
				_bgImgMargT = a;
				create();
			}
		}
		
		/**
		 * right margin value.
		 * @default 0
		 */
		public function set marginRight(a:Number):void
		{
			if (_bgImgMargR != a)
			{
				_bgImgMargR = a;
				create();
			}
		}
		
		/**
		 * bottom margin value.
		 * @default 0
		 */
		public function set marginBottom(a:Number):void
		{
			if (_bgImgMargB != a)
			{
				_bgImgMargB = a;
				create();
			}
		}
		
		/**
		 * indicates the repeating status of the bg image. when the type is
		 * <code>BgType.IMAGE</code>.
		 * @default BgConst.NONE
		 * @see BgConst
		 */
		public function set repeat(a:String):void
		{
			if (_bgImgRepeat != a)
			{
				_bgImgRepeat = a;
				create();
			}
		}
		
		/**
		 * indicates the color of the glassy effect. when the type is
		 * <code>BgType.GLASSY</code>.
		 * @default 0x0080FF
		 */
		public function set glassColor(a:uint):void
		{
			if (_glassColor != a) // make sure the value is updated
			{
				_glassColor = a;
				create();
			}
		}
		
		/**
		 * indicates the alpha transparenty of the glassy effect. when the type is
		 * <code>BgType.GLASSY</code>.
		 * @default 0.5
		 */
		public function set glassAlpha(a:Number):void
		{
			if (_glassAlpha != a) // make sure the value is updated
			{
				_glassAlpha = a;
				create();
			}
		}
		
		/**
		 * indicates the glass blur amount. when the type is
		 * <code>BgType.GLASSY</code>.
		 * @default 15
		 */
		public function set glassBlur(a:Number):void
		{
			if (_glassBlur != a)
			{
				_glassBlur = a;
				create();
			}
		}
		
		/**
		 * indicates the blur quality of the glass. when the type is
		 * <code>BgType.GLASSY</code>.
		 * @default 1	0 means no blur and 15 is the max blur quality.
		 */
		public function set glassBlurQuality(a:Number):void
		{
			if ( _glassBlurQuality != a)
			{
				_glassBlurQuality = a;
				create();
			}
		}
		
		/**
		 * When the type is set to <code>BgType.GLASSY</code>. you need to introduce the holder also.
		 * Please note that the holder is not necesserilly the container where the bg is added to.
		 * Imagine having a popup window in your project and you are trying to add this bg class to the
		 * popup only. maybe the bg is added to somewhere like <code>stage.popup.mc1.mc2</code>. as you see the class
		 * parent is <code>mc2</code> but because the background is logically being used for the whole popup, then you must specify
		 * the popup as its holder.<br><br>
		 * 
		 * to give you more insight, please notice that in order to generate the glassy effect, the class is actually taking a screenshot
		 * from the stage and its clear that it must not include itself in the screenshot. so when you specify the <code>holder</code>, you
		 * are actually excluding that object from the screenshot taking operation.
		 */
		public function set holder(a:*):void
		{
			_holder = a;
			create();
		}
		
		/**
		 * sets curve degree for all four corners of the background.
		 */
		public function set curves(a:Array):void
		{
			_curveTopLeft = a[0];
			_curveTopRight = a[1];
			_curveBottomLeft = a[2];
			_curveBottomRight = a[3];
			
			create();
		}
		
//////////////////////////////////////////////////////////////////////////////////// Methods
		
		/**
		 * sets curve degree for all four corners of the background.
		 * @param	$topLeft
		 * @param	$topRight
		 * @param	$bottomLeft
		 * @param	$bottomRight
		 */
		public function curve($topLeft:Number=0, $topRight:Number=0, $bottomLeft:Number=0, $bottomRight:Number=0):void
		{
			_curveTopLeft = $topLeft;
			_curveTopRight = $topRight;
			_curveBottomLeft = $bottomLeft;
			_curveBottomRight = $bottomRight;
			
			create();
		}
		
//////////////////////////////////////////////////////////////////////////////////// private functions
		
		private function stageHandeler(e:Event = null):void
		{
			// remove the stage listener
			this.removeEventListener(Event.ADDED_TO_STAGE, stageHandeler);
			
			// start creating the bg
			create();
		}
		
		private function onStageRemove(e:Event = null):void
		{
			killListeners();
			emptyTheContainor();
			_isStageTheHolder = false;
			this.addEventListener(Event.ADDED_TO_STAGE, stageHandeler);
		}
		
		private function create():void
		{
			if (stage)
			{
				// before creating anything, lets kill all listeners just to keep the code clean!
				killListeners();
				
				// also make sure the _containor is empty
				emptyTheContainor();
				
				// check if the stage is the holder of our bg?
				if (this.parent.parent == this.stage || this.parent == this.stage)
				{
					_isStageTheHolder = true;
				}
				
				// check the bg type and set the bg texture
				_theBg = checkType();
				
				// set bg dimention
				setDimention();
				
				// add the bg to the containor
				_containor.addChild(_theBg);
			}
		}
		
		private function killListeners():void
		{
			this.stage.removeEventListener(Event.RESIZE, onStageResize);
			this.removeEventListener(Event.ENTER_FRAME, onHolderResizing);
		}
		
		private function emptyTheContainor():void
		{
			for (var i:int = 0; i < _containor.numChildren; i++)
			{
				_containor.removeChildAt(i);
			}
		}
		
		private function checkType():Sprite
		{
			var theBg:*;
			
			switch (_type) 
			{
				case BgType.SIMPLE_COLOR:
				
					theBg = new SimpleColorBg();
					theBg.simpleColor = _simpleColor;
					theBg.strokeThickness = _strokeThickness;
					theBg.strokeColor = _strokeColor;
				
				break;
				
				case BgType.IMAGE:
				
					theBg = new ImgBg();
					theBg.path = _path;
					theBg.location = _location;
					theBg.marginLeft = _bgImgMargL;
					theBg.marginTop = _bgImgMargT;
					theBg.marginRight = _bgImgMargR;
					theBg.marginBottom = _bgImgMargB;
					theBg.repeat = _bgImgRepeat;
				
				break;
				
				case BgType.GLASSY:
				
					theBg = new GlassyBg();
					theBg.glassColor = _glassColor;
					theBg.glassAlpha = _glassAlpha;
					theBg.glassBlur = _glassBlur;
					theBg.glassBlurQuality = _glassBlurQuality;
					theBg.holder = _holder;
				
				break;
			}
			
			theBg.curve(_curveTopLeft, _curveTopRight, _curveBottomLeft, _curveBottomRight);
			
			return theBg;
		}
		
		private function setDimention():void
		{
			if (_auto)
			{
				if (_isStageTheHolder)
				{
					// listen to stage resizing
					this.stage.addEventListener(Event.RESIZE, onStageResize);
					
					// set the size for the first time
					onStageResize();
				}
				else
				{
					// listen to the holder's resizing
					this.addEventListener(Event.ENTER_FRAME, onHolderResizing);
					
					// set the size for the first time
					onHolderResizing();
				}
			}
			else 
			{
				_theBg.w = _bgWidth;
				_theBg.h = _bgHeight;
			}
		}
		
		private function onStageResize(e:Event=null):void
		{
			_theBg.w = this.stage.stageWidth;
			_theBg.h = this.stage.stageHeight;
		}
		
		private function onHolderResizing(e:Event=null):void
		{
			if (_strokeThickness > 0)
			{
				_theBg.w = this.parent.width - _strokeThickness;
				_theBg.h = this.parent.height - _strokeThickness;
			}
			else
			{
				_theBg.w = this.parent.width;
				_theBg.h = this.parent.height;
			}
		}
	}
	
}