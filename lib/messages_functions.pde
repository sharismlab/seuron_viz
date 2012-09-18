// create an interaction for each message 
void createMessage( Transmitter service, int id, Object data ) {

	Message m = new Message( service, id, data );
	
	messages.push( m );
	messageIds.push( m );
}
