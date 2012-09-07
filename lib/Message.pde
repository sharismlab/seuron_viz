class Message {  

	Seuron from;
	ArrayList to;
	Transmitter service;
	HashMap data;

	boolean running = false;
	float x, y, xx, yy;
	float xpos, ypos;
	float speed = 16.1;

	// constructor
	Message( Transmitter _service, Object _data ) {

		service = _service;
		data = _data;
		
		if( service.name.equals("Twitter") ) {
				analyzeTweet( data );		
		}
		
	}

	void analyzeTweet( Object data ) {
		// console.log( "this is a tweet! " );
		// console.log( data ) ;

	}

}

