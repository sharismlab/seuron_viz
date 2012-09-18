// create an interaction for each message 
void createInteraction( Transmitter service, Synpase syn, int action, Object data ) {

	Interaction m = new Interaction( service, syn, action, data );
	
	interactions.push( m );
	interactionIds.push( m );
}

void interactionExists( int interactionID ) {
	int i = interactionIds.indexOf(interactionID);
	if ( i != -1 ) {
		Interaction interaction = interactions[i];
		return interaction;
	} else {
		return null;
	}	
}