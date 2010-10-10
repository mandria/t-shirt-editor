// Extract site domain with final '/'
var baseUrl = location.href.substring(0,location.href.indexOf('/', 8)) +  "/";

// Initialize flashvars
var flashvars = { 
	"serverLocation": baseUrl, 
	"secureServerLocation": baseUrl, 
	"assets": "", 
	"xml": "", 
	"categories": "ajaxer.php?action=2",
	"images": "ajaxer.php?action=1",
	"products": "ajaxer.php?action=0"
};

// Secure server definition
switch (flashvars.serverLocation) {
	
	// production website
	case "http://www.tshirtpersonalizzate.com/": 
		//flashvars.secureServerLocation = "https://secure.tshirt.com/"; 
		break;                     
		
	// local website (with no active server)	          
	case "file:///Users/":
		flashvars.serverLocation = "file:///Users/reggie/dev/work/ipnotica/tshirt/"; 
		//flashvars.secureServerLocation = "file:///Users/reggie/dev/work/ipnotica/tshirt/"; 
		break;                               
}

// Querystring params 
var sArgs = location.search.slice(1).split("&");
if (sArgs.length > 0) { 
	for (var i = 0; i < sArgs.length; i++) {
   	 	flashvars[sArgs[i].slice(0, sArgs[i].indexOf("="))] = sArgs[i].slice(sArgs[i].indexOf("=")+1, sArgs[i].length);
 		}
}
