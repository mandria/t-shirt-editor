/*
This class has been put together by me, Hadi Tavakoli, and it's actually a combination
of the other two classes which I have named their authors below this line!

Because the other two autors have put their work online for free, I have also put this new
class for free on my blog: http://www.emstris.com/2009/05/extracting-binary-info/

You may also use the class and even improve it with no limitation :) and I'd be happy to
be notified if you are doing something interesting with the class.

	* One idea is to make it support .swf files also so we can generate .swf binary info too
	UPDATE, November 2009: I have now upgraded the code and now it does analyze .swf files also

Thanks,
Hadi



USAGE 1 >> locading a file externally:

	import com.doitflash.tools.fileAnalyzer.FileAnalyzer;
	
	var myAnalyzer:FileAnalyzer = new FileAnalyzer();
	myAnalyzer.addEventListener(FileAnalyzer.PARSE_COMPLETE, infoHandler);
	myAnalyzer.addEventListener(FileAnalyzer.PARSE_FAILED, errorHandler);
	myAnalyzer.file = "file.jpg";
	
	function infoHandler(e:Event):void
	{
		trace(myAnalyzer.fileType)
	}
				
	function errorHandler(e:Event):void
	{
		trace( "Size could not be obtained, file was not according to JFIF specification" );
	}



USAGE 2 >> analyze using the file bytes:





Copyright (c) 2007 Antti Kupila.
http://www.anttikupila.com/flash/getting-jpg-dimensions-with-as3-without-loading-the-entire-file/
URL: http://www.anttikupila.com

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.



	   * ImageInfo.as
	   http://blog.onebyonedesign.com/?p=71
	   * 
	   * 2/17/2008 10:37 AM
	   * 
	   * Retries metadata from .png, .jpg, and .gif files.
	   * 
	   * Based on java class, ImageInfo.java, by Marco Schmidt
	   * (http://schmidt.devlib.org/image-info/)
	   * 
	   * @author    Devon O.
	   * @version   .1
*/



package com.doitflash.tools.fileAnalyzer
{

	import flash.utils.ByteArray;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import com.senocular.utils.SWFReader;

	public class FileAnalyzer extends EventDispatcher
	{
		public static const PARSE_COMPLETE:String = "parseComplete";
		public static const PARSE_FAILED:String = "parseFailed";
		
		private var _file:String;
		private var request:URLRequest;
		private var imageStream:URLStream;
		private var ba:ByteArray = new ByteArray();
		private var _size:String;

		// image properties
		private var _width:int;
		private var _height:int;
		private var _bitsPerPixel:int;
		private var _progressive:Boolean;
		private var _physicalWidth:String;
		private var _physicalHeight:String;
		private var _physicalHeightDpi:int;
		private var _physicalWidthDpi:int;
		private var _fileType:String;
		private var _mimeType:String;
		
		// swf properties
		private var mySwfReader:SWFReader;
		private var _swfInfo:Object = new Object();
		private var _swfCompression:Boolean;
		private var _swfVersion:uint;
		private var _swfFrameRate:uint;
		private var _swfTotalFrames:uint;
		private var _swfAsVersion:uint;
		private var _swfUsesNetwork:Boolean;
		private var _swfBackgroundColor:uint;
		private var _swfProtectedFromImport:Boolean;
		private var _swfDebuggerEnabled:Boolean;
		private var _swfMetaData:XML;
		private var _swfRecursionLimit:uint;
		private var _swfScriptTimeoutLimit:uint;
		private var _swfHardwareAcceleration:uint;

		private var _stream:ByteArray;
		private var _format:int;

		private const FILE_TYPES:Array = ["JPEG","GIF","PNG", "SWF"];
		private const MIME_TYPES:Array = ["image/jpeg", "image/gif", "image/png", "application/x-shockwave-flash"];

		private const FORMAT_JPEG:int = 0;
		private const FORMAT_GIF:int = 1;
		private const FORMAT_PNG:int = 2;
		private const FORMAT_SWF:int = 3;

		public function FileAnalyzer():void
		{
			
		}
		
		// send the file bytes to analyze
		public function set fileByte(a:ByteArray):void
		{
			if (checkType(a))
			{
				dispatchEvent(new Event(PARSE_COMPLETE));
			}
			else
			{
				dispatchEvent(new Event(PARSE_FAILED));
			}
		}
		
		// send the file path to analyze
		public function set file(a:String):void
		{
			_file = a;
			
			imageStream = new URLStream();
			request = new URLRequest(_file);
			
			imageStream.addEventListener(ProgressEvent.PROGRESS, onFileProgress);
			imageStream.addEventListener(Event.COMPLETE, onFileDone);
			imageStream.load(request);
		}
		
		public function get size():String
		{
			return _size;
		}
		
		private function onFileProgress(e:ProgressEvent):void 
		{
			_size = Math.floor(e.bytesTotal/1024) + " kb";
			var percent:Number = Math.floor(e.bytesLoaded / e.bytesTotal) * 100;
				
			if (percent > 1){
				
				imageStream.readBytes(ba);
				if (checkType(ba)) {
							
					dispatchEvent(new Event(PARSE_COMPLETE));
					imageStream.close();
						
				}else{
					dispatchEvent(new Event(PARSE_FAILED));
				}
			}
		
		}
		
		private function onFileDone(e:Event):void 
		{
			
		}
		

		/**
		       * 
		       * @param   ByteArray of image file
		       * @return   True for valid .jpg, .png, and .gif images - false otherwise.
		       */
		private function checkType(bytes:ByteArray):Boolean
		{
			// I used the software "Free Hex Editor" to read the first two bytes of the file!
			
			_stream = bytes;

			var b1:int = read() & 0xFF;
			var b2:int = read() & 0xFF;
			//var b3:int = read() & 0xFF;
			
			if (b1 == 0x47 && b2 == 0x49) {
				return checkGif();
			}

			if (b1 == 0xFF && b2 == 0xD8) {
				return checkJPG();
			}

			if (b1 == 0x89 && b2 == 0x50) {
				return checkPng();
			}
			
			if (b1 == 0x43 && b2 == 0x57 /*&& b3 == 0x53*/){
				return checkSwf(); // compressed swf
			}
			
			if (b1 == 0x46 && b2 == 0x57 /*&& b3 == 0x53*/){
				return checkSwf(); // uncompressed swf
			}

			return false;
		}

		private function checkGif():Boolean
		{
			var GIF_MAGIC_87A:ByteArray = new ByteArray  ;
			GIF_MAGIC_87A.writeByte(0x46);
			GIF_MAGIC_87A.writeByte(0x38);
			GIF_MAGIC_87A.writeByte(0x37);
			GIF_MAGIC_87A.writeByte(0x61);

			var GIF_MAGIC_89A:ByteArray = new ByteArray  ;
			GIF_MAGIC_89A.writeByte(0x46);
			GIF_MAGIC_89A.writeByte(0x38);
			GIF_MAGIC_89A.writeByte(0x39);
			GIF_MAGIC_89A.writeByte(0x61);

			var a:ByteArray = new ByteArray  ;
			if (read(a,0,11) != 11) {
				return false;
			}

			if (! equals(a,0,GIF_MAGIC_89A,0,4) && ! equals(a,0,GIF_MAGIC_87A,0,4)) {
				return false;
			}

			_format = FORMAT_GIF;
			_width = getShortLittleEndian(a,4);
			_height = getShortLittleEndian(a,6);
			var flags:int = a[8] & 0xFF;
			_bitsPerPixel = flags >> 4 & 0x07 + 1;
			//_progressive = flags & 0x02 != 0;
			_progressive = true; // it keeps on keeping an compiler error so I just commented it to get rid of it! I don't think I would ever need to know if the file is progressive or not! :)

			return true;
		}

		private function checkPng():Boolean
		{
			var PNG_MAGIC:ByteArray = new ByteArray  ;
			PNG_MAGIC.writeByte(0x4E);
			PNG_MAGIC.writeByte(0x47);
			PNG_MAGIC.writeByte(0x0D);
			PNG_MAGIC.writeByte(0x0A);
			PNG_MAGIC.writeByte(0x1A);
			PNG_MAGIC.writeByte(0x0A);

			var a:ByteArray = new ByteArray  ;
			if (read(a,0,27) != 27) {
				return false;
			}

			if (! equals(a,0,PNG_MAGIC,0,6)){
				return false;
			}

			_format = FORMAT_PNG;
			
			_width = getIntBigEndian(a,14);
			_height = getIntBigEndian(a,18);
			_bitsPerPixel = a[22];
			var colorType:int = a[23];
			if (colorType == 2 || colorType == 6) {
				_bitsPerPixel *= 3;
			}
			_progressive=a[26]!=0;
			return true;
		}

		private function checkJPG():Boolean
		{
			var APP0_ID:ByteArray=new ByteArray  ;
			APP0_ID.writeByte(0x4A);
			APP0_ID.writeByte(0x46);
			APP0_ID.writeByte(0x49);
			APP0_ID.writeByte(0x46);
			APP0_ID.writeByte(0x00);

			var data:ByteArray=new ByteArray  ;
			while (true)
			{

				if (read(data,0,4)!=4) {
					return false;
				}

				var marker:Number=getShortBigEndian(data,0);
				var size:Number=getShortBigEndian(data,2);

				if (marker&0xff00!=0xff00) {
					return false;
				}

				if (marker==0xFFE0) {

					if (size<14) {
						skip(size-2);
						continue;
					}

					if (read(data,0,12)!=12) {
						return false;
					}

					if (equals(APP0_ID,0,data,0,5)) {

						if (data[7]==1) {
							setPhysicalWidthDpi(getShortBigEndian(data,8));
							setPhysicalHeightDpi(getShortBigEndian(data,10));

						} else if (data[7]==2) {
							var x:int=getShortBigEndian(data,8);
							var y:int=getShortBigEndian(data,10);

							setPhysicalWidthDpi(int(x*2.54));
							setPhysicalHeightDpi(int(y*2.54));
						}
					}
					skip(size-14);

				} else if (marker>=0xFFC0&&marker<=0xFFCF&&marker!=0xFFC4&&marker!=0xFFC8) {

					if (read(data,0,6)!=6) {
						return false;
					}

					_format=FORMAT_JPEG;
					_bitsPerPixel=data[0]&0xFF*data[5]&0xFF;
					_progressive = marker == 0xffc2 || marker == 0xffc6 || marker == 0xffca || marker == 0xffce;
					_width=getShortBigEndian(data,3);
					_height=getShortBigEndian(data,1);
					var horzPixelsPerCM:Number=_physicalWidthDpi/2.54;
					var vertPixelsPerCM:Number=_physicalHeightDpi/2.54;
					_physicalWidth = (_width/horzPixelsPerCM).toFixed(2);
					_physicalHeight = (_height/vertPixelsPerCM).toFixed(2);

					return true;
				} else {
					skip(size-2);
				}
			}
			return false;
		}
		
		private function checkSwf():Boolean
		{
			_format = FORMAT_SWF;
			mySwfReader = new SWFReader(ba);
			
			// save the swf information
			_width = mySwfReader.dimensions.width;
			_height = mySwfReader.dimensions.height;
			_swfInfo.compressed = _swfCompression = mySwfReader.compressed;
			_swfInfo.version = _swfVersion = mySwfReader.version;
			_swfInfo.frameRate = _swfFrameRate = mySwfReader.frameRate;
			_swfInfo.totalFrames = _swfTotalFrames = mySwfReader.totalFrames;
			_swfInfo.asVersion = _swfAsVersion = mySwfReader.asVersion;
			_swfInfo.usesNetwork = _swfUsesNetwork =  mySwfReader.usesNetwork;
			_swfInfo.backgroundColor = _swfBackgroundColor = mySwfReader.backgroundColor;
			_swfInfo.protectedFromImport = _swfProtectedFromImport = mySwfReader.protectedFromImport;
			_swfInfo.debuggerEnabled = _swfDebuggerEnabled = mySwfReader.debuggerEnabled;
			_swfInfo.metadata = _swfMetaData = mySwfReader.metadata;
			_swfInfo.recursionLimit = _swfRecursionLimit = mySwfReader.recursionLimit;
			_swfInfo.scriptTimeoutLimit = _swfScriptTimeoutLimit = mySwfReader.scriptTimeoutLimit;
			_swfInfo.hardwareAcceleration = _swfHardwareAcceleration = mySwfReader.hardwareAcceleration;
			
			return true;
		}
	
		private function getShortBigEndian(ba:ByteArray,offset:int):Number
		{
			return ba[offset]<<8|ba[offset+1];
		}

		private function getShortLittleEndian(ba:ByteArray,offset:int):int
		{
			return ba[offset]|ba[offset+1]<<8;
		}

		private function getIntBigEndian(ba:ByteArray,offset:int):int
		{
			return ba[offset]<<24|ba[offset+1]<<16|ba[offset+2]<<8|ba[offset+3];
		}

		private function skip(numBytes:int):void
		{
			_stream.position+=numBytes;
		}

		private function equals(ba1:ByteArray,offs1:int,ba2:ByteArray,offs2:int,num:int):Boolean
		{
			while (num-->0)
			{
				if (ba1[offs1++]!=ba2[offs2++]) {
					return false;
				}
			}
			return true;
		}

		private function read(... args):int
		{
			switch (args.length) {
				case 0 :
					return _stream.readByte();
					break;
				case 1 :
					_stream.readBytes(args[0]);
					return args[0].length;
					break;
				case 3 :
					_stream.readBytes(args[0],args[1],args[2]);
					return args[2];
					break;
				default :
					throw new ArgumentError("Argument Error at FileAnalyzer.read(). Expected 0, 1, or 3. Received "+args.length);
					return null;
			}
		}

		private function setPhysicalHeightDpi(newValue:int):void
		{
			_physicalWidthDpi=newValue;
		}

		private function setPhysicalWidthDpi(newValue:int):void
		{
			_physicalHeightDpi=newValue;
		}

		//   vertical and horizontal DPI
		public function get physicalHeightDpi():int
		{
			return _physicalHeightDpi;
		}

		public function get physicalWidthDpi():int
		{
			return _physicalWidthDpi;
		}

		//   bit depth
		public function get bitsPerPixel():int
		{
			return _bitsPerPixel;
		}

		//   width and height in pixels
		public function get height():int
		{
			return _height;
		}

		public function get width():int
		{
			return _width;
		}

		//   progressive or not
		public function get progressive():Boolean
		{
			return _progressive;
		}

		//   file and mimetype
		public function get fileType():String
		{
			return FILE_TYPES[_format];
		}

		public function get mimeType():String
		{
			return MIME_TYPES[_format];
		}

		//   height and width in centimeters
		public function get physicalWidth():String
		{
			return _physicalWidth;
		}

		public function get physicalHeight():String
		{
			return _physicalHeight;
		}
		
		public function get swfInfo():Object
		{
			return _swfInfo;
		}
	}
}