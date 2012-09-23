/*
Interaction class

	Actions are defined by the following int
			0 :		unknown
			1 :		post // rien !
			2 : 	RT // green #00FF85
			3 :		answer // orange #ff9000
			4 :		@at // rose #ee64ff
*/

class Interaction {  

	int action;
	Object data;
	Synapse synapse;
	color[] colors = [ #FE0000, #FE0000, #00FF85, #ff9000, #ee64ff ];
	color couleur;

	Interaction( Synapse _synapse, int _action ) {

		synapse = _synapse; // relationships
		action = _action; // action of the message (rt, at, )
		couleur = colors[action];
	}

	void display() {

		strokeWeight(1);
		stroke( colors[action] );
		
		line( synapse.seuronA.cx, synapse.seuronA.cy, synapse.seuronB.cx, synapse.seuronB.cy);
	}

}

