// Extract site domain with final '/'
var baseUrl = location.href.substring(0,location.href.indexOf('/', 8)) +  "/";

// Initialize flashvars
var flashvars = { "serverLocation": baseUrl, "secureServerLocation": baseUrl, "assetsPrefix": "assets/", "assetsXML": "xml/" };

// Secure server definition
switch (flashvars.serverLocation) {
	case "http://www.tshirt.com/": // production website
		flashvars.secureServerLocation = "https://secure.tshirt.com/"; 
		break;                               
	case "file:///Users/":         // local website (with no active server)
		flashvars.serverLocation = "file:///Users/reggie/dev/work/ipnotica/tshirt/"; 
		flashvars.secureServerLocation = "file:///Users/reggie/dev/work/ipnotica/tshirt/"; 
		break;                               
}

// Querystring params 
var sArgs = location.search.slice(1).split("&");
if (sArgs.length > 0) { 
	for (var i = 0; i < sArgs.length; i++) {
   	 	flashvars[sArgs[i].slice(0, sArgs[i].indexOf("="))] = sArgs[i].slice(sArgs[i].indexOf("=")+1, sArgs[i].length);
 		}
}
