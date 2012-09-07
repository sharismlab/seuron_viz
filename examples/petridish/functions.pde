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
	console.log(daddy);
	for(int i; i < timeline.length; i++ ) {
		 analyzeTimelineTweet( timeline[i] );
	}
	
	// lookup users 
	if(lookup.size() != 0) loadLookup();

}
 

// store tweets into Temp Seurons
// tweets are indexed with the following levels : 
// No interaction:0, RT:1 , @:2

void analyzeTimelineTweet( Object tweet ) {
	console.log(tweet);
	if ( tweet.retweeted_status ) {
		// console.log ('RT');
		
		// RT
		int rtclose, rtfriend, rtfollow, rtunknown;

		rtclose = (daddy.closeFriendsIds).indexOf(tweet.retweeted_status.user.id);
		if ( rtclose == -1 ) rtfriend = (daddy.friends).indexOf(tweet.retweeted_status.user.id);
		else if( rtfriend == -1 ) rtfollow = (daddy.followers).indexOf(tweet.retweeted_status.user.id);
		else if( rtfollow == -1 ) rtunknown = (daddy.unknowns).indexOf( tweet.retweeted_status.user.id ); 

		if ( rtclose != -1 ){
			// @ is Friend & Follwoer
			int posF = daddy.closeFriendsPos[rtclose];
			SeuronTmp s = daddy.friends[posF];
			s.addMessage( twitterTransmitter, tweet, 1 );
		}
		else if( rtfriend != -1 ) {
			// @ is a friend !
			SeuronTmp s = daddy.friends[ rtfriend ];
			s.addMessage( twitterTransmitter, tweet, 1 );

		} 
		else if( rtfollow != -1 ) {
			// @ is a follower !
			SeuronTmp s = daddy.followers[ rtfollow ];
			s.addMessage( twitterTransmitter, tweet, 1 );

		} 
		else {
			// @ is unknown !
			if( rtunknown =-1 ) {
				daddy.addUnknown( tweet.retweeted_status.user.id );
				SeuronTmp s = (Seuron)(daddy.unknowns).get((daddy.unknowns).length-1);
				s.addMessage( twitterTransmitter, tweet, 1 );	
			} 
			else {
				SeuronTmp s = (Seuron)(daddy.unknowns).get( rtunknown );
				s.addMessage( twitterTransmitter, tweet, 1 );
			}

		}

	} 
	else {

		console.log("daddy's message");
		// from daddy
		daddy.addMessage( twitterTransmitter, tweet, 0 );
		var mentions = tweet.entities.user_mentions ;
		console.log(mentions);
		if( mentions.length >0 ){
			

			for (int i = 0; i<mentions.length; i++){

			int atclose, atfriend, atfollow, atunknown;
				atclose = (daddy.closeFriendsIds).indexOf(mentions[i].id);
				// console.log(atclose);
				if ( atclose == -1 ){ 
					atfriend = (daddy.friends).indexOf(mentions[i].id);
					// console.log(atfriend);
				}
				else if( atfriend == -1 ){ 
					atfollow = (daddy.followers).indexOf(mentions[i].id);
					 // console.log(atfollow);
				}
				else if( atfollow == -1 ){ 
					atunknown = (daddy.unknowns).indexOf( mentions[i].id ); 
					// console.log(atunknown);
				}

				 // console.log("atclose" + atclose);
				 // console.log("atfollow" + atfollow);
				 // console.log("atfriend" + atfriend);
				 // console.log("atunknown" + atunknown);

				if ( atclose != -1 ){

					// @ is Friend & Follwoer
					int posF = daddy.closeFriendsPos[atclose];
					// console.log(posF);
					// console.log(daddy.friends[posF]);

					SeuronTmp s = daddy.friends[posF];
					s.addMessage( twitterTransmitter, tweet, 1 );
				}
				else if( atfriend != -1 ) {
					// @ is a friend !
					SeuronTmp s = daddy.friends[ atfriend ];
					s.addMessage( twitterTransmitter, tweet, 1 );

				} 
				else if( atfollow != -1 ) {
					// @ is a follower !
					SeuronTmp s = daddy.followers[ atfollow ];
					s.addMessage( twitterTransmitter, tweet, 1 );
				}
				else {
					console.log(tweet);
					console.log(mentions[i]);
					// @ is unknown !
					if( atunknown != -1 ) {
						SeuronTmp s = daddy.unknowns[atunknown];
						console.log(s);
						s.addMessage( twitterTransmitter, tweet, 1 );	
					} 
					else {
						console.log(mentions[i].id );
						daddy.addUnknown( mentions[i].id );
						int mypos = daddy.unknowns.length-1;
						console.log(daddy.unknowns.length);
						SeuronTmp s = daddy.unknowns[mypos];
						s.addMessage( twitterTransmitter, tweet, 1 );
					}

				}

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