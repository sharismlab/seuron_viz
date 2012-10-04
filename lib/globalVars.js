// A global array to store all seurons, including unactive
var seurons = [];

// A simple array storing only ids for all seurons
var seuronIds = [];

// Array to store all ids that needs to be looked up through twitter API
var toLookup = [];

// all our messages + Ids
var messageIds = [];
var messages = [];

// store all our messages
var interactions = [];
var interactionIds = [];

// store all our messages
var threads = [];

// messages to be looked up
var messagesLookup = [];

var displayForce = false;

//
var MX= 0;
var MY= 0;

$().mousemove( function(e) {
   MX = e.pageX; 
   MY = e.pageY;
 });