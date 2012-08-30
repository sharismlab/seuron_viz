var username = "makio135";
var allMessages = [];
var allUsers= [];

$(document).ready(function(){

    //declare Processing instance to js
    // var myviz = viz;

    //get all messages
    $.getJSON('../../data/messages.json', function(data) {

        $.each( data, function(key, item) {
            // add tweets into js array
            allMessages.push(item);

            // send msg data to processing
            // console.log(myviz);
            var viz = Processing.getInstanceById("seuron");

            if(viz != null) 
                setTimeout(function(){ viz.addTweet(item) }, 5000);

        });
    }); 

     //get all users
    $.getJSON('../../data/userdata.json', function(data) {
        $.each( data, function(key, item) {

            allUsers.push( item );

            // send user data to processing
            var viz = Processing.getInstanceById("seuron");
            if(viz != null) 
                setTimeout(function(){ viz.addSeuron( item ) }, 5000);//pourquoi on met du random?
        });
    });


}); // end document ready
