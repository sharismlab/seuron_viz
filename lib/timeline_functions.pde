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

void analyzeTimeline( Array timeline ) {
	for(int i; i < timeline.length; i++ ) {
		 analyzeTweet( timeline[i] );
	}

	// API twitter lookup users for toLookup<100
	if( toLookup.length >0 ) lookupUsers( toLookup );
}

void analyzeTweet( Object tweet ) {

	// console.log("---- new tweet ----");

	// check what actions can be founded within our tweet
	// 0:unknown, 1:post, 2:RT, 3:answer, 4:quote(s)

	int from = seuronExists( tweet.user.id );

	if( from == null ) {
		createSeuron( tweet.user.id, tweet.user, false );
		
		// get last id 
		for (int i = 0; seurons[i]; i++){
			from =i;
		}
	}

	// this seuron is active, so if it has no profile info and is not already going to be lookup, and is not in lookup array, add it to lookup
	// if( seurons[from].lookedUp == false && inLookup(seurons[from].id ) == false ) addToLookup( seurons[from].id );

	// our tweet is a reply
	if ( tweet.in_reply_to_status_id != null ) {
		// console.log("reply");
		analyzeReply( from, tweet);
		
	} 
	// our tweet is a RT
	else if ( tweet.retweeted_status ) {
		// console.log("rt");
		analyzeRT( from, tweet);
		
	}
	// out tweet is just a post
	else {
		// console.log("mentions");
		if(tweet.entities.user_mentions.length>0 ) 
			analyzeMentions( from, tweet.entities.user_mentions,  seurons[from].id, tweet );
		// else : nothing happpen bcz no interactions
		// if retweeted = true
	}
}

void analyzeRT( int _from, Object tweet ){
	
	// we should first store RT, then analyze retweeted_status as a new post
	// console.log("THIS IS A RT");

	// get our guy that has post in the first place
	int rtFrom = seuronExists( tweet.retweeted_status.user.id );

	// if our guy is not a seuron, then create it	
	if( rtFrom == null ) {
		rtFrom = createSeuron( tweet.retweeted_status.user.id, tweet.retweeted_status.user, false );
		
		// get last id 
		for (int i = 0; seurons[i]; i++){
			rtFrom =i;
		}
	}

	// this seuron is active, so if it has no profile info and is not already going to be lookup, add it to lookup
	// if( seurons[rtFrom].lookedUp == false && inLookup( seurons[rtFrom].id ) == false ) addToLookup(seurons[rtFrom].id);

	// get existing synapse from reply_guy
	int synapse = seurons[_from].getSynapse( seurons[ rtFrom ].id );

	// if synapse doesnt already exist, then it means that the guy is unknown
	// so we create the synapse with value of 4
	if( synapse == null ) {
		seurons[_from].createSynapse( seurons[rtFrom] ) ;
		for (int i = 0; seurons[_from].synapses[i]; i++){
			synapse =i;
		}
	} 
	createMessage( twitterTransmitter, seurons[_from].synapses[synapse], 2, tweet );

	// deal with other user that has been quoted in the message
	if(tweet.entities.user_mentions.length>0){
		analyzeMentions( _from, tweet.entities.user_mentions, tweet.in_reply_to_user_id, tweet );
	}

	// Now we can process the original message, as the data is inside
	// change context to original message
	Object original_tweet  = tweet.retweeted_status;

	// analyze original message
	analyzeTweet(original_tweet);
}

void analyzeReply(  int _from, Object tweet ){
	// console.log("this is a reply");
	
	// get message 
	Object original_message  = tweet.in_reply_to_status_id;

	// is the message a reply to himself?
	if( tweet.in_reply_to_user_id == seurons[_from].id ) {
		// console.log("this is a reply to myself ! ");
	} 
	// this is an answer to someone else's message
	// so complete message should be available inside boss's "profile/mentions"
	else {
		// console.log("check into profile/mentions to find message data");
		// tweet = getTweet where id = data.in_reply_to_status_id from profiles/mentions
		// analyzeTweet(tweet)
	}

	// get the guy from the reply
	int replyFrom = seuronExists( tweet.in_reply_to_user_id );

	// if reply_guy is not a seuron, then create it
	if( replyFrom == null ) {
		replyFrom = createSeuron( tweet.in_reply_to_user_id, null, false );
		// get last id 
		for (int i = 0; seurons[i]; i++){
			replyFrom =i;
		}
	}
	
	// console.log(seurons[replyFrom]);

	// this seuron is active, so if it has no profile info and is not already going to be lookup, add it to lookup
	// if( seurons[replyFrom].lookedUp == false && inLookup(seurons[replyFrom].id ) == false ) addToLookup( seurons[replyFrom].id );

	// get existing synapse from reply_guy
	synapse = seurons[_from].getSynapse( seurons[replyFrom].id );
	
	// if synapse doesnt already exist, then it means that the guy is unknown
	// so we create the synapse with value of 4
	if( synapse == null ) {
		seurons[_from].createSynapse( seurons[replyFrom] );
		// get last id 
		for (int i = 0; seurons[_from].synapses[i]; i++){
			synapse =i;
		}
	}

	// now create the message 
	createMessage( twitterTransmitter, seurons[_from].synapses[synapse], 3, tweet );

	// create other relations with guys quoted in the message 
	if(tweet.entities.user_mentions.length>0){
		analyzeMentions( _from, tweet.entities.user_mentions, tweet.in_reply_to_user_id, tweet );
	}
}

void analyzeMentions( int _from, Object mentions, int exclude_id, Object data ) {
	// console.log("there is mentions");

	//loop into mentions
	for (int i = 0; i<mentions.length; i++){

		// exclude id that has been passed 
		if(mentions[i].id != exclude_id && mentions[i].id != daddy.id ) {

			//check if user seuron already exists
			int at = seuronExists( mentions[i].id );
			
			if( at == null )  {
				// create new Seuron
				createSeuron( mentions[i].id, null, false);

				for (int j = 0; seurons[j]; j++) {
					at =j;
				}
			} 
			
			// this seuron is active, so if it has no profile info and is not already going to be lookup, add it to lookup
			// if( seurons[at].lookedUp == false && inLookup( seurons[at].id ) == false ) addToLookup( seurons[at].id );		

			// get existing Friendship 
			int synapse = seurons[ _from ].getSynapse( seurons[ at ].id );
			// console.log( "before : " + synapse );
			if( synapse == null )  {
				// create new Seuron

				seurons[ _from ].createSynapse( seurons[at] );
				// console.log(seurons[ _from ].createSynapse( seurons[at], 4 ));

				for (int j = 0; seurons[_from].synapses[j]; j++) {
					synapse =j;
				}
				// console.log(data);
				// console.log( "fater : " + synapse );
			}
			
			createMessage( twitterTransmitter, seurons[_from].synapses[synapse], 4, data );

		}
	}
}