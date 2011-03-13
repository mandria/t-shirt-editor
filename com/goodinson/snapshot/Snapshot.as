package com.goodinson.snapshot
{
	import com.ipnotica.utils.Config;
	import com.goodinson.snapshot.*;
	import com.adobe.images.*;
	import com.dynamicflash.util.Base64;
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import flash.display.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.events.*;
	import flash.utils.ByteArray;
	
	

	public class Snapshot
	{
		// supported image file types
		public static const JPG:String = "jpg";
		public static const PNG:String = "png";
		
		// supported server-side actions
		public static const DISPLAY:String = "display";
		public static const PROMPT:String = "prompt";
		public static const LOAD:String = "load";
		
		// default parameters
		private static const JPG_QUALITY_DEFAULT:uint = 80;
		private static const PIXEL_BUFFER:uint = 1;
		private static const PIXEL_BUFFER2:uint = 1;
		private static const DEFAULT_FILE_NAME:String = 'snapshot';
		
		// path to server-side script
		public static var gateway:String;
		
public static function capture2(target:DisplayObject, target2:DisplayObject, options:Object):void
		{
		trace("snapshot2 level")
		Config.doc.preloader.label.text = "Saving Images";
			
						////////////////////////////////////////////		

	function httpstat (event:*):void {
	//options.err.appendText("\n");
	trace("Response: " + event.type);
	trace("\n");
	trace("\n");
	trace("data recived: " + event);
	if (event.status=="200"){
	trace("\n");
	trace("status 200 = ok :)");
	}
	
}


function error2 (event:*):void {
	trace("\n");
	trace("Error: " + event.type);
	trace("\n");
	trace("data received : " + event);	
}

function onImageSent ( pEvt:Event ):void 

{

	var loader:URLLoader  = URLLoader ( pEvt.target );
	switch(loader.dataFormat) {
                case URLLoaderDataFormat.TEXT :
                    trace("completeHandler (text): " + loader.data);
                    break;
                case URLLoaderDataFormat.BINARY :
                    trace("completeHandler (binary): " + loader.data);
                    break;
                case URLLoaderDataFormat.VARIABLES :
                    trace("completeHandler (variables): " + loader.data);
                    break;
      }
	//loader.dataFormat = URLLoaderDataFormat.VARIABLES;
	var myVars:URLVariables = new URLVariables ( loader.data );
	trace("\n");
	trace("is saved: "+myVars.upload);
	trace("\n");
	trace("size: "+myVars.path);
	trace("\n");
	trace("filename: "+myVars.name);
	trace("\n");
 if(myVars.upload=="true"){
	var UnimeURL:URLRequest = new URLRequest ("http://www.tshirtpersonalizzate.com/store/carrello");
	navigateToURL(UnimeURL, "_parent");
 } else {
 Config.doc.preloader.label.text = "Server Error";
 TweenLite.to(Config.doc.preloader, 0.5, { alpha:0, delay:0, ease: Strong.easeOut });
TweenLite.delayedCall(1, function(){Config.doc.preloader.visible = false});

 }
 
 
 
}


function uploadCompleteDataSave (event:DataEvent) {
	trace("\n");
	trace("upload return data function : " + event);
	trace("\n");
	trace("data received : " + event.data);
	
	var UnimeURL:URLRequest = new URLRequest ("http://www.tshirtpersonalizzate.com/store/carrello");
	navigateToURL(UnimeURL, "_parent");
}
			
			var relative:DisplayObject = target;
			var relative2:DisplayObject = target2;

			// get target bounding rectangle
			var rect:Rectangle = target.getBounds(relative);
			var rect2:Rectangle = target2.getBounds(relative2);

			// capture within bounding rectangle; add a 1-pixel buffer around the perimeter to ensure that all anti-aliasing is included
			var bitmapData:BitmapData = new BitmapData(rect.width + PIXEL_BUFFER * 2, rect.height + PIXEL_BUFFER * 2);
			var bitmapData2:BitmapData = new BitmapData(rect2.width + PIXEL_BUFFER2 * 2, rect2.height + PIXEL_BUFFER2 * 2);
			
			// capture the target into bitmapData
			bitmapData.draw(relative, new Matrix(1, 0, 0, 1, -rect.x + PIXEL_BUFFER, -rect.y + PIXEL_BUFFER));
			bitmapData2.draw(relative2, new Matrix(1, 0, 0, 1, -rect2.x + PIXEL_BUFFER2, -rect2.y + PIXEL_BUFFER2));
			
			// encode image to ByteArray
			var byteArray:ByteArray;
			var byteArray2:ByteArray;

			switch (options.format)
			{
				case JPG:
				default:
				// encode as JPG
				var jpgEncoder:JPGEncoder = new JPGEncoder(JPG_QUALITY_DEFAULT);
				var jpgEncoder2:JPGEncoder = new JPGEncoder(JPG_QUALITY_DEFAULT);
				byteArray = jpgEncoder.encode(bitmapData);
				byteArray2 = jpgEncoder2.encode(bitmapData2);

				break;
				
				case PNG:
				// encode as PNG
				byteArray = PNGEncoder.encode(bitmapData);
				byteArray2 = PNGEncoder.encode(bitmapData2);

				break;
			}
			
			// convert binary ByteArray to plain-text, for transmission in POST data
			var byteArrayAsString:String = Base64.encodeByteArray(byteArray);
			var byteArrayAsString2:String = Base64.encodeByteArray(byteArray2);

			// constuct server-side URL to which to send image data
			//var url:String = gateway + '?' + Math.random();
			var url:String = gateway;
			
			// determine name of file to be saved / displayed
			var fileName:String = DEFAULT_FILE_NAME + '.' + options.format;
			
			// create URL request
			var request:URLRequest = new URLRequest(url);
			
			// send data via POST method
			request.method = URLRequestMethod.POST;
			
			// set data to send
			var variables:URLVariables = new URLVariables();
			variables.format = options.format;
			variables.action = options.action;
			variables.fileName = fileName;
			variables.image = byteArrayAsString;			
			variables.image2 = byteArrayAsString2;
			variables.sid = options.sid;
			variables.jid = options.jid;
			variables.uid = options.uid;
			variables.ref_prodotto=options.productID;
			variables.prezzo = options.prezzo;
			//variables.xml = options.xml;
			request.data = variables;
			trace("vsr passed in post:"+ variables)
			if (options.action == LOAD)
			{
			var myURLLoader:URLLoader = new URLLoader();
			myURLLoader.addEventListener(Event.COMPLETE, onImageSent );
			myURLLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpstat); // richiamato nel caso di errore generato dal fallimento nell'upload
			myURLLoader.addEventListener(IOErrorEvent.IO_ERROR, error2); // richiamato se l'upload fallisce per errore di comunicazione con il file di upload lato server
			myURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error2); // richiamato in caso di violazione delle regole di sicurezza del flash player
			myURLLoader.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteDataSave); // verifica delle informazioni ricevute dal server sull'avvenuto upload nel server
			myURLLoader.load( request );
			} else {
			trace("error NOT ACTION LOAD");
			}
		}
		//////end capture
		
		
		
		public static function capture(target:DisplayObject, options:Object):void
		{
		trace("snapshot1 level")
		Config.doc.preloader.label.text = "Saving Image";
			
						////////////////////////////////////////////		

	function httpstat (event:*):void {
	//options.err.appendText("\n");
	trace("Response: " + event.type);
	trace("\n");
	trace("\n");
	trace("data recived: " + event);
	if (event.status=="200"){
	trace("\n");
	trace("status 200 = ok :)");
	}
	
}


function error2 (event:*):void {
	trace("\n");
	trace("Error: " + event.type);
	trace("\n");
	trace("data received : " + event);	
}

function onImageSent ( pEvt:Event ):void 

{

	var loader:URLLoader  = URLLoader ( pEvt.target );
	switch(loader.dataFormat) {
                case URLLoaderDataFormat.TEXT :
                    trace("completeHandler (text): " + loader.data);
                    break;
                case URLLoaderDataFormat.BINARY :
                    trace("completeHandler (binary): " + loader.data);
                    break;
                case URLLoaderDataFormat.VARIABLES :
                    trace("completeHandler (variables): " + loader.data);
                    break;
      }
	//loader.dataFormat = URLLoaderDataFormat.VARIABLES;
	var myVars:URLVariables = new URLVariables ( loader.data );
	trace("\n");
	trace("is saved: "+myVars.upload);
	trace("\n");
	trace("size: "+myVars.path);
	trace("\n");
	trace("filename: "+myVars.name);
	trace("\n");
 if(myVars.upload=="true"){
	var UnimeURL:URLRequest = new URLRequest ("http://www.tshirtpersonalizzate.com/store/carrello");
	navigateToURL(UnimeURL, "_parent");
 } else {
 Config.doc.preloader.label.text = "Server Error";
 TweenLite.to(Config.doc.preloader, 0.5, { alpha:0, delay:0, ease: Strong.easeOut });
TweenLite.delayedCall(1, function(){Config.doc.preloader.visible = false});

 }
 
 
 
}


function uploadCompleteDataSave (event:DataEvent) {
	trace("\n");
	trace("upload return data function : " + event);
	trace("\n");
	trace("data received : " + event.data);
	
	var UnimeURL:URLRequest = new URLRequest ("http://www.tshirtpersonalizzate.com/store/carrello");
	navigateToURL(UnimeURL, "_parent");
}
			
			var relative:DisplayObject = target;

			// get target bounding rectangle
			var rect:Rectangle = target.getBounds(relative);

			// capture within bounding rectangle; add a 1-pixel buffer around the perimeter to ensure that all anti-aliasing is included
			var bitmapData:BitmapData = new BitmapData(rect.width + PIXEL_BUFFER * 2, rect.height + PIXEL_BUFFER * 2);
			
			// capture the target into bitmapData
			bitmapData.draw(relative, new Matrix(1, 0, 0, 1, -rect.x + PIXEL_BUFFER, -rect.y + PIXEL_BUFFER));
			
			// encode image to ByteArray
			var byteArray:ByteArray;

			switch (options.format)
			{
				case JPG:
				default:
				// encode as JPG
				var jpgEncoder:JPGEncoder = new JPGEncoder(JPG_QUALITY_DEFAULT);
				byteArray = jpgEncoder.encode(bitmapData);

				break;
				
				case PNG:
				// encode as PNG
				byteArray = PNGEncoder.encode(bitmapData);

				break;
			}
			
			// convert binary ByteArray to plain-text, for transmission in POST data
			var byteArrayAsString:String = Base64.encodeByteArray(byteArray);

			// constuct server-side URL to which to send image data
			//var url:String = gateway + '?' + Math.random();
			var url:String = gateway;
			
			// determine name of file to be saved / displayed
			var fileName:String = DEFAULT_FILE_NAME + '.' + options.format;
			
			// create URL request
			var request:URLRequest = new URLRequest(url);
			
			// send data via POST method
			request.method = URLRequestMethod.POST;
			
			// set data to send
			var variables:URLVariables = new URLVariables();
			variables.format = options.format;
			variables.action = options.action;
			variables.fileName = fileName;
			variables.image = byteArrayAsString;			
			variables.sid = options.sid;
			variables.jid = options.jid;
			variables.uid = options.uid;
			variables.ref_prodotto=options.productID;
			variables.prezzo = options.prezzo;
			//variables.xml = options.xml;
			request.data = variables;
			trace("vsr passed in post:"+ variables)
			if (options.action == LOAD)
			{
			var myURLLoader:URLLoader = new URLLoader();
			myURLLoader.addEventListener(Event.COMPLETE, onImageSent );
			myURLLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpstat); // richiamato nel caso di errore generato dal fallimento nell'upload
			myURLLoader.addEventListener(IOErrorEvent.IO_ERROR, error2); // richiamato se l'upload fallisce per errore di comunicazione con il file di upload lato server
			myURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error2); // richiamato in caso di violazione delle regole di sicurezza del flash player
			myURLLoader.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteDataSave); // verifica delle informazioni ricevute dal server sull'avvenuto upload nel server
			myURLLoader.load( request );
			} else {
			trace("error NOT ACTION LOAD");
			}
		}

		
		//////// enc capture one
		
		
	}
}