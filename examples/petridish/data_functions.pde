void loadData(){
	// FRIENDS & FOLLOWERS 
	// ------------------------------
	// they are empty seurons just storing existing relationships
	// they won't be displayed on the screen
	// we will be get their profile data only if they interact with daddy	

	// create daddy 
	Object daddyData = getProfile("makio135");
	daddy = new Seuron( daddyData.id, daddyData, true );
	daddy.cx = width/2;
	daddy.cy = height/2;
	daddy.couleur = #ffffcb;
	seurons.push(daddy);
	seuronIds.push(daddy.id);
	displayDaddy = true;


	// console.log(daddy);

	// create daddy's friends 	
	Object daddyFriends = getFriends("makio135");	
	daddy.friends = daddyFriends.ids;

	// create daddy's followers
	Object daddyFollowers = getFollowers("makio135");
	daddy.followers = daddyFollowers.ids;

	// THE TIMELINE
	// ------------------------------------------
	// Now let's check the timeline 
	// To extract messages and quoted people from it
	// we should also extract statuses/mentions to have the whole conversation !

	timelineMentions = getMentions("makio135");

	Object daddyTimeline = getTimeline( "makio135" );
	analyzeTimeline(daddyTimeline);
	
	// console.log("threads.length : "+threads.length);
	// console.log("daddyTimeline.length : "+daddyTimeline.length);

	for (int i = 0; threads[i]; i++){
		console.log(threads[i].messageIds.length);	
	}

}


// ------------------------------- LOOKUP LOCAL DATA
void lookupUsers() {
	// parse twitter url
	
	String url = "https://api.twitter.com/1/users/lookup.json?include_entities=true";
	url += "&user_id=";
	for (int i = 0; i<toLookup.length-1; i++){
		url += toLookup[i] + ",";
	}
	url += toLookup[ toLookup.length-1 ];

	// console.log( url );

//	console.log("looking for users : " + toLookup.length);
//	console.log(toLookup);

	var aaa;
	if(toLookup.length == 100 ){
		url="datasamples/clemsos_lookup_A.json";
	} else {
		url="datasamples/clemsos_lookup_B.json";
		aaa  =1 ;
	}
	
	// url = "datasamples/makio135_lookup_actives.json"

	$.getJSON(url, function(data) {
		// console.log("JSON LOOKUP : got " + data.length + " users profiles")
		$.each( data, function(key, item) {
			//populate seurons with twitter data
			parseUser( item );
		});
		displaySeuron = true;

		
		if( aaa == 1 ) {
			// console.log("------ go go go, VIZ !");
			displaySeuron = true; 
			// checkData();
		}
		
	});
}