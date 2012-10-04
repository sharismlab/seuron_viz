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

