class Message {

	int id;
	Transmitter service;
	Object data;
	var interactions = [];

	Message( Transmitter _service, int _id, Object _data  ) {

		service = _service;
		data = _data;
		id = _id;

		if( service.name.equals("Twitter") ) {
				parseTwitterData( data );		
		}

	}
	
	void parseTwitterData( Object data ) {

		// console.log( "this is a tweet! " );
		// console.log( data ) ;
	}


}