var username = "makio135";
var messages = [];

$(document).ready(function(){

    $('#startviz').click( function(){

    //get all messages

        $.getJSON('../../data/messages_test.json', function(data) {
        
            $.each( data, function(key, val) {
                messages.push('<li id="' + key + '">' + val + '</li>');
            });
            
        }); //End json
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
