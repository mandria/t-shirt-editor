package com.goodinson.snapshot
{
	import com.goodinson.snapshot.*;
	import com.adobe.images.*;
	import com.dynamicflash.util.Base64;
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
		private static const DEFAULT_FILE_NAME:String = 'snapshot';
		
		// path to server-side script
		public static var gateway:String;
		

		
		public static function capture(target:DisplayObject, target2:DisplayObject, options:Object):void
		{
			
			
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
	trace("is saved: "+myVars.result);
	trace("\n");
	trace("size: "+myVars.size);
	trace("\n");
	trace("filename: "+myVars.filename);
	trace("\n");
	trace("date: "+myVars.date);
	trace("\n");
    trace("sid: "+myVars.sid);
	trace("  jid: "+myVars.jid);

}


function uploadCompleteDataSave (event:DataEvent) {
	trace("\n");
	trace("upload return data function : " + event);
	trace("\n");
	trace("data received : " + event.data);
}
/////////////////////////////////////////////
			
			
			
			
			var relative:DisplayObject = target.parent;
			var relative2:DisplayObject = target2.parent;

			// get target bounding rectangle
			var rect:Rectangle = target.getBounds(relative);
			var rect2:Rectangle = target2.getBounds(relative2);

			// capture within bounding rectangle; add a 1-pixel buffer around the perimeter to ensure that all anti-aliasing is included
			var bitmapData:BitmapData = new BitmapData(rect.width + PIXEL_BUFFER * 2, rect.height + PIXEL_BUFFER * 2);
			var bitmapData2:BitmapData = new BitmapData(rect2.width + PIXEL_BUFFER * 2, rect2.height + PIXEL_BUFFER * 2);
			
			// capture the target into bitmapData
			bitmapData.draw(relative, new Matrix(1, 0, 0, 1, -rect.x + PIXEL_BUFFER, -rect.y + PIXEL_BUFFER));
			bitmapData2.draw(relative2, new Matrix(1, 0, 0, 1, -rect2.x + PIXEL_BUFFER, -rect2.y + PIXEL_BUFFER));
			
			// encode image to ByteArray
			var byteArray:ByteArray;
			var byteArray2:ByteArray;

			switch (options.format)
			{
				case JPG:
				// encode as JPG
				var jpgEncoder:JPGEncoder = new JPGEncoder(JPG_QUALITY_DEFAULT);
				var jpgEncoder2:JPGEncoder = new JPGEncoder(JPG_QUALITY_DEFAULT);
				byteArray = jpgEncoder.encode(bitmapData);
				byteArray2 = jpgEncoder2.encode(bitmapData2);

				break;
				
				case PNG:
				default:
				// encode as PNG
				byteArray = PNGEncoder.encode(bitmapData);
				byteArray2 = PNGEncoder.encode(bitmapData2);

				break;
			}
			
			// convert binary ByteArray to plain-text, for transmission in POST data
			var byteArrayAsString:String = Base64.encodeByteArray(byteArray);
			var byteArrayAsString2:String = Base64.encodeByteArray(byteArray2);

			// constuct server-side URL to which to send image data
			var url:String = gateway + '?' + Math.random();
			
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
			variables.ref_prodotto=options.productID;
			variables.prezzo = options.prezzo;
			variables.ref_cliente = options.sid;
			variables.xml = options.xml;
			request.data = variables;
			
			if (options.action == LOAD)
			{
				// load image back into loadContainer
				//options.loader.load(request);
				//
				
			//var pURLLoader:URLLoader = new URLLoader();
				//pURLLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			//pURLLoader.addEventListener( Event.COMPLETE, mainTimeLine.uploadCompleteDataSave );
				//pURLLoader.addEventListener( IOErrorEvent.IO_ERROR, sendIOError );
				// URLLoader to send bytes to the server
			var myURLLoader:URLLoader = new URLLoader();
			myURLLoader.addEventListener(Event.COMPLETE, onImageSent );
			myURLLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpstat); // richiamato nel caso di errore generato dal fallimento nell'upload
			myURLLoader.addEventListener(IOErrorEvent.IO_ERROR, error2); // richiamato se l'upload fallisce per errore di comunicazione con il file di upload lato server
			myURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error2); // richiamato in caso di violazione delle regole di sicurezza del flash player
			myURLLoader.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteDataSave); // verifica delle informazioni ricevute dal server sull'avvenuto upload nel server
			myURLLoader.load( request );
				
			//dispatchEvent (uploadCompleteData,true);
				
			} else
			{
				trace("error UU NOT ACTION LOAD");
				//navigateToURL(request, "_blank");
				//navigateToURL(request, "_blank");
			}
		}
	}
}