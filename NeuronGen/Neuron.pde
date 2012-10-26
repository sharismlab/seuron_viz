class Neuron {
	float posX, posY; //Neuron
	float axonX, axonY, axonSize, axonAngle, axonNoise; //Axon
	int nbDendrite = int(random(2,10)); //Dendrites
	float[] dendX, dendY, dendSize, dendAngle, dendNoise; //Dendrites
	float[] nbSDend; //Sous-Dendrites
	float[][] sdendX, sdendY, sdendSize, sdendAngle, sdendNoise; //Sous-Dendrites

	Neuron(float _posX, float _posY) {
		posX = _posX;
		posY = _posX;
		axonSize = random(300, 350);
		axonAngle = random(TWO_PI);
		axonNoise = random(1);
		axonX = posX +cos(axonAngle+noise(axonNoise)*1.2)*axonSize;
		axonY = posY +sin(axonAngle+noise(axonNoise)*1.2)*axonSize;
		


		dendSize = new float[nbDendrite];
		dendAngle = new float[nbDendrite];
		dendNoise = new float[nbDendrite];
		dendX = new float[nbDendrite];
		dendY = new float[nbDendrite];
		nbSDend = new float[nbDendrite];
		int nbSDendMax = 8;
		sdendX = new float[nbDendrite][nbSDendMax];
		sdendY = new float[nbDendrite][nbSDendMax]; 
		sdendSize = new float[nbDendrite][nbSDendMax];
		sdendAngle = new float[nbDendrite][nbSDendMax];
		sdendNoise = new float[nbDendrite][nbSDendMax];
		for (int i = 0; i<nbDendrite; i++){
			dendSize[i] = random(200, 350);
			dendAngle[i] = axonAngle+(i+1)*TWO_PI/(nbDendrite+1)+random(-TWO_PI/(10*nbDendrite), TWO_PI/(10*nbDendrite));
			dendNoise[i] = random(1);
			dendX[i] = posX +cos(dendAngle[i]+noise(dendNoise[i])*.8)*dendSize[i];
			dendY[i] = posY +sin(dendAngle[i]+noise(dendNoise[i])*.8)*dendSize[i];

			nbSDend[i] = (int)random(3,nbSDendMax);
			boolean lr = random(1)>.5;
			for (int j = 0; j<nbSDend[i]; j++){
				sdendSize[i][j] = random(80, 110);
				sdendAngle[i][j] = dendAngle[i]+(lr?-1:1)*TWO_PI/8;
				sdendNoise[i][j] = random(1);

				float pos = dendSize[i]-(dendSize[i]-120)/nbSDend[i]*(j+2);
				float tmpX=0;
				float tmpY=0;
				float n=dendNoise[i];
				for (float k = dendSize[i]; k>pos; k--){
					tmpX = posX + cos(dendAngle[i]+noise(n)*.8)*k;
					tmpY = posY + sin(dendAngle[i]+noise(n)*.8)*k;
					n+=.005;
				}
				sdendX[i][j] = tmpX;
				sdendY[i][j] = tmpY;
				lr=!lr;
			}
		}

	}

	void draw() {
		pushMatrix();
		translate(posX, posY);
		// scale(.5);
		translate(-posX, -posY);
		axon();

		for (int i=0; i<nbDendrite; i++) {
			dendrite(i);
			for (int j=0; j<nbSDend[i]; j++) {
				sousDendrite(i,j);
			}
		}

		noyau();
		popMatrix();
	}

	void noyau() {
		fill(255,80);
		for (int i=0; i<80; i++) {
			ellipse(posX+random(-15, 15), posY+random(-15, 15), 80, 80);
		}
		fill(80, 120);
		for (int i=0; i<50; i++) {
			ellipse(posX+random(-10, 10), posY+random(-10, 10), 40, 40);
		}
	}

	void axon() {
		fill(255,80);
		float rayon=20;
		float n = axonNoise;
		for (float i=axonSize; i>0; i--) {
			float x = posX +cos(axonAngle+noise(n)*1.2)*i;
			float y = posY +sin(axonAngle+noise(n)*1.2)*i;
			if (i>80 && i%40>12) { 
				ellipse(x, y, rayon, rayon);
			}
			if (i<=80) { 
				ellipse(x, y, rayon, rayon);
				rayon+=1;
			}
			n+=.002;
		}
	}

	void dendrite(int index) {
		fill(255,80);
		float angle=dendAngle[index];
		float distance = dendSize[index];
		float n=dendNoise[index];
		float rayon=2;
		boolean lr=true;
		for (float i=distance; i>20; i--) {
			float x = posX+cos(angle+noise(n)*.8)*i;
			float y = posY+sin(angle+noise(n)*.8)*i;
			ellipse(x, y, rayon, rayon);

			rayon+=.05;
			if(i<70) rayon+=.7;
			n+=.005;
		}
	}


	void sousDendrite(int i, int j){
		fill(255,80);
		float rayon=1;
		float longueur = sdendSize[i][j];
		float angle = sdendAngle[i][j];
		float n = sdendNoise[i][j];
		for (float k=longueur; k>0; k--) {
			float x = sdendX[i][j]+cos(angle+noise(n)*.2)*k;
			float y = sdendY[i][j]+sin(angle+noise(n)*.2)*k;
			ellipse(x, y, rayon, rayon);
			rayon+=.05;
			n+=.02;
		}
	}

}