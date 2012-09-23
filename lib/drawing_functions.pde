var colors = [ #c7eab4, #7fcebb, #41b7c5, #2d7fb9 ];
var captions = [
		"Friend & Follow", 
		"Following", 
		"Follower",
		"Unrelated"
		];


// ------------------------------- MAIN DRAWING FUNCTION
void draw() {
	////////////////////////////////////////////////////////////////

	// DRAW BACKGROUND
		var gradient = ctx.createRadialGradient( width/2, height/2, 0, width/2, height/2, width*0.5); 
		gradient.addColorStop(0,'rgba(80, 80, 80, 1)');
		gradient.addColorStop(1,'rgba(50, 50, 50, 1)'); 
		ctx.fillStyle = gradient; 
		ctx.fillRect( 0, 0, width, height ); 

	 // draw caption
	drawCaptions();

	// DRAW TIMELINE
	drawTimeline();

	// DISPLAY OUR GUYS
	if( displaySeuron == true) displayAllSeurons();

	// DRAW DADDY
	if( displayDaddy == true) daddy.display();
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
		/*
		for (int i=0; seurons[i]; i++){// seurons[0] is daddy so begin at 1
			if(seurons[i].hasAvatar==true) {
				

				seconds = Date.parse(seurons[i].date);
				if(seconds<dateMin){
					dateMin = seconds;
					// println("dateMin: " + dateMin);
				}
				else if(seconds>dateMax){ 
					dateMax = seconds;
					// println("dateMax: " + dateMax);
				}

				TimelinePosX = map(seconds,dateMin,dateMax,45,width-25);
				TimelinePosY = (daddy.isFriend(seurons[i].id) && daddy.isFollower(seurons[i].id))? height-75 + 15 :
								daddy.isFriend(seurons[i].id)? height-75 + 25 :
								daddy.isFollower(seurons[i].id)? height-75 + 35 :
								height-75 + 45;


				// height-75 + map(seurons[i].cy,100,screenHeight-150,5,55);
				stroke(seurons[i].couleur,100);
				strokeWeight(2);
				strokeCap(SQUARE);
				line(TimelinePosX, height-75, TimelinePosX, height-16);
				fill(seurons[i].couleur);
				ellipse(TimelinePosX,TimelinePosY,8,8);

				if(dist(mouseX, mouseY, TimelinePosX, TimelinePosY)<8 || dist(mouseX, mouseY, seurons[i].cx, seurons[i].cy)<seurons[i].radius/2 || mousePressed) {
					noFill();
					bezier(TimelinePosX, TimelinePosY,TimelinePosX, TimelinePosY-150, seurons[i].cx, seurons[i].cy+150, seurons[i].cx, seurons[i].cy);

					seurons[i].isSelected = true;
				}
				else{
					seurons[i].isSelected=false;
				}
			}
			// else{ // debug: if seurons[i] !hasAvatar
				// console.log(i);
				// console.log(seurons[i]);
			// }
		}
		if(dist(mouseX,mouseY, daddy.cx, daddy.cy)<daddy.radius/2) {
			daddy.isSelected = true;
			// console.log("daddy.isSelected = true")
		}
		else daddy.isSelected = false;
		*/

	////////////////////////DRAW MESSAGES
		// console.log(dateMin + "    " +  dateMax);
		for (int i = 0; seurons[i]; i++){
			seurons[i].isSelected=false;
		}

		for (int i = 0; messages[i]; i++){
			

			stroke(messages[i].couleur);
			strokeWeight(.5);
			strokeCap(SQUARE);
			line(messages[i].timelinePosX, height-75, messages[i].timelinePosX, height-16);

			if(dist(mouseX, mouseY, messages[i].timelinePosX, messages[i].timelinePosY)<=5){
				messages[i].showInfoBox();
				for (int j = 0; messages[i].interactions[j]; j++){
					seurons[seuronExists(messages[i].interactions[j].synapse.seuronA.id)].isSelected = true;
					seurons[seuronExists(messages[i].interactions[j].synapse.seuronB.id)].isSelected = true;

					noFill();
					strokeWeight(2);
					stroke(messages[i].interactions[j].couleur);
					bezier(messages[i].timelinePosX, messages[i].timelinePosY,messages[i].timelinePosX, messages[i].timelinePosY-150,messages[i].interactions[j].synapse.seuronA.cx,messages[i].interactions[j].synapse.seuronA.cy+150,messages[i].interactions[j].synapse.seuronA.cx,messages[i].interactions[j].synapse.seuronA.cy);
					bezier(messages[i].timelinePosX, messages[i].timelinePosY,messages[i].timelinePosX, messages[i].timelinePosY-150,messages[i].interactions[j].synapse.seuronB.cx,messages[i].interactions[j].synapse.seuronB.cy+150,messages[i].interactions[j].synapse.seuronB.cx,messages[i].interactions[j].synapse.seuronB.cy);
					if(mousePressed) console.log(messages[i]);
				}
			}
			
			noStroke();
			fill(messages[i].couleur,150);
			ellipse(messages[i].timelinePosX,messages[i].timelinePosY,8,8);
		}
}

void displayAllSeurons(){
	var close = [];
	var myfriends = [];
	var myfollowers = [];
	var unknown = [];

	// drawSeurons
	myfriends = daddy.getFriends();
	myfollowers = daddy.getFollowers();
	close  = daddy.getCloseFriends();
	unknown = daddy.getUnrelated();

	float rayon=0, angle=0;
	// draw close friends
	for (int i = 0; close[i]; i++){
		rayon = 75;
		angle = i * TWO_PI / close.length;
			
		close[i].easing=.17;
		close[i].tarX = width/2 + cos(angle) * rayon;
		close[i].tarY = height/2 + sin(angle) * rayon;
		close[i].couleur= colors[0];

		close[i].display();
	} 

	// draw friends
	for (int i = 0; myfriends[i]; i++){
		rayon = 150;
		angle = i * TWO_PI / myfriends.length;

		myfriends[i].easing=.14;
		myfriends[i].tarX = width/2 + cos(angle) * rayon;
		myfriends[i].tarY = height/2 + sin(angle) * rayon;
		myfriends[i].couleur = colors[1];

		myfriends[i].display();
	}

	// draw followers
	for (int i = 0; myfollowers[i]; i++){
		rayon = 225;
		angle = i * TWO_PI / myfollowers.length;

		myfollowers[i].easing=.11;
		myfollowers[i].tarX = width/2 + cos(angle) * rayon;
		myfollowers[i].tarY = height/2 + sin(angle) * rayon;
		myfollowers[i].couleur = colors[2];

		myfollowers[i].display();
	}

	// draw unknown
	for (int i = 0; unknown[i]; i++){
		rayon = 300;
		angle = i * TWO_PI / unknown.length;

		unknown[i].easing=.08;
		unknown[i].tarX = width/2 + cos(angle) * rayon;
		unknown[i].tarY = height/2 + sin(angle) * rayon;
		unknown[i].couleur = colors[3];

		unknown[i].display();
	}

	for (int i= 1; seurons[i]; i++){
		if(daddy.isSelected) daddy.showName();
		if(seurons[i].isSelected) seurons[i].showName();
	}
}

void displayThreads() {
	for (int i = 0; i<threads[i]; i++){
		//display threads
		threads[i].display();
	}
}