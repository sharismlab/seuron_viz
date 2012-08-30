var username = "makio135";
var allMessages = [];
var allUsers= [];

var viz = Processing.getInstanceById("seuron");


$(document).ready(function(){

     //get all users
    /*$.getJSON('../../data/userdata.json', function(data) {
        $.each( data, function(key, item) {

            allUsers.push( item );
            // console.log("nbUsers:" + allUsers.length);

        });
    });*/

    //get all messages
    $.getJSON('datasamples/makio135_timeline.json', function(data) {

        $.each( data, function(key, item) {
            // add tweets into js array
            allMessages.push(item);

            // send msg data to processing

            var viz = Processing.getInstanceById("seuron");
            //viz.check();
            if(viz != null) 
                setTimeout(function(){ viz.analyzeTweet(item) }, 5000);

        });
    }); 



}); // end document ready
