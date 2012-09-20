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


void createThread( int id ) {
	
	// create thread
	Thread t = new Thread();

	// add message to thread
	t.messageIds.push(id);

	// add thread to global array
	threads.push(t);

}

//  check if the message is already in a thread 
// -- return the index position of the tread in threads[] or null
void isInThread(int messageId) {
	for (int i = 0; threads[i]; i++){
		// console.log(threads[i]);
		for (int j = 0; threads[i].messageIds[j]; j++) {
			if(threads[i].messageIds[j] == messageId) return i;
		}	
	}
	return null
}