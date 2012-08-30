var username = "makio135";
var allMessages = [];
var allUsers= [];

$(document).ready(function(){

     //get all users
    $.getJSON('../../data/userdata.json', function(data) {
        $.each( data, function(key, item) {

            allUsers.push( item );
            // console.log("nbUsers:" + allUsers.length);

        });
    });

    //get all messages
    $.getJSON('datasamples/messages2.json', function(data) {

        $.each( data, function(key, item) {
            // add tweets into js array
            allMessages.push(item);

            // send msg data to processing

            var viz = Processing.getInstanceById("seuron");
            if(viz != null) 
                setTimeout(function(){ viz.analyzeTweet(item) }, 5000);

        });
    }); 

}); // end document ready
