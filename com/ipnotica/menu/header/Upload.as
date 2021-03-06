// The button is based on this class
// http://www.myflashlab.com/2010/04/28/dropdownmenu-class/

package com.ipnotica.menu.header {
	
	import ascb.util.Tween;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.ipnotica.utils.Config;
	import com.ipnotica.utils.Utils;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.*;

	//import flash.net.URLLoader;
	//import flash.net.URLRequest;
	//import flash.net.URLRequestMethod
	//import flash.net.URLVariables;
	//import flash.net.FileReference;
	//import flash.net.FileReferenceList;
	//import flash.net.FileFilter;



	public class Upload extends MovieClip {
		
		public var numberOfCategories:Number = -1;
		var file:FileReference;
		var request:URLRequest;
		var url:String;
		
		public function Upload() {
			super();
			init();
		}
		
		private function init():void {
			this.buttonMode = true;
			TweenLite.delayedCall(0.1, initCategoriesXML);
			initEvents();
		}
		
		private function initEvents():void {
			//addEventListener(MouseEvent.CLICK, onClickUpload);
			file= new FileReference();
			url = "http://www.tshirtpersonalizzate.com/ajax-editor_upload.php";
			//var url:String = "http://www.tshirtpersonalizzate.com/tinotest/upload.php";
			// istanza di URLRequest che gestisce la comunicazione con il file esterno
			request= new URLRequest(url);
			addEventListener(MouseEvent.MOUSE_UP,buttonPressed);
			/* configurazione degli eventi associati all'upload del file
			inseriti nell'ordine in cui vengono richiamati se non ci sono intoppi */
			file.addEventListener(Event.SELECT, select); // selezione del file nella finestra di upload
			file.addEventListener(Event.OPEN, open); // inizio di upload del file
			file.addEventListener(ProgressEvent.PROGRESS, progress); // descrizione del progresso richiamata periodicamente durante l'upload
			file.addEventListener(Event.COMPLETE, complete); // completamento della trasmissione del file al server, completato
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteData); // verifica delle informazioni ricevute dal server sull'avvenuto upload nel server

			// configurazione degli eventi associati ad eventuali errori o scelte dell'utente che bloccano l'upload del file
			file.addEventListener(Event.CANCEL, error); // richiamato nel caso che venga cliccato "Annulla" nella finestra di scelta del file
			file.addEventListener(HTTPStatusEvent.HTTP_STATUS, error); // richiamato nel caso di errore generato dal fallimento nell'upload
			file.addEventListener(IOErrorEvent.IO_ERROR, error); // richiamato se l'upload fallisce per errore di comunicazione con il file di upload lato server
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error); // richiamato in caso di violazione delle regole di sicurezza del flash player
			
		}
		
		/** Load list of possible categories. This is needed to have the number of categories */
		public function initCategoriesXML():void {
			var rand:String="&rand="+Math.round(Math.random()*100000);
			var path:String = Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.categories + rand;
			var url:URLRequest = new URLRequest(path); 
			var loader:URLLoader = new URLLoader(url);
			loader.addEventListener(Event.COMPLETE, onCategoriesLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, Utils.onIOError);
		}
		
		/** If any, load the existing product we want to show */
		private function onCategoriesLoaded(e:Event):void {
			numberOfCategories = new XML(e.target.data).children().length() - 1;
		}
		

	

// Funzione richiamata dagli eventi che provocano errore
function error (event:*):void {
	//errmsg.appendText("\n");
	//errmsg.appendText("Errore di tipo: " + event.type);
	trace("Errore di tipo: " + event.type);
	
}



// Funzione richiamata quando il file viene selezionato
function select(event:Event):void {
	//errmsg.appendText("\n");
	//errmsg.appendText("select function: name=" + file.name + " URL=" + request.url);
	trace("select function: name=" + file.name + " URL=" + request.url);
	Config.doc.preloader.label.text = "Uploading the image";
	Config.doc.preloader.visible = true;
	TweenLite.to(Config.doc.preloader, 0.5, { alpha:1, delay:0, ease: Strong.easeOut });
	file.upload(request);
}
// Funzione richiamata ad inizio upload (o download)
function open(event:Event):void {
	//errmsg.appendText("\n");
	//errmsg.appendText("open function: " + event);
	trace("open function: " + event);
}

// Funzione richiamata dopo onOpen ad upload / download cominciato
function progress(event:ProgressEvent):void {
	//errmsg.appendText("\n");
	//errmsg.appendText("progress function name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
	trace("progress function name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
}

/* Funzione richiamata ad upload / download terminato.
Il file sul server avra' gia' elaborato quando questo metodo verra' richiamato. */
function complete(event:Event):void {
	//errmsg.appendText("\n");
	//errmsg.appendText("complete function : " + event);
	trace("complete function : " + event);
}

/* Funzione richiamata ad upload elaborato e terminato sul server
* L'evento contiene al suo interno una proprietà "data" che contiene la risposta del server
* e che è utile elaborare nel caso si voglia avere una conferma dell'upload avvenuto
* utile ad esempio nel caso che si voglia verificare che un determinato file non esista già 
* sul server e nel caso mostrare un warning all'utente */
function uploadCompleteData (event:DataEvent) {
	//errmsg.appendText("\n");
	//errmsg.appendText("upload return data function : " + event);
	//errmsg.appendText("\n");
	//errmsg.appendText("data received : " + event.data);
	trace("upload return data function : " + event);
	trace("data received : " + event.data);
	loadGraphics();
}

private function loadGraphics():void {
	Config.doc.preloader.label.text = "Elaborating image";
	trace(">> Starting loading new XML graphics");
	var rand:String="&rand="+Math.round(Math.random()*100000);
	// load request
	//var request:URLRequest = new URLRequest(Config.flashvars.httpDomain + Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.images); // real XML
	var url:String = Config.flashvars.assets + Config.flashvars.xml + Config.flashvars.images + rand;
	//var url:String = Config.flashvars.assets +"ajaxer.php?action=1&sid="+Config.flashvars.sid+"&jid="+Config.flashvars.jid ;
	trace(">> The loading URL is", url);
	var request:URLRequest = new URLRequest(url); // real XML
	//request.method = URLRequestMethod.POST;
	// load query string
	//var variables:URLVariables = new URLVariables();
	//variables.sid=Config.flashvars.sid;
	//variables.jid=Config.flashvars.jid;
	//request.data = variables;
	// loader
	var loader:URLLoader = new URLLoader(request);
	loader.addEventListener(Event.COMPLETE, onGraphicsLoaded);
}

private function onGraphicsLoaded(e:Event = null):void {
	trace(">> New XML graphics loaded");
	Config.objects = new XML(e.target.data);
	Config.menuItems = new XMLList(e.target.data).node;
	TweenLite.to(Config.doc.preloader, 0.5, { alpha:0, delay:0, ease: Strong.easeOut, onComplete: function():void { Config.doc.preloader.visible = false; } });
	Config.body.menu.header.combo.pick(0);
	Config.body.menu.header.combo.pick(numberOfCategories);
}


/* Array per specificare il tipo di dati da visualizzare per l' upload
* L' array sarà composto da tante istanze di FileFilter quanti sono i tipi differenti di files da voler far uploadare.
* Ogni FileFilter sarà composto da due parametri di tipo stringa che rappresenteranno rispettivamente
* la descrizione del tipo di file) e le estensioni valide per quel tipo di file separate da ";" */
var filetype:Array = [
    // Esempio alcuni tipi di immagini
	new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png"), 
    // Esempio files di testo
	//new FileFilter("Text Files (*.txt, *.rtf)", "*.txt; *.rtf"),
    // Esempio specifico di un unico file
    //new FileFilter("Specific File (test.swf)", "test.swf"),
    // Esempio tutti i files
	//new FileFilter("All Files (*.*)", "*.*")
	]

	// comando da usare quando vogliamo sfruttare l' upload
	
	
 
function buttonPressed(event:MouseEvent){
	//url = "http://www.tshirtpersonalizzate.com/ajax/editor_upload/";
	//jid/"+input_jid.text+"/sid/"+input_sid.text;
	// istanza di URLRequest che gestisce la comunicazione con il file esterno
	
	request = new URLRequest(url);
	request.method = URLRequestMethod.POST;
	var variables:URLVariables = new URLVariables();

	//variables.sid = "test_sid";
	//variables.pid = "test_pid";
	
	request.data = variables;
	file.browse(filetype);
    trace("woohoo!!!");
	//errmsg.text=("woohoo!!!");
	//variables.sid=input_sid.text;
	//variables.jid=input_jid.text;
	variables.sid=Config.flashvars.sid;
	variables.jid=Config.flashvars.jid;
	
	request.data = variables;
	//errmsg.appendText("\n");
	//errmsg.appendText("data pid inserted: " +input_sid.text);
	//errmsg.appendText("\n");
	//errmsg.appendText("data jid inserted : " +input_jid.text);
	
}


	
		
		
		
		
	}
}