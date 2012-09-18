// create an interaction for each message 
void createMessage( Transmitter service, int id, Object data ) {

	Message m = new Message(service, id, data);
	
	messages.push( m );
	messageIds.push( id );

	int index = isInThread(id);
	if( index == null) createThread( data );
}


void isInThread(int messageId) {
	for (int i = 0; threads[i]; i++){
		for (int j = 0; threads[i].messages[j]; j++){
			if(threads[i].messageIds[j] == messageId) return i;
		}	
	}
	return null
}

void createThread( Object tweet ) {
	
	Thread t = new Thread();
	t.messageIds.push(tweet.id);
	if (tweet.in_reply_to_status_id != null) {
		t.messageIds.push(tweet.in_reply_to_status_id);
	} 
	else if (tweet.retweeted_status) {
		t.messageIds.push(tweet.retweeted_status.id);
	}

}