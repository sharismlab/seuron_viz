/* 
Synapse class is intended to store relationships between seurons.

It contains an object with 3 values : Seuron A, Seuron B, int level
	ex : Synapse( A, B, 1 )

Level is a int that decribes the level of relationship between 2 seurons

	Unknown:			0
	Friend & Follow:	1 
	is Friend of:		2 
	is Followed by: 	3
	No relationships:	4

Synapses are directionals
	
	Synapse(A, B, 3) means that A is followed by B, i.e. B follows A
	Synapse(B, A, 3) means the opposite, i.e. A follows B


*/ 


class Synapse {
	Seuron seuronA; 
	Seuron seuronB; 
	int level;


	Synapse(Seuron _seuronA, Seuron _seuronB, int _level) {
		
		seuronA =_seuronA;
		seuronB = _seuronB;
		level = _level;

	}


} 
