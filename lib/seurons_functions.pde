// create a new seuron with minimum data
// and add it to a global array containing all seurons
void createSeuron( int id, Object data, boolean lookup ) {
	
	Seuron s = new Seuron( id, data, lookup );
	
	// console.log(id);
	// console.log(lookup);

	seurons.push( s );
	seuronIds.push( id );

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

void inLookup( int id ) {
	// boolean in = false;
	for (int i = 0; toLookup[i]; i++){
		if(id == toLookup[i]) return true;
	}
	return false;
}

// add seuron to lookup list
void addToLookup( int id ) {
	// console.log(id);
	toLookup.push( id );

	// // flag seurons as active
	// int i = seuronExists(id) ;
	// seurons.push(seurons[i]);

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



	daddy.myfriends = daddy.getFriends();
	daddy.myfollowers = daddy.getFollowers();
	daddy.close  = daddy.getCloseFriends();
	daddy.unknown = daddy.getUnrelated();

	//set positions for daddy's network
	float rayon=0, angle=0;
	// draw close friends
	for (int i = 0; close[i]; i++){
		rayon = 75;
		angle = i * TWO_PI / close.length;
			
		close[i].easing=.17;
		close[i].tarX = width/2 + cos(angle) * rayon;
		close[i].tarY = height/2 + sin(angle) * rayon;
		close[i].couleur= colors[0];
	} 

	// draw friends
	for (int i = 0; myfriends[i]; i++){
		rayon = 150;
		angle = i * TWO_PI / myfriends.length;

		myfriends[i].easing=.14;
		myfriends[i].tarX = width/2 + cos(angle) * rayon;
		myfriends[i].tarY = height/2 + sin(angle) * rayon;
		myfriends[i].couleur = colors[1];
	}

	// draw followers
	for (int i = 0; myfollowers[i]; i++){
		rayon = 225;
		angle = i * TWO_PI / myfollowers.length;

		myfollowers[i].easing=.11;
		myfollowers[i].tarX = width/2 + cos(angle) * rayon;
		myfollowers[i].tarY = height/2 + sin(angle) * rayon;
		myfollowers[i].couleur = colors[2];
	}

	// draw unknown
	for (int i = 0; unknown[i]; i++){
		rayon = 300;
		angle = i * TWO_PI / unknown.length;

		unknown[i].easing=.08;
		unknown[i].tarX = width/2 + cos(angle) * rayon;
		unknown[i].tarY = height/2 + sin(angle) * rayon;
		unknown[i].couleur = colors[3];
	}