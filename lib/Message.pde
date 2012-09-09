/*
Message class

Actions are defined by the following int
			0 :		unknown
			1 :		post
			2 : 	RT
			3 :		answer
			4 :		quote(s)
*/

class Message {  

	int action;
	Transmitter service;
	Object data;
	// Dendrit dendrit;
	Synapse synapse;

	// boolean running = false;
	// float x, y, xx, yy;
	// float xpos, ypos;
	// float speed = 16.1;


	Message( Transmitter _service, Synapse _synapse, int _action, Object _data ) {

		service = _service;
		synapse = _synapse; // relationships
		data = _data;
		action = _action; // action of the message (rt, at, )

		if( service.name.equals("Twitter") ) {
				parseTwitterData( data );		
		}
		
	}

	void parseTwitterData( Object data ) {
		 // console.log( "this is a tweet! " );
		// console.log( data ) ;

	}

	void display() {

		stroke( color(action*20, action*30, action*50) );
		line( synapse.seuronA.cx, synapse.seuronA.cy, synapse.seuronB.cx, synapse.seuronB.cy);
	}

}

