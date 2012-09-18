/*
Interaction class

	Actions are defined by the following int
			0 :		unknown
			1 :		post
			2 : 	RT
			3 :		answer
			4 :		quote(s) - at
*/

class Interaction {  

	int action;
	Transmitter service;
	Object data;
	var mentions = [];// à dev
	Synapse synapse;
	color[] colors = [ color(255, 255, 255), color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(102, 85, 100) ];
	// int  id;


	Interaction( Transmitter _service, Synapse _synapse, int _action, Object _data ) {

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

		strokeWeight(1);
		stroke( colors[action] );
		
		line( synapse.seuronA.cx, synapse.seuronA.cy, synapse.seuronB.cx, synapse.seuronB.cy);
	}

}

