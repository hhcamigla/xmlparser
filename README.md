xmlparser
=========

TestXMLParser iOS app 

This iOS application retrieve xml string from https://dl.dropboxusercontent.com/u/101222705/business.xml and display 
information to the screen.

HOW DOES THIS APP WORK?

OVERVIEW

Upon launch, the appilcation request data from https://dl.dropboxusercontent.com/u/101222705/business.xml url.  
The retrieved xml string is then parsed and then converted to NSMutableDictionary. After converting to a NSMutableDictionary
object, the application display the information in a UIWebView.  The location of the busines is also plotted using a MapView,
it uses the latitude and longitude retrieved, drops a pin on the map and zoom the map to the location.



DETAIL 

BusinessObject class 
-creates a singleton variable that hold a referece to other instanve variable.     

BaseHTTPRequest class 
-responsible for pulling data from the url.  If the url is secured that authentication is 
automatically skipped. It also show an alert message if the last request operation status is other than 200 (HTTP OK).    

CompletionBlock typed variable 
-is passed to a BaseHTTPRequest instance variable so that it can properly handle and signal that the request is a success 
or failure (see constants.h explanation below). 

The XMLParser class 
- the one that parses the xml string, also this class is responsible of the xml's node name and value and assigning it to
a CustomMutableDictionary variable. 

CustomMutableDictionary class
-this holds the name and value of an xml node that was parsed. It can also CustomMutableDictionary variables as child items,
it also holds a reference to it's parent object.  This class is used to create a NSMutableDictionary of equivalent its self. 

HOME.html file
-This contains the format on how the app will display the retrieved information to a UIWebView.  You can change the html file 
to fit your requirements provided that the number of string being formatted is the same with the number string sources, otherwise
this will result in a run-time-error


////////
constants.h file
kRequestData = nsdata retrieved
kRequestStatus = object key to reference to get the status of the operation from last request
kRequestStatusOK = status that the last request operation is successful
kRequestStatusErr =status that the last request operation failed/have error

