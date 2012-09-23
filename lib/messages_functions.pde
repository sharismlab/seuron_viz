// create an interaction for each message 
void createMessage( Transmitter service, int id, Object tweet ) {
	var threadTmp = [];
	Message m = new Message(service, id, tweet);
	
	messages.push( m );
	messageIds.push( id );
}


void createThread( int id ) {
	// create thread
	Thread t = new Thread();

	// add message to thread
	t.messageIds.push(id);

	// add thread to global array
	threads.push(t);
	// console.log(t);
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

void sortMessages() {
	// console.log(messages);
	messages  = messages.sort(function(a,b) { return parseFloat(a.seconds) - parseFloat(b.seconds) } );
	// console.log(messages );
}