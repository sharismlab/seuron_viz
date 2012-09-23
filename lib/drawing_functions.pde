var colors = [ #c7eab4, #7fcebb, #41b7c5, #2d7fb9 ];
var captions = [
		"Friend & Follow", 
		"Following", 
		"Follower",
		"Unrelated"
		];


// ------------------------------- MAIN DRAWING FUNCTION
int msgDispCount=0;
var dispIds = [];
boolean viewChangeable = true;
int view = 3;
void draw() {
	////////////////////////////////////////////////////////////////

	// DRAW BACKGROUND
		var gradient = ctx.createRadialGradient( width/2, height/2, 0, width/2, height/2, width*0.5); 
		gradient.addColorStop(0,'rgba(80, 80, 80, 1)');
		gradient.addColorStop(1,'rgba(50, 50, 50, 1)'); 
		ctx.fillStyle = gradient; 
		ctx.fillRect( 0, 0, width, height ); 

	 // draw caption
	if( view == 1) drawCaptions();

	// DRAW TIMELINE
	drawTimeline();

	// DISPLAY OUR GUYS
	if( view ==1 && displaySeuron == true) displayAllSeurons();

	// DRAW DADDY
	if( view == 1 && displayDaddy == true) daddy.display();

	if(frameCount%1==0 && msgDispCount<messages.length){
		msgDispCount++;
		// console.log(msgDispCount);
	}

	if(msgDispCount==10){
		viewChangeable = true;
		// console.log(viewChangeable);
	}

	if(viewChangeable) {
		if(mouseX>15 && mouseX<90 && mouseY>height/2-15 && mouseY<height/2+15){
			fill(200);
			if(mousePressed){
				
				console.log(view);

				if(view==1 ) view=2;
				else if(view==2) view=3;
				else view=1;
				
				fill(150);
			}
		}
		else{
			fill(0);
		}
		rectMode(CORNER);
		noStroke();
		rect(15,height/2-15,75,30);
		fill(255);
		textAlign(CENTER);
		text("Switch View", 50, height/2+3);
	}

	if(view==2) drawThreads();

	if(view==3) {
		
		drawForce();
	}

}

void drawCaptions(){

	textAlign(LEFT);
	fill(255);
	text("Press Mouse Button To Show Messages", 15,height-90);

	for(int i=4; i>=0; i--){
		strokeWeight(.6*i);
		stroke(30);
		noFill();
		ellipse(width/2, height/2, 75+i*150, 75+i*150);
		if(i<=3){
			line(width/2,height/2-75/2-i*75, width-15,height/2-75/2-i*75);
			fill(colors[i]);
			textAlign(RIGHT);
		 	text(captions[i].toUpperCase(), width-15, height/2-85/2-i*75);
		}
	}
}

int dateMin = (new Date()).getTime(); // Return the number of milliseconds since 1970/01/01:
int dateMax = 0;
float TimelinePosX=0, TimelinePosY=0;

// float descHeight;
void drawTimeline(){
	////////////////////////DRAW TIMELINE ELEMENTS
		ctx.save();
		rectMode(CORNER);
		fill(60);
		noStroke();
		ctx.shadowOffsetX = 0;
		ctx.shadowOffsetY = 0;
		ctx.shadowBlur = 10;
		ctx.shadowColor = "black";
		rect(15,height-75,width-30,60);

		fill(0,80);
		rect(15,height-75,20,60);
		ctx.restore();
		pushMatrix();
		translate(29,height-45);
		rotate(-Math.PI/2);
		fill(255);
		textAlign(CENTER);
		text("Timeline",0,0);
		popMatrix();

	////////////////////////DRAW SEURONS
	if( view == 1){
		for (int i = 0; seurons[i]; i++){
			seurons[i].isSelected=false;
		}


		for (int i=0; seurons[i]; i++){// seurons[0] is daddy so begin at 1

			if(dist(mouseX, mouseY, seurons[i].cx, seurons[i].cy)<seurons[i].radius/2) {

				for(int j=0; seurons[i].messageIds[j]; j++){
					// console.log(seurons[i].messageIds[j]);

					int index = getMessageIndex(seurons[i].messageIds[j] );
					console.log( messages[index].interactions );

					for (int k = 0;  messages[index].interactions[k]; k++){	

						if(messages[index].interactions[k].synapse.seuronA.id==seurons[i].id || messages[index].interactions[k].synapse.seuronB.id==seurons[i].id){
							stroke( messages[index].interactions[k].couleur );
							strokeWeight(2);
							noFill();
							bezier(seurons[i].cx, seurons[i].cy,seurons[i].cx, seurons[i].cy+150, messages[index].timelinePosX, messages[index].timelinePosY-150,messages[index].timelinePosX, messages[index].timelinePosY);
						}
					}

				}
				
				seurons[i].isSelected = true;
			}
			else{
				seurons[i].isSelected=false;
			}

		}
		if( dist(mouseX,mouseY, daddy.cx, daddy.cy)<daddy.radius/2) {
			daddy.isSelected = true;
			// console.log("daddy.isSelected = true")
		}
		else daddy.isSelected = false;
	}

	////////////////////////DRAW MESSAGES
		// console.log(dateMin + "    " +  dateMax);
		

		for (int i = 0; i<msgDispCount; i++){
			

			stroke(messages[i].couleur);
			strokeWeight(.5);
			strokeCap(SQUARE);
			line(messages[i].timelinePosX, height-75, messages[i].timelinePosX, height-16);

			if( view == 1){
				if(dist(mouseX, mouseY, messages[i].timelinePosX, messages[i].timelinePosY)<=5  || i==msgDispCount-1){
					messages[i].showInfoBox();
					for (int j = 0; messages[i].interactions[j]; j++){
						seurons[seuronExists(messages[i].interactions[j].synapse.seuronA.id)].isSelected = true;
						seurons[seuronExists(messages[i].interactions[j].synapse.seuronB.id)].isSelected = true;

						noFill();
						strokeWeight(2);

						stroke( messages[i].interactions[j].couleur );

						// if(daddy.id != messages[i].interactions[j].synapse.seuronA.id && daddy.id != messages[i].interactions[j].synapse.seuronB.id) {
							bezier(messages[i].timelinePosX, messages[i].timelinePosY,messages[i].timelinePosX, messages[i].timelinePosY-150,messages[i].interactions[j].synapse.seuronA.cx,messages[i].interactions[j].synapse.seuronA.cy+150,messages[i].interactions[j].synapse.seuronA.cx,messages[i].interactions[j].synapse.seuronA.cy);
						// }

						// if(daddy.id != messages[i].interactions[j].synapse.seuronA.id && daddy.id != messages[i].interactions[j].synapse.seuronB.id){
							bezier(messages[i].timelinePosX, messages[i].timelinePosY,messages[i].timelinePosX, messages[i].timelinePosY-150,messages[i].interactions[j].synapse.seuronB.cx,messages[i].interactions[j].synapse.seuronB.cy+150,messages[i].interactions[j].synapse.seuronB.cx,messages[i].interactions[j].synapse.seuronB.cy);
						// }

						if(daddy.id != messages[i].interactions[j].synapse.seuronA.id && daddy.id != messages[i].interactions[j].synapse.seuronB.id){
							line(messages[i].interactions[j].synapse.seuronA.cx,messages[i].interactions[j].synapse.seuronA.cy,messages[i].interactions[j].synapse.seuronB.cx,messages[i].interactions[j].synapse.seuronB.cy);
						}

						if(mousePressed) {console.log(messages[i]); console.log(dateMax);}
					}
				}
			}

			noStroke();
			fill(messages[i].couleur,150);
			ellipse(messages[i].timelinePosX,messages[i].timelinePosY,8,8);

			for (int j = 0; messages[i].interactions[j]; j++){
				if( dispIds.indexOf( messages[i].interactions[j].synapse.seuronA.id ) == -1) dispIds.push(messages[i].interactions[j].synapse.seuronA.id);
				if( dispIds.indexOf( messages[i].interactions[j].synapse.seuronB.id) == -1 ) dispIds.push(messages[i].interactions[j].synapse.seuronB.id);
			}
		}

	////////////////////////DRAW THREADS
	for (int i = 0; threads[i]; i++){
		//display threads
		threads[i].displayTL();
	}
}

void displayAllSeurons(){

	// draw close friends
	for (int i = 0; daddy.close[i]; i++){
		if(dispIds.indexOf(daddy.close[i].id)!=-1) daddy.close[i].display();
	} 

	// draw friends
	for (int i = 0; daddy.myfriends[i]; i++){
		if(dispIds.indexOf(daddy.myfriends[i].id)!=-1) daddy.myfriends[i].display();
	}

	// draw followers
	for (int i = 0; daddy.myfollowers[i]; i++){
		if(dispIds.indexOf(daddy.myfollowers[i].id)!=-1) daddy.myfollowers[i].display();
	}

	// draw unknown
	for (int i = 0; daddy.unknown[i]; i++){
		if(dispIds.indexOf(daddy.unknown[i].id)!=-1) daddy.unknown[i].display();
	}

	//show Seuron's name if isSelected
	if(daddy.isSelected) daddy.showName();
	for (int i= 1; seurons[i]; i++){
		if(seurons[i].isSelected) seurons[i].showName();
	}
}


void drawThreads(){
	////////////////////////DRAW THREADS
	float countThreads;
	float step;
	for (int i = 0; threads[i]; i++){
		if(threads[i].messageIds.length>1) countThreads++;
	}
	// console.log(countThreads);
	step=(height-50)/countThreads;
	
	countThreads=0;
	pushMatrix();
	for (int i = 0; threads[i]; i++){
		threads[i].displayable=false;
		//display threads
		if(threads[i].messageIds.length>1){

			countThreads++;

			threads[i].posY= 25+countThreads*step;
			translate(25,0);
			// threads[i].posX= 25+dispIds.length*10;

			for (int j = 0; threads[i].messageIds[j]; j++){
				// console.log( threads[i].messageIds[j] );
				// console.log( dispIds.indexOf( threads[i].messageIds[j] ) !=-1 );
				for (int k = 0; messageIds[k] && k<msgDispCount; k++){

					if( messageIds[k] == threads[i].messageIds[j] )threads[i].displayable=true;
					
				}
				
			}
			if(threads[i].displayable) threads[i].display();
		}
	}
	popMatrix();
}
