int nbNeurons=1;
Neuron[] neurons;

void setup() {
	size(800, 800, P2D);
	smooth();
	noStroke();
	neurons=new Neuron[nbNeurons];
	for (int i = 0; i<nbNeurons; i++){
		neurons[i]=new Neuron(width/2, height/2);
	}
}

void draw() {
	background(50);
	for (int i = 0; i<nbNeurons; i++){
		neurons[i].draw();
	}
}


void mousePressed() {
	for (int i = 0; i<nbNeurons; i++){
		neurons[i]=new Neuron(width/2, height/2);
	}
}