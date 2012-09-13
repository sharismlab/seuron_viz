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

	if( toLookup.length >0 ) lookupUsers( toLookup );
}

void analyzeTweet( Object tweet ) {

	// check what actions can be founded within our tweet
	// 0:unknown, 1:post, 2:RT, 3:answer, 4:quote(s)
	
	int from = seuronExists( tweet.user.id );

	if( from == null ) createSeuron( tweet.user.id, tweet.user, false );

	// get last id 
	for (int i = 0; seurons[i]; i++){
		from =i;
	}

	// our tweet is a reply
	if ( tweet.in_reply_to_status_id != null ) {
		analyzeReply( seurons[from], tweet);
	} 
	// our tweet is a RT
	else if ( tweet.retweeted_status ) {
		analyzeRT( seurons[from], tweet);
	}
	// out tweet is just a post
	else {
		if(tweet.entities.user_mentions.length>0 ) 
			analyzeMentions(  seurons[from], tweet.entities.user_mentions,  seurons[from].id, tweet );
	}
}

void analyzeRT( Seuron boss, Object tweet ){
	
	// we should first store RT, then analyze retweeted_status as a new post
	console.log("THIS IS A RT");

	// get our guy that has post in the first place
	Seuron our_guy = seuronExists( tweet.retweeted_status.user.id );

	// console.log("our_guy before : " + our_guy);
	// if our guy is not a seuron, then create it
	if( our_guy == null  ) our_guy = createSeuron( tweet.retweeted_status.user.id, tweet.retweeted_status.user, false )
	console.log("this is our RT guy  : " + our_guy.id);

	// add our guy to the lookup
	// our_guy.lookup = true;

	// get existing synapse from reply_guy
	Synapse synapse = boss.getSynapse( our_guy.id );

	// console.log("our synpase before : " + synapse);

	// if synapse doesnt already exist, then it means that the guy is unknown
	// so we create the synapse with value of 4
	if( synapse == null ) synapse = boss.createSynapse( our_guy, 4 ) ;

	console.log("our synapse : " + synapse);
	// console.log(synapse);

	// now create the message 
	createMessage( twitterTransmitter, synapse, 2, tweet );

	// deal with other user that has been quoted in the message
	if(tweet.entities.user_mentions.length>0){
		analyzeMentions( boss, tweet.entities.user_mentions, tweet.in_reply_to_user_id, tweet );
	}

	// Now we can process the original message, as the data is inside

	// change context to original message
	Object original_tweet  = tweet.retweeted_status;

	// analyze original message
	analyzeTweet(original_tweet);
}

void analyzeReply(  Seuron boss, Object tweet ){
	// console.log("this is a reply");
	
	// get message 
	Object original_message  = tweet.in_reply_to_status_id;

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
	Seuron reply_guy = seuronExists( tweet.in_reply_to_user_id );

	// console.log(reply_guy);
	// console.log("our_guy before : " + reply_guy);

	// if reply_guy is not a seuron, then create it
	if( reply_guy == null ) reply_guy = createSeuron( tweet.in_reply_to_user_id, null, false )
	
	console.log(" this is a reply to : " + reply_guy.id);


	// add our guy to the lookup
	// reply_guy.lookup = true;

	

	// get existing synapse from reply_guy
	Synapse synapse = boss.getSynapse( reply_guy.id );
	
	// console.log("our synpase before : " + synapse);

	// if synapse doesnt already exist, then it means that the guy is unknown
	// so we create the synapse with value of 4
	if( synapse == null ) synapse = boss.createSynapse( reply_guy, 4 ) ;

	console.log("the synpase atached to this message is : " + synapse);

	// now create the message 
	createMessage( twitterTransmitter, synapse, 3, tweet );

	// create other relations with guys quoted in the message 
	if(tweet.entities.user_mentions.length>0){
		analyzeMentions( boss, tweet.entities.user_mentions, tweet.in_reply_to_user_id, tweet );
	}
}

void analyzeMentions( Seuron boss, Object mentions, int exclude_id, Object data ) {

	// log everything
	int tt;
	console.log("total mentions in this tweet : " + mentions.length);
	if(exclude_id) console.log("a user has been excluded : " + exclude_id);

	//loop into mentions
	for (int i = 0; i<mentions.length; i++){
		// console.log(mentions[i].id);

		// exclude id that has been passed 
		if(mentions[i].id != exclude_id ) {

			//check if user seuron already exists
			Seuron seuron = seuronExists( mentions[i].id );
			// seuron.lookup = true;
			
			if( seuron != null ) { 

				console.log("-- this user already exists : " + seuron.id);
				
				// get existing Friendship (Synapse)
				Synapse synapse = boss.getSynapse( mentions[i].id );

				console.log("----- user synapse before : " + synapse);
				// if synapse doesnt already exist, then it means that the guy is unknown
				// so we create the synapse with value of 4
				if( synapse== null ) synapse = boss.createSynapse( seuron, 4 ) ;

				console.log("---- user synapse after : " + synapse);

				// create message
				createMessage( twitterTransmitter, synapse, 3, data );

			} else {

				// create new Seuron
				Seuron s = createSeuron( mentions[i].id, null, false);
				
				console.log("-- this user was created : " + s.id );

				// create new Synapse with value 4
				Synapsesynapse = boss.createSynapse( s, 4 );

				console.log("---- this synapse was created : " + synapse );


				// create message
				createMessage( twitterTransmitter, synapse, 4, data );	
			}

			tt++;
		}
	}

	console.log( "number of users analyzed for this tweet : " + tt )
}