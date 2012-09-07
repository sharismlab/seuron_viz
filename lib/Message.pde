class Message {  

	Seuron from;
	ArrayList to;
	Transmitter service;
	HashMap data;
	int type;

	boolean running = false;
	float x, y, xx, yy;
	float xpos, ypos;
	float speed = 16.1;


	// constructor
	Message( Transmitter _service, Object _data, int _type ) {

		service = _service;
		data = _data;
		type = _type;
		
		if( service.name.equals("Twitter") ) {
				parseData( data );		
		}
		
	}

	void parseData( Object data ) {
		// console.log( "this is a tweet! " );
		// console.log( data ) ;

	}

}

