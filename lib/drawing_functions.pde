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
int view = 1;

void draw() {
	// DRAW BACKGROUND
		var gradient = ctx.createRadialGradient( width/2, height/2, 0, width/2, height/2, width*0.5); 
		gradient.addColorStop(0,'rgba(80, 80, 80, 1)');
		gradient.addColorStop(1,'rgba(50, 50, 50, 1)'); 
		ctx.fillStyle = gradient; 
		ctx.fillRect( 0, 0, width, height ); 

	// draw caption
	if(view==1) drawCaptions();

	if(view==2) drawThreads();

	if(view==3) {
		
		// drawThreadsForce();
		/*
		daddy.displayMessages();

		for (int i = 0; messages[i]; i++){
			messages[i].radius = messages[i].interactions.length*10;
			// console.log(messages[i].radius);
			if( dist(mouseX, mouseY, messages[i].posX, messages[i].posY) < messages[i].radius/2) {
			
				messages[i].showInfoBox();
				for (int j = 0; messages[i].interactions[j]; j++){
					messages[i].interactions[j].display();
				}
			}	
		}
		*/


		

		/*for (int i = 0; threads[i]; i++){
			stroke(255);

			beginShape();
			for (int j = 0; threads[i].messageIds[j]; j++){
				// threads[i].display();
				
				stroke(255);
				// int index = getMessageIndex( threads[i].messageIds[j] );
				// console.log(messages[index].posX);
				// vertex( messages[index].posX, messages[index].posY);
			}
			endShape();
			
		}*/

		for (int i = 0; nodes[i]; i++){

			if( dispIds.indexOf( seurons[i].id ) != -1) seurons[i].cx = seurons[i].ease(seurons[i].cx, nodes[i].x, 0.8);
			if( dispIds.indexOf( seurons[i].id ) != -1) seurons[i].cy = seurons[i].ease(seurons[i].cy, nodes[i].y, 0.8);
			if( dispIds.indexOf( seurons[i].id ) != -1)  seurons[i].display();

		}

		drawForce();
	}

	// DRAW TIMELINE
	drawTimeline();

	// DISPLAY OUR GUYS
	if( view ==1 && displaySeuron == true) displayAllSeurons();

	// DRAW DADDY
	if( view == 1 && displayDaddy == true) daddy.display();

	//DISPLAY COUNTER
	if(frameCount%5==0 && msgDispCount<messages.length){
		msgDispCount++;
		// console.log(msgDispCount);
	}

	
	//////////////////////////Switch View Button
		pushMatrix();
		// if(view!=2) translate(50, 0);
		if(mouseX>width-150+(view==2?0:40) && mouseX<width-60+(view==2?0:40) && mouseY>45 && mouseY<75){
		fill(150);
		viewChangeable=true;
		}
		else{
			viewChangeable=false;
			fill(80);
		}
		rectMode(CORNER);
		// noStroke();
		stroke(0);
		rect(width-150+(view==2?0:40),15,90,60,5,5);
		fill(255);
		textAlign(CENTER);
		text("Switch View", width-105+(view==2?0:40), 63);

		fill(0);
		rect(width-150+(view==2?0:40),15,90,30,5,5);
		fill(255);
		textAlign(CENTER);
		if(view ==1) text("Relationships", width-105+(view==2?0:40), 33);
		else if(view ==2) text("Interactions", width-105+(view==2?0:40), 33);
		else if(view ==3) text("Connections", width-105+(view==2?0:40), 33);
		popMatrix();
}


void drawCaptions(){
	textAlign(LEFT);
	fill(255);
	// text("Press Mouse Button To Show Messages", 15,height-90);

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
						// int threadIndex=isInThread(seurons[i].messageIds[j]);
						// if(threadIndex==null){
							int index = getMessageIndex(seurons[i].messageIds[j] );
							// console.log( messages[index].interactions );
							if(index<msgDispCount-1){
								for (int k = 0;  messages[index].interactions[k]; k++){	

									if(messages[index].interactions[k].synapse.seuronA.id==seurons[i].id || messages[index].interactions[k].synapse.seuronB.id==seurons[i].id){
										stroke(messages[index].interactions[k].couleur);
										strokeWeight(2);
										noFill();
										bezier(seurons[i].cx, seurons[i].cy,seurons[i].cx, seurons[i].cy+150, messages[index].timelinePosX, messages[index].timelinePosY-150,messages[index].timelinePosX, messages[index].timelinePosY);
									}
								}
							}
						// }
						// else{

						// }

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
				if(dist(mouseX, mouseY, messages[i].timelinePosX, messages[i].timelinePosY)<=5  || (i==msgDispCount-1 && msgDispCount!=messages.length)){
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
				if(dispIds.indexOf(messages[i].interactions[j].synapse.seuronA.id) == -1) dispIds.push(messages[i].interactions[j].synapse.seuronA.id);
				if(dispIds.indexOf(messages[i].interactions[j].synapse.seuronB.id) == -1) dispIds.push(messages[i].interactions[j].synapse.seuronB.id);
			}
		}

	////////////////////////DRAW THREADS
		for (int i = 0; threads[i]; i++){
			//display threads
			for(int j=0; threads[i].messageIds[j]; j++){
				if(getMessageIndex(threads[i].messageIds[j])<=msgDispCount-1){
					threads[i].displayTL();
				}
			}
			// threads[i].displayTL();
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


float scrollY=0;
boolean scrollDraggable = false;
void drawThreads(){
	////////////////////////CAPTIONS
		fill(30);
		noStroke();
		rect(15,15,165,height-105,8,8);
		textAlign(LEFT);
		fill(255);
		text("MESSAGES:", 30, 40);
		fill(#8d2eb0);
		ellipse(40, 60, 10, 10);
		stroke(#8d2eb0);
		line(30,60,50,60);
		noStroke();
		fill(255);
		text("TWEET", 60, 65);
		fill(#d42026);
		ellipse(40, 90, 10, 10);
		stroke(#d42026);
		line(30,90,50,90);
		noStroke();
		fill(255);
		text("RETWEET", 60, 95);
		fill(#e9e32e);
		ellipse(40, 120, 10, 10);
		stroke(#e9e32e);
		line(30,120,50,120);
		noStroke();
		fill(255);
		text("REPLY", 60, 125);
		fill(255,80);
		ellipse(45, 165, 30, 30);
		ellipse(45, 165, 20, 20);
		ellipse(45, 165, 10, 10);
		stroke(255);
		line(30,165,60,165);
		noStroke();
		fill(255);
		text("INTERACTIONS", 70, 170);

		fill(255);
		text("INTERACTIONS:", 30, 250);
		fill(#ee64ff);
		ellipse(30, 270, 10, 10);
		fill(255);
		text("MENTION", 45, 275);
		fill(#00FF85);
		ellipse(30, 300, 10, 10);
		fill(255);
		text("RETWEET", 45, 305);
		fill(#ff9000);
		ellipse(30, 330, 10, 10);
		fill(255);
		text("REPLY", 45, 335);


	////////////////////////SCROLLBAR
		fill(30);
		noStroke();
		rect(width-32,13,19,height-109,8,8);
		
		if(mouseX>width-30 && mouseX<width-15 && mouseY>15+scrollY && mouseY<15+scrollY+60){
			fill(150);
			if(mousePressed) scrollDraggable=true;
		}
		else fill(80);

		if(scrollDraggable){
			scrollY+=mouseY-pmouseY;
			scrollY=constrain(scrollY, 0, height-173);
		}

		rect(width-30,15+scrollY,15,60,6,6);


	////////////////////////DRAW THREADS
		float countThreads;
		float step;
		for (int i = 0; threads[i]; i++){
			if(threads[i].messageIds.length>1) countThreads++;
		}
		// console.log(countThreads);
		step=(threads.length*30)/countThreads;
		
		countThreads=0;
		pushMatrix();
		translate(0,map(scrollY,0, height-173, 0, -threads.length*30));
		for (int i = 0; threads[i]; i++){
			threads[i].displayable=false;
			//display threads
			if(threads[i].messageIds.length>1){

				countThreads++;

				threads[i].posY= 30+countThreads*step;
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


void mouseReleased(){
	scrollDraggable=false;

	if(viewChangeable){
		if(view==1) view=2;
		else if (view==2) view=3;
		else view=1;
		viewChangeable=false;
	}
}