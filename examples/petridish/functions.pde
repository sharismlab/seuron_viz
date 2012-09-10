// create daddy
void createDaddy( Object data ){
	daddy = createSeuron( daddyData.id, daddyData, false );
	daddy.cx = 30;
	daddy.cy = screenWidth/2;
	return daddy
}

// create daddy's friends 	
void createFriends( Seuron daddy, Object daddyFriends) {
	for (int i = 0; i< daddyFriends.ids.length; i++){
		
		// check if the friend already exists
		friend = seuronExists( daddyFriends.ids[i] );
		
		// console.log(friend);
		if( friend ) {
			daddy.addFriend( friend );
		} else {
			friend = createSeuron( daddyFriends.ids[i], null, false ); 	
			daddy.addFriend( friend );
		}
	}
}

// create daddy's followers
void createFollowers( Seuron daddy, Object daddyFollowers) {
	for (int i = 0; i< daddyFollowers.ids.length; i++){

		follower = seuronExists	( daddyFollowers.ids[i] );
		
		if( follower != false  ) {
			
			// seurons already exists, so it is a closeFriend
			synapse = daddy.getSynapse( follower.id );
			
			// check if 
			synapse.level = 1;
		} else {
			// console.log(follower);
			// console.loopg('create new');
			follower = createSeuron( daddyFollowers.ids[i], null, false );

			daddy.addFollower( follower );
		}

	}
}


// create a new seuron with minimum data
// and add it to a global array containing all seurons
void createSeuron( int id, Object data, boolean lookup ) {
	Seuron s = new Seuron( id, data, lookup );
	
	// console.log(id);
	// console.log(lookup);

	seurons.push( s );
	seuronIds.push( id );
	// console.log( s.lookup);

	// if specified, add to lookup list 
	if( s.lookup ) addToLookup( id );
		
	return s;
}

// check if a seuron exists
void seuronExists( int id ) {
	var existence;

	// if it doesn't exists return false
	if( seuronIds.indexOf( id ) == -1) {
		existence = false
	} else {
		// console.log("this seuron already exists");
		i = seuronIds.indexOf( id );
		existence = seurons[i];
	}
	return existence
}

// add seuron to lookup list
void addToLookup( int id ) {
	// console.log(id);
	lookup.add( id );

	// requests users from quotes
	if( lookup.size() == 100 ) {
		loadLookup();
		lookup = new ArrayList;
	}
}

// always checking if array is == 100

// call Twitter API to get user data
void loadLookup() {

	// parse twitter url
	String url = "https://api.twitter.com/1/users/lookup.json?include_entities=true";
	url += "&user_id=";
	for (int i = 0; i<lookup.size()-1; i++){
		url += lookup.get(i) + ",";
	}
	url += lookup.get( lookup.size()-1 );

	console.log( lookup );
	url="datasamples/makio135_lookup.json";
	

	$.getJSON(url, function(data) {
		$.each( data, function(key, item) {

			// console.log( seuronIds );
			// console.log( item );
			// id = item.id;

			i = seuronIds.indexOf( item.id );
			
			// console.log(i);
			if( i != -1  ) {

				// get existing seuron
				s = seurons[i]; 

				// tell seuron parser that data is a user profile
				item.isProfile =true;
	
				// populate seuron with data
				s.populate( item );

			}
		});
	});
}

// create a message then lookup into 
void createMessage( Transmitter service, Synpase syn, int action, Object data ) {

	Message m = new Message( service, syn, action, data );
	
	messages.push( m );
	messageIds.push( m );
}

void messageExists( int messageID ) {
	int i = messageIds.indexOf(messageID);
	if ( i != -1 ) {
		message = messages[i];
		return message;
	} else {
		return false;
	}	
}

// analyze daddy's timeline
// and lookup users
void analyzeTimeline( Object timeline ) {
	for(int i; i < timeline.length; i++ ) {
		 analyzeTweet( timeline[i] );
	}
	// lookup users 
	// console.log(lookup.size());
	if(lookup.size() != 0) loadLookup();
}

/*
ANALYSE EACH TWEET OF THE TIMELINE
-------------------------------

	Now we need to analyze each message to extract
		- quoted people ( @ )
		- nature of the message ( post / RT / answer)

	The message is the only proof of an existing relationship.
	So our messages will be attached to a relationship (Dendrit), not a user.

	What we need to achieve : 
		
		- Extract actions from message 
			Actions are defined by the following int
			0 :		unknown
			1 :		post
			2 : 	RT
			3 :		answer
			4 :		quote(s)

			ex : 
				@Makio135 says : "RT @jbjoatton: The Isolator vs @iAWriter http://t.co/jwBjDHdO"
				
				//extract entities
				create or get seurons for @Makio135, @jbjoatton & @iAWriter

				// store RT 
				Synapse s1 = new Synapse( @Makio135, @jbjoatton, @Makio135.getFriendship( @jbjoatton ) );
				m1 = new Message ( twitter, s1, RT, data )

				// then store quote
				Synapse s2 = new Synapse( @jbjoatton, @iAWriter, 0 );
				m2 = new Message ( twitter, s1, 4, data )


		- When parsing actions, we need to extract all quoted people ( from Twitter Entities )
			add Message to an existing Dendrit 
			or maybe create Dendrits 

		- Messages should be created using the Message class
		- We should populate a global Array with all messages
*/

void analyzeTweet( Object tweet ) {

	// check what actions can be founded within our tweet
	// 0:unknown, 1:post, 2:RT, 3:answer, 4:quote(s)
	int action;
	// console.log("ok");

	// Get the tweet owner (should be equal to daddy)
	Seuron boss; 
	boss = seuronExists( tweet.user.id );
	if( !boss ) createSeuron( tweet.user.id, tweet.user, false );
	// console.log(boss);

	// our tweet is a reply
	if ( tweet.in_reply_to_status_id != null ) {
		// our tweet is a reply!
		action = 3 ;
		analyzeReply(boss, tweet);
	} 
	// our tweet is a RT
	else if ( tweet.retweeted_status ) {
		action = 2 ;
		analyzeRT(boss, tweet);
	}
	// out tweet is just a post
	else {
		action = 1;	
		// console.log("just a post");
		if(tweet.entities.user_mentions.length>0 ) 
			analyzeMentions( boss, tweet.entities.user_mentions, boss.id, tweet );
		// else 
		// trash it ! there is no interaction so far...
		// or maybe it has been retweeted ??
		// if retweeted == true then analyzeRT
	}
}

void analyzeRT( Seuron boss, Object tweet ){
	
	// we should first store RT, then analyze retweeted_status as a new post
	// console.log("rt");

	// get our guy that has post in the first place
	our_guy = seuronExists( tweet.retweeted_status.user.id );

	// console.log(our_guy);
	// if our guy is not a seuron, then create it
	if( !our_guy  ) our_guy = createSeuron( tweet.retweeted_status.user.id, tweet.retweeted_status.user, true )
	// console.log(our_guy);

	// add our guy to the lookup
	our_guy.lookup = true;

	// get existing synapse from reply_guy
	synapse = boss.getSynapse( our_guy.id );

	// if synapse doesnt already exist, then it means that the guy is unknown
	// so we create the synapse with value of 4
	if( !synapse ) synapse = boss.createSynapse( our_guy, 4 ) ;

	console.log(synapse);

	// now create the message 
	createMessage( twitterTransmitter, synapse, 2, tweet );

	// deal with other user that has been quoted in the message
	if(tweet.entities.user_mentions.length>0){
		analyzeMentions( boss, tweet.entities.user_mentions, tweet.in_reply_to_user_id, tweet );
	}

	// Now we can process the original message, as the data is inside

	// change context to original message
	original_tweet  = tweet.retweeted_status;

	// analyze original message
	analyzeTweet(original_tweet);
}

void analyzeReply(  Seuron boss, Object tweet ){
	// console.log("reply");
	
	// get message 
	original_message  = tweet.in_reply_to_status_id;

	// is the message a reply to himself?
	if( tweet.in_reply_to_user_id == boss.id ) {
		// console.log("this is a reply to myself ! ");
		// getMessage( original_message );
		// createMessage( )
	} 
	// this is an answer to someone else's message
	// so complete message should be available inside boss's "profile/mentions"
	else {
		// console.log("check into profile/mentions to find message data");
		// tweet = getTweet where id = data.in_reply_to_status_id from profiles/mentions
		// analyzeTweet(tweet)
	}

	// get the guy from the reply
	reply_guy = seuronExists( tweet.in_reply_to_user_id );

	// if reply_guy is not a seuron, then create it
	if( !reply_guy  ) reply_guy = createSeuron( tweet.in_reply_to_user_id, null, true )

	// add our guy to the lookup
	reply_guy.lookup = true;

	// get existing synapse from reply_guy
	synapse = boss.getSynapse( reply_guy.id );

	// if synapse doesnt already exist, then it means that the guy is unknown
	// so we create the synapse with value of 4
	if( !synapse ) synapse = boss.createSynapse( reply_guy, 4 ) ;

	// now create the message 
	createMessage( twitterTransmitter, synapse, 3, tweet );

	// create other relations with guys quoted in the message 
	if(tweet.entities.user_mentions.length>0){
		analyzeMentions( boss, tweet.entities.user_mentions, tweet.in_reply_to_user_id, tweet );
	}
}

void analyzeMentions( Seuron boss, Object mentions, int exclude_id, Object data ) {
	// console.log(mentions.length);

	//loop into mentions
	for (int i = 0; i<mentions.length; i++){

		// exclude id that has been passed 
		if(mentions[i].id != exclude_id ) {
			//check if user seuron already exists
			seuron = seuronExists( mentions[i].id );
			seuron.lookup = true;
			
			if( seuron != false ) { 
				
				// get existing Friendship (Synapse)
				synapse = boss.getSynapse( mentions[i].id );

				// if synapse doesnt already exist, then it means that the guy is unknown
				// so we create the synapse with value of 4
				if( !synapse ) synapse = boss.createSynapse( seuron, 4 ) ;

				// create message
				createMessage( twitterTransmitter, synapse, 3, data );

			} else {

				// create new Seuron
				s = createSeuron( mentions[i].id, null, true);
				
				// create new Synapse with value 4
				synapse = boss.createSynapse( s, 4 );

				// create message
				createMessage( twitterTransmitter, synapse, 4, data );	
			}
		}
	}
}


/*
void analyzeTimelineTweet( Object tweet ) {

	//console.log(tweet);
	if ( tweet.retweeted_status ) {
		//console.log ('RT');
		
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

		// from daddy
		daddy.addMessage( twitterTransmitter, tweet, 0 );
		var mentions = tweet.entities.user_mentions ;

		if( mentions.length >0 ){
			for (int i = 0; i<mentions.length; i++){

				//check if user already exists
				int index = seuronIds.indexOf( tweet.user.id );

				if( index!=-1 ) {
						// get existing Seuron
						SeuronTmp s = seurons.get(index);
					
						//add message to 
						// s.addMessage( new Message (twitterTransmitter , tweet) );
						// exist=true;
				} 
				else {
					// create new seuron
					createSeuron(tweet);
				}

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
					// @ is unknown !
					if( atunknown != -1 ) {
						SeuronTmp s = daddy.unknowns[atunknown];
						console.log(s);
						s.addMessage( twitterTransmitter, tweet, 1 );	
					} 
					else {
						// console.log(mentions[i].id );
						daddy.addUnknown( mentions[i].id );
						int mypos = daddy.unknowns.length-1;
						// console.log(daddy.unknowns.length);
						SeuronTmp s = daddy.unknowns[mypos];
						s.addMessage( twitterTransmitter, tweet, 1 );
					}

				}

			}
		}

	}
*/ 

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
		createSeuron(tweet);
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
	}


}