// create daddy
void createDaddy( Object daddyData ){
	
	console.log("daddy was created;");
}

// create daddy's friends 	
void createFriends( Array daddyFriends) {
	for (int i = 0; i< daddyFriends.length; i++){
		
		// check if the friend already exists
		int friend = seuronExists( daddyFriends[i] );
		
		// console.log(friend);
		if( friend != null ) {
			daddy.addFriend( seurons[friend] );
		} else {
			daddy.addFriend( createSeuron( daddyFriends[i], null, false ) );
		}
	}
}

// create daddy's followers
void createFollowers( Array daddyFollowers) {
	for (int i = 0; i< daddyFollowers.length; i++){

		int follower = seuronExists	( daddyFollowers[i] );
		
		if( follower != null  ) {
			// seurons already exists, so it is a closeFriend
			daddy.synapses[ follower ].level = 1;
		} else {
			// console.log(follower);
			// console.loopg('create new');
			daddy.addFollower( createSeuron( daddyFollowers[i], null, false ) );
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
	if( lookup == false ) addToLookup( id );
		
	return s;
}

// check if a seuron exists
void seuronExists( int id ) {
	
	int existence;

	// if it doesn't exists return false
	if( seuronIds.indexOf( id ) == -1) {
		existence = null;
	} else {
		// console.log("this seuron already exists");
		existence = seuronIds.indexOf( id );
	}
	return existence
}

// add seuron to lookup list
void addToLookup( int id ) {
	// console.log(id);
	toLookup.push( id );

	// requests users from quotes
	if( toLookup.length == 100 ) {

		// check if we are on local or prod environment
		// if( ENV == "dev" ) lookupLocalData();
		lookupUsers( toLookup );

		toLookup = new Array;
	}
}

void parseUser( Object userData) {

	i = seuronIds.indexOf( userData.id );
	// console.log(i);
	if( i != -1  ) {

		// tell seuron parser that data is a user profile
		userData.isProfile =true;

		// populate seuron with data
		seurons[i].populate( userData );

		// console.log ("lookup : "+ i.lookup);
	}
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
		Message message = messages[i];
		return message;
	} else {
		return null;
	}	
}