/* 
Synapse class is intended to store relationships between seurons.

	It contains an object with 3 values : Seuron A, Seuron B, int level, int weight
		ex : Synapse( A, B, 1 )

	Level : is a int that decribes the level of relationship between 2 seurons

		Unknown:			0
		Friend & Follow:	1 
		is Friend of:		2 
		is Followed by: 	3
		No relationships:	4

	Synapses are directionals
		
		Synapse(A, B, 3) means that A is followed by B, i.e. B follows A
		Synapse(B, A, 3) means the opposite, i.e. A follows B

	Weight : represents the quantity of activity between 2 seurons. 
			Every time there is an interactions, it is increased 
			example : RT +1
*/ 


class Synapse {
	Seuron seuronA; 
	Seuron seuronB; 
	int level;
	color[] colors = [ color(255, 255, 255), color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(102, 85, 100) ];


	Synapse(Seuron _seuronA, Seuron _seuronB, int _level) {
		seuronA = _seuronA;
		seuronB = _seuronB;
		level = _level;
	}

	void display() {
		stroke(colors[level]);
		line(seuronA.cx, seuronA.cy, seuronB.cx,seuronB.cy);
	}


} 