var username = "makio135";
var messages = [];
var users= [];
var viz;

$(document).ready(function(){

    //declare Processing instance to js
    viz = Processing.getInstanceById("seuron");

    //get all messages
    $.getJSON('datasamples/messages.json', function(data) {

        $.each( data, function(key, item) {
            // add tweets into js array
            messages.push(item);

            // send msg data to processing
            var viz = Processing.getInstanceById("seuron");
            if(viz != null) 
                setTimeout(function(){ viz.addTweet(item) }, Math.random()*10000 + 1000);//pourquoi on met du random?

        });
    }); 

     //get all users
    $.getJSON('datasamples/userdata.json', function(data) {
        $.each( data, function(key, item) {

            users.push( item );

            // send user data to processing
            var viz = Processing.getInstanceById("seuron");
            if(viz != null) 
                setTimeout(function(){ viz.addSeuron( item ) }, Math.random()*10000 + 1000);//pourquoi on met du random?
        });
    });


    //////////////////////////////////////////c'est quoi cette fonction?
    // pass some tweets to processing
    for (i=0; i<5; i++) {
        if(viz != null) {
            console.log('b');
            tweets.addTweet(messages[i]);//d'où sort la var globale tweets?
        }
    }
    //////////////////////////////////////////


    $('#startviz').click( function(){
        // console.log(messages);
        // console.log(users);
    });




/*    $('#startviz').click( function(){

        // load data from Twitter
        $(document).liveTwitter(username ,{
            rpp: 30,
            rate: 5000,
            mode: 'user_timeline',
            retweets: 1,
            entities : 1,
            filter: function(tweet){

            //send Twitter data to Processing
            var seuron = Processing.getInstanceById("seuron");
              if(seuron != null) 
                setTimeout(function(){ seuron.addTweet(tweet)}, Math.random()*10000 + 1000);
            }
          })

    });

    $('#stopviz').click( function(){
        $(document).each(function(){ this.twitter.stop(); });
    });*/

}); // end document ready
