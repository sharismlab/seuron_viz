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