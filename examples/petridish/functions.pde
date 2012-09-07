// create new seuron
void addSeuron( Object data ) {

	Seuron s = new Seuron(random(20,screenWidth-50), random(100, screenHeight-150), 35, color(random(255),random(255),random(255)), data );
	seurons.add(s);
	// s.addMessage( new Message (twitterTransmitter , data) );
	seuronIds.add(s.id);
	// return s;

}

// analyze daddy's timeline
void analyzeTimeline( Object timeline ) {
	
	for(int i; i < timeline.length; i++ ) {
		loading =true;
		analyzeTimelineTweet( timeline[i] );
	}
	
	// lookup users 
	if(lookup.size() != 0) loadLookup();

}
 

// store tweets into Temp Seurons
// tweets are indexed with the following levels : 
// No interaction:0, RT:1 , @:2

void analyzeTimelineTweet( Object tweet ) {
	
	if ( tweet.retweeted_status ) {
		// RT
		int rtfriend = (daddy.friends).indexOf(tweet.retweeted_status.user.id);
		int rtfollow = (daddy.followers).indexOf(tweet.retweeted_status.user.id);

		if(  rtfriend != -1 ) {
			// @ is a friend !
			SeuronTmp s = daddy.friends[ rtfriend ];
			s.addMessage( tweet,  );

		} 
		else if( rtfollow != -1 ) {
			// @ is a follower !
			SeuronTmp s = daddy.followers[ rtfollow ];
			s.addMessage( tweet );

		} 
		else {
			// @ is unknown !
			SeuronTmp s = daddy.followers[ rtfollow ];
			s.addMessage( tweet );	

		}

	} else {
		// from daddy

		daddy.addMessage( tweet );

		if( tweet.entities.user_mentions.length>0 ){
			// there is @
			if((daddy.friends).indexOf(tweet.entities.user_mentions.id) != -1 ) {
				// @ is a friend !
				daddy.
			} 
			else if((daddy.followers).indexOf(tweet.entities.user_mentions.id) != -1 ) {
				// @ is a follower !

			}


		}

	}





	 
	/*
	// check if seuron already exists
	int index = seuronIds.indexOf( tweet.user.id );

	if( index!=-1 ) {

			// get existing Seuron
			Seuron s = seurons.get(index);
		
			//add message to 
			// s.addMessage( new Message (twitterTransmitter , tweet) );
			// exist=true;
	} 
	else {
		// create new seuron
		addSeuron(tweet);
	}

	// create users from mentions
	if(tweet.entities.user_mentions.length>0){
		// console.log(tweet.entities.user_mentions.length);
		for (int i = 0; tweet.entities.user_mentions[i]; i++){
			//console.log(tweet.entities.user_mentions[i]);

			int index2 = seuronIds.indexOf(tweet.entities.user_mentions[i].id);// check if seuron has already been added to seuronsIds
			int index3 = lookup.indexOf(tweet.entities.user_mentions[i].id);// check if seuron has already been added to lookup
		

			if(index2==-1 && index3==-1){
				lookup.add( tweet.entities.user_mentions[i].id );
				seuronIds.add( tweet.entities.user_mentions[i].id );
				// println("lookup.size(): "+ lookup.size());
				// println("seuronIds.size(): "+ seuronIds.size());
			}
		}
	}*/



}

void addToLookup( int id ) {
	lookup.add( id );

	// requests users from quotes
	if( lookup.size() == 100 ) {
		loadLookup();
		lookup = new ArrayList;
	}
}

void loadLookup() {

	String url = "https://api.twitter.com/1/users/lookup.json?include_entities=true";
	url += "&user_id=";
	for (int i = 0; i<lookup.size()-1; i++){
		url += lookup.get(i) + ",";

	}
	url += lookup.get( lookup.size()-1 );

	// console.log(url);
	url="datasamples/makio135_lookup.json";
	$.getJSON(url, function(data) {
		$.each( data, function(key, item) {

			item.isProfile =true;
			// allUsers.push( item );
			seurons.add( new Seuron( random(20,screenWidth-50), random(100, screenHeight-150), 35, color(random(255),random(255),random(255)), item ) );

		});
	});
}