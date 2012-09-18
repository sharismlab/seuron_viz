// get index of a message in the mentions timeline
void getReplyIndex( int id ) {
	for (int i = 0; timelineMentions[i]; i++){
		if( timelineMentions[i].id == id ) return i;
	}
	return null
}

void hasReply(int id) {
	int indexPrev = isInThread( id );

}

// create an interaction for each message 
void createMessage( Transmitter service, int id, Object tweet ) {

	var threadTmp = [];
	Message m = new Message(service, id, tweet);
	
	messages.push( m );
	messageIds.push( id );

	int index = isInThread( id );

	if( index == null) {
		

		threadTmp.push(id);
		

		if (tweet.in_reply_to_status_id != null) {

			// int indexPrev = isInThread( tweet.in_reply_to_status_id );
			if(indexPrev != null ) thread[indexPrev].messageIds.push(id);
			else createThread( tweet );


		} 
		else if (tweet.retweeted_status) {
			int indexPrev = isInThread( tweet.retweeted_status.id );
			if(indexPrev != null ) thread[indexPrev].messageIds.push(id);
			else createThread( tweet );	
		} 
	} else{ 
		threads[index].messageIds.push(id);
	}
}


void isInThread(int messageId) {
	for (int i = 0; threads[i]; i++){
		// console.log(threads[i]);
		for (int j = 0; threads[i].messageIds[j]; j++) {
			if(threads[i].messageIds[j] == messageId) return i;
		}	
	}
	return null
}

void createThread( Object tweet ) {
	
	// create thread
	Thread t = new Thread();

	// add message to thread
	t.messageIds.push(tweet.id);

	// add thread to global array
	threads.push(t);

}