package com.doitflash.utils.bg
{
	import com.doitflash.tools.fileAnalyzer.FileAnalyzer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import org.gif.player.GIFPlayer;
	import org.gif.events.FrameEvent;
	import org.gif.events.GIFPlayerEvent;
	import org.gif.events.GifProgressEvent;
	import org.gif.frames.GIFFrame;
	
	/**
	 * @author Hadi Tavakoli
	 * @private
	 */
	public class ImgBg extends Sprite
	{
		private var _bgWidth:Number;
		private var _bgHeight:Number;
		private var _path:String;
		private var _location:String = BgConst.TL;
		private var _bgImgMargL:Number;
		private var _bgImgMargT:Number;
		private var _bgImgMargR:Number;
		private var _bgImgMargB:Number;
		private var _bgImgRepeat:String;
		
		private var _isFileLoaded:Boolean = false;
		private var _imgBitmapData:BitmapData;
		private var _BitmapDataArray:Array;
		
		private var _imgLoader:Loader;
		private var _gifLoader:GIFPlayer;
		
		private var _curveTopLeft:Number = 0;
		private var _curveTopRight:Number = 0;
		private var _curveBottomLeft:Number = 0;
		private var _curveBottomRight:Number = 0;
		
		/**
		 * Constructor function
		 */
		public function ImgBg():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, stageHandeler);
			
		}
		
/////////////////////////////////////////////////////////////////////////////// getter - setter
		
		public function set w(a:Number):void
		{
			if (_bgWidth != a) // make sure the value is updated
			{
				_bgWidth = a;
				toAddBgImg(_imgBitmapData);
			}
		}
		
		public function set h(a:Number):void
		{
			if (_bgHeight != a) // make sure the value is updated
			{
				_bgHeight = a;
				toAddBgImg(_imgBitmapData);
			}
		}
		
		public function set path(a:String):void
		{
			if (_path != a) // make sure the value is updated
			{
				_path = a;
				create();
			}
		}
		
		public function set location(a:String):void
		{
			if (_location != a)
			{
				_location = a;
				toAddBgImg(_imgBitmapData);
			}
		}
		
		/**
		 * left margin value
		 * @default 0
		 */
		public function set marginLeft(a:Number):void
		{
			if (_bgImgMargL != a)
			{
				_bgImgMargL = a;
				toAddBgImg(_imgBitmapData);
			}
		}
		
		/**
		 * top margin value
		 * @default 0
		 */
		public function set marginTop(a:Number):void
		{
			if (_bgImgMargT != a)
			{
				_bgImgMargT = a;
				toAddBgImg(_imgBitmapData);
			}
		}
		
		/**
		 * right margin value
		 * @default 0
		 */
		public function set marginRight(a:Number):void
		{
			if (_bgImgMargR != a)
			{
				_bgImgMargR = a;
				toAddBgImg(_imgBitmapData);
			}
		}
		
		/**
		 * bottom margin value
		 * @default 0
		 */
		public function set marginBottom(a:Number):void
		{
			if (_bgImgMargB != a)
			{
				_bgImgMargB = a;
				toAddBgImg(_imgBitmapData);
			}
		}
		
		public function set repeat(a:String):void
		{
			if (_bgImgRepeat != a)
			{
				_bgImgRepeat = a;
				toAddBgImg(_imgBitmapData);
			}
		}
		
///////////////////////////////////////////////////////////////////////////// methods

		public function curve($topLeft:Number=0, $topRight:Number=0, $bottomLeft:Number=0, $bottomRight:Number=0):void
		{
			_curveTopLeft = $topLeft;
			_curveTopRight = $topRight;
			_curveBottomLeft = $bottomLeft;
			_curveBottomRight = $bottomRight;
			
			toAddBgImg(_imgBitmapData);
		}
		
/////////////////////////////////////////////////////////////////////////////// private functions
		
		private function stageHandeler(e:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, stageHandeler);
			
			create();
		}
		
		private function create():void
		{
			if (stage)
			{
				// analyze the file format
				if(_path != null) toAnalyzeThenLoad();
			}
		}
		
		private function toAnalyzeThenLoad():void
		{
			var myAnalyzer:FileAnalyzer = new FileAnalyzer();
			myAnalyzer.addEventListener(FileAnalyzer.PARSE_COMPLETE, anaLyzeInfoHandler);
			myAnalyzer.addEventListener(FileAnalyzer.PARSE_FAILED, anaLyzeErrorHandler);
			myAnalyzer.file = _path;
			
			function anaLyzeInfoHandler(e:Event):void
			{
				if (myAnalyzer.fileType == "GIF")
				{
					_gifLoader = new GIFPlayer();
					_gifLoader.addEventListener(FrameEvent.FRAME_RENDERED, onGifFrameLoad);
					_gifLoader.addEventListener(GIFPlayerEvent.COMPLETE, onGifLoadDone);
					_gifLoader.load(new URLRequest(_path));
				}
				else if (myAnalyzer.fileType == "PNG" || myAnalyzer.fileType == "JPEG")
				{
					_imgLoader = new Loader();
					_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImgLoadDone);
					_imgLoader.load(new URLRequest(_path));
				}
				else if (myAnalyzer.fileType == "SWF")
				{
					trace("SWF files are not supported at the moment.");
				}
			}
			
			function anaLyzeErrorHandler(e:Event):void
			{
				trace( "File was not according to JFIF specification and couldn't be analyzed." );
			}
		}
		
		private function onGifFrameLoad(e:FrameEvent):void
		{
			// smooth all of the frames
			var smooth:Bitmap = Bitmap(_gifLoader);
			smooth.smoothing = true;
			
			//trace("width = " + e.frame.bitmapData.width);
			//trace("height = " + e.frame.bitmapData.height);
			//trace("current frame = " + e.target.currentFrame);
			//trace("current frame delay = " + e.target.getDelay ( e.target.currentFrame ));
			//trace("current frame delay = " + _gifLoader.getDelay ( _gifLoader.currentFrame ));
			
			if(_isFileLoaded)
			{	
				// find out the gif disposeValue status and make the bitmap accordingly
				switch (_gifLoader.disposeValue) 
				{
					case 1:
						if ( !(e.target.currentFrame-1) ) _imgBitmapData = _BitmapDataArray[0].clone();
						_imgBitmapData.draw(_BitmapDataArray[e.target.currentFrame-1]);
					break;
					
					case 2:
						_imgBitmapData = _BitmapDataArray[e.target.currentFrame-1].clone();
					break;
				}
				
				// create bg image
				toAddBgImg(_imgBitmapData);
			}
		}
		
		private function onGifLoadDone(e:GIFPlayerEvent):void
		{
			//var FrameRect:Rectangle = e.rect;
			//trace("width = " + FrameRect.width);
			//trace("height = " + FrameRect.height);
			//trace("total frames = " + _gifLoader.totalFrames);
			//trace("Loop = " + _gifLoader.loopCount);
			
			// save the fact that the image is now loaded
			_isFileLoaded = true;
			
			// is the gif file animated or has just one frame?
			if(_gifLoader.totalFrames == 1)
			{
				// if we have only one frame, we don't need the frames listener at all!
				_gifLoader.removeEventListener(FrameEvent.FRAME_RENDERED, onGifFrameLoad);
				
				// save the only frame in a BitmapData objects
				_imgBitmapData = _gifLoader.frames[0].bitmapData.clone();
				toAddBgImg(_imgBitmapData);
			}
			else
			{
				// save all frames in an array full of BitmapData objects
				_BitmapDataArray = new Array();
				for(var i:int = 0; i < _gifLoader.totalFrames; i++)
				{
					var tmpBit:BitmapData = _gifLoader.frames[i].bitmapData.clone();
					_BitmapDataArray[i] = tmpBit;
				}
			}
		}
		
		private function onImgLoadDone(e:Event):void
		{
			// save the fact that the image is now loaded
			_isFileLoaded = true;
			
			// save the loaded image in a BitmapData object
			_imgBitmapData = new BitmapData(e.currentTarget.content.width, e.currentTarget.content.height, true, 0x00FFFFFF);
			_imgBitmapData.draw(e.currentTarget.content);
			
			// create bg image
			toAddBgImg(_imgBitmapData);
		}
		
		private function toAddBgImg($currBitmapData:BitmapData):void
		{
			if(_isFileLoaded)
			{
				// set the position of the image
				setLocation(this, _location, $currBitmapData.width, $currBitmapData.height);
				
				// set margines for the bg image
				setMargines(this, _location, _bgImgMargL, _bgImgMargT, _bgImgMargR, _bgImgMargB, $currBitmapData.width, $currBitmapData.height);
				
				// save the exact dimentions for the possible repeat areas considering all margines
				var possibleRepeatWidth:Number = _bgWidth - this.x - _bgImgMargR;
				var possibleRepeatHeight:Number = _bgHeight - this.y - _bgImgMargB;
				
				// clear any old graphics first
				this.graphics.clear();
				this.graphics.beginBitmapFill($currBitmapData, null, true, true); // repeat is always true actually
				
				var bestWidth:Number;
				var bestHeight:Number;
				
				// fake the repeat status by controling the image width and height
				if(_bgImgRepeat == BgConst.NONE)
				{
					if($currBitmapData.width > possibleRepeatWidth){
						bestWidth = possibleRepeatWidth;
					}else{
						bestWidth = $currBitmapData.width;
					}
					
					if($currBitmapData.height > possibleRepeatHeight){
						bestHeight = possibleRepeatHeight;
					}else{
						bestHeight = $currBitmapData.height;
					}
					
					this.graphics.drawRoundRectComplex(0, 0, bestWidth, bestHeight, _curveTopLeft, _curveTopRight, _curveBottomLeft, _curveBottomRight);
				}
				else if(_bgImgRepeat == BgConst.REPEAT)
				{
					this.graphics.drawRoundRectComplex(0, 0, possibleRepeatWidth, possibleRepeatHeight, _curveTopLeft, _curveTopRight, _curveBottomLeft, _curveBottomRight);
				}
				else if(_bgImgRepeat == BgConst.REPEAT_X)
				{
					if($currBitmapData.height > possibleRepeatHeight){
						bestHeight = possibleRepeatHeight;
					}else{
						bestHeight = $currBitmapData.height;
					}
					
					this.graphics.drawRoundRectComplex(0, 0, possibleRepeatWidth, bestHeight, _curveTopLeft, _curveTopRight, _curveBottomLeft, _curveBottomRight);
				}
				else if(_bgImgRepeat == BgConst.REPEAT_Y)
				{
					if($currBitmapData.width > possibleRepeatWidth){
						bestWidth = possibleRepeatWidth;
					}else{
						bestWidth = $currBitmapData.width;
					}
					
					this.graphics.drawRoundRectComplex(0, 0, bestWidth, possibleRepeatHeight, _curveTopLeft, _curveTopRight, _curveBottomLeft, _curveBottomRight);
				}
				
				this.graphics.endFill();
				
			}
		}
		
		private function setLocation(target:Sprite, position:String, w:Number, h:Number):void
		{
			switch(position)
			{
				case BgConst.TL:
					
					target.x = 0;
					target.y = 0;
					
				break;
				
				case BgConst.T:
					
					target.x = _bgWidth/2 - w/2;
					target.y = 0;
				
				break;
				
				case BgConst.TR:
					
					target.x = _bgWidth - w;
					target.y = 0;
					
				break;
				
				case BgConst.L:
					
					target.x = 0;
					target.y = _bgHeight/2 - h/2;
					
				break;
				
				case BgConst.M:
					
					target.x = _bgWidth/2 - w/2;
					target.y = _bgHeight/2 - h/2;
					
				break;
				
				case BgConst.R:
					
					target.x = _bgWidth - w;
					target.y = _bgHeight/2 - h/2;
					
				break;
				
				case BgConst.BL:
					
					target.x = 0;
					target.y = _bgHeight - h;
					
				break;
				
				case BgConst.B:
					
					target.x = _bgWidth/2 - w/2;
					target.y = _bgHeight - h;
					
				break;
				
				case BgConst.BR:
					
					target.x = _bgWidth - w;
					target.y = _bgHeight - h;
					
				break;
			}
		}
		
		private function setMargines(target:Sprite, position:String, l:Number, t:Number, r:Number, b:Number, w:Number, h:Number):void
		{
			// find out, if the "target" is within the reach for each of the margines? and move it only if it is!
			switch(position)
			{
				case BgConst.TL:
					
					y_bottom();
					y_top();
					x_right();
					x_left();
					
				break;
				
				case BgConst.T:
					
					y_bottom();
					y_top();
					x_right();
					x_left();
				
				break;
				
				case BgConst.TR:
					
					y_bottom();
					y_top();
					x_left();
					x_right();
					
				break;
				
				case BgConst.L:
					
					y_bottom();
					y_top();
					x_right();
					x_left();
					
				break;
				
				case BgConst.M:
					
					y_bottom();
					y_top();
					x_right();
					x_left();
					
				break;
				
				case BgConst.R:
					
					y_bottom();
					y_top();
					x_left();
					x_right();
					
				break;
				
				case BgConst.BL:
					
					y_top();
					y_bottom();
					x_right();
					x_left();
					
				break;
				
				case BgConst.B:
					
					y_top();
					y_bottom();
					x_right();
					x_left();
					
				break;
				
				case BgConst.BR:
					
					y_top();
					y_bottom();
					x_left();
					x_right();
					
				break;
			}
			
			
			function x_right():void
			{
				if(_bgWidth - r - w < target.x){
					target.x = _bgWidth - w - r;
				}
			}
			
			function x_left():void
			{
				if(l > target.x){
					target.x = l;
				}
			}
			
			function y_bottom():void
			{
				if(_bgHeight - b - h < target.y){
					target.y = _bgHeight - b - h;
				}
			}
			
			function y_top():void
			{
				if(t > target.y){
					target.y = t;
				}
			}
			
			
		}
	}
	
}