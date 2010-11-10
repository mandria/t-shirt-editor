package com.ipnotica.header.buttons {
	
	import com.ipnotica.content.blackboard.producs.product.Product;
	import com.ipnotica.content.blackboard.producs.product.item.Item;
	import com.ipnotica.utils.Config;
	import com.goodinson.snapshot.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;

	public class PriceBuyButton extends MovieClip {
		
		public var price:TextField;
		public var structure:String;
		
		public function PriceBuyButton() {
			super();
			this.buttonMode = true;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:Event):void {
			initStructure();
		}
		
		// Define the XML structure in a string, representing
		// the definition of an entire product 
		private function initStructure():void {
			initialProductXML();
			var views:Array = Config.body.content.blackboard.products.list;
			for (var i:int = 0; i < views.length; i++) {
				initialViewXML(i);
				initStructureView(Product(views[i]).items.customization.items);
				finalViewXML();
			}
			finalProductXML();
			sendFinalProduct();
		}
		
	    
		// send the personalized product
		private function sendFinalProduct():void {
			trace(">>", structure);
			
			
			
			
			//var request:URLRequest = new URLRequest(Config.flashvars.httpDomain + "products.xml");
			//request.method = URLRequestMethod.POST;
		
			//var variables:URLVariables = new URLVariables();
			//variables["id"] = Config.flashvars.productID; // id of the project
			//variables["data"] = srtucture;
			//request.data = variables;
				
			//var loader:URLLoader = new URLLoader(request);
			//loader.addEventListener(Event.COMPLETE, onProductLoaded);
	Snapshot.gateway = "http://www.tshirtpersonalizzate.com/tinotest/snapshot.php";
			// capture as JPG and display prompt user to save/download //Snapshot.JPG  //Snapshot.PNG
			//Snapshot.DISPLAY; Snapshot.PROMPT; Snapshot.LOAD;
	var variables:URLVariables = new URLVariables();
	
	//variables.msid=input_sid.text;
	//variables.mjid=input_jid.text;
	variables.sid=Config.flashvars.sid;
	variables.jid=Config.flashvars.jid;
	for (var i:uint=0; i<Config.views.length(); i++) {
				Snapshot.capture(getChildByName(Config.views[i].node.node.id), {

				format: Snapshot.JPG,

				action: Snapshot.LOAD,
				
				err: this,
				
				sid: variables.sid,
				
				jid: variables.jid

			});
			
		
		
		}
	}
	

	
		
		// redirect to the product page
		private function onProductLoaded(e:Event):void {
		  	//navigateToURL(new URLRequest(Config.flashvars.httpDomain + "products.xml/" + Config.flashvars.productID),"_blank");
		trace("<<<<<<< saved");
		}
		
		
		
		
		private function initStructureView(items:Array):void {
			for (var i:int = 0; i < items.length; i++) { 
				objectXML(items[i]);
			}
		}
		
		
		// <product id="1">
		//   <views>
		private function initialProductXML():void {
			structure = "<product id=\"" + Config.productID + "\"><views>";
		}
		
		//   </views>
		// </product>
		private function finalProductXML():void {
			structure += "</views></product>";
		}
		
		// <view id="1">
		//   <objects>
		private function initialViewXML(i:int):void {
			structure += "<view id=\"" + i + "\"><objects>";
		}
		
		//   </objects>
		// </view>
		private function finalViewXML():void {
			structure += "</objects></view>";
		}
		
		// <object id="4" type="png">
		//   <alpha>0.3</alpha>
		//   <height>200</height>
		//   <width>200</width>
		//   <color>23369394</color>
		//   <x>0</x>
		//   <y>0</y>
		//   <rotation>60</rotation>
		//   <path>grafica/bimbo.png</path>
		// </object>
		private function objectXML(item:Item):void {
			
			for (var val:String in item.structure.properties) { trace("The key", val, "has value", Config.currentItem.structure.properties[val]); }
			
			structure += "<object id=\"" + item.structure.id + "\" type=\"" + item.structure.type + "\">";
			if (item.structure.properties.alpha != null) { structure += "<alpha>" + item.structure.properties.alpha + "</alpha>"; }
			if (item.structure.properties.height != null) { structure += "<height>" + item.structure.properties.height + "</height>"; }
			if (item.structure.properties.width != null) { structure += "<width>" + item.structure.properties.width + "</width>"; }
			if (item.structure.properties.color != null) { structure += "<color>" + item.structure.properties.color + "</color>"; }
			if (item.structure.properties.x != null) { structure += "<x>" + item.structure.properties.x + "</x>"; }
			if (item.structure.properties.y != null) { structure += "<y>" + item.structure.properties.y + "</y>"; }
			if (item.structure.properties.rotation != null) { structure += "<rotation>" + item.structure.properties.rotation + "</rotation>"; }
			if (item.structure.properties.font != null) { structure += "<font>" + item.structure.properties.font + "</font>"; }
			if (item.structure.type != "texts") { structure += "<path>" + item.itemXML.image.node.node.path.text() + item.itemXML.image.node.node.filename.text() + "</path>"; }
			structure += "</object>";
		}
		
		
		
		
	}
}