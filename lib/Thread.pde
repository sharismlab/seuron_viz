class Thread
{
	
	var messageIds = []; // only ids
	boolean displayable = false;

	float posX=240, posY=50, prevPosX;

	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	
	Thread () {
		prevPosX= posX;
		// prevPosY = posY;
		// expression
	}

	void displayTL(){
		stroke(255);
		strokeWeight(2);
		noFill();
		beginShape();
		for(int i=0; messageIds[i]; i++){
			for (int j = 0; messages[j]; j++){
				if(messages[j].id==messageIds[i]){
					vertex(messages[j].timelinePosX, messages[j].timelinePosY);
				}
			}
		}
		endShape();
	}


	void display(){
		for(int i=0; messageIds[i]; i++){
			for (int j = 0; messages[j]; j++){
				if(messages[j].id==messageIds[i]){
					stroke(messages[j].couleur);
					line(prevPosX, posY, posX+(messageIds.length-1-i)*(width-350)/(messageIds.length-1),posY);
					prevPosX = posX+(messageIds.length-1-i)*(width-350)/(messageIds.length-1);
				}
			}
		}

		for(int i=0; messageIds[i]; i++){
			for (int j = 0; messages[j]; j++){
				if(messages[j].id==messageIds[i]){
					var angle = TWO_PI/messages[j].interactions.length;
					for(int k=0; messages[j].interactions[k]; k++){
						var x = posX+(messageIds.length-1-i)*(width-350)/(messageIds.length-1)+ cos(angle*k+.65)*((messages[j].interactions.length+1)*5+5);
						var y = posY + sin(angle*k+.65)*((messages[j].interactions.length+1)*5+5);
						
						stroke(messages[j].interactions[k].couleur);
						line(posX+(messageIds.length-1-i)*(width-350)/(messageIds.length-1),posY,x,y);
						fill(messages[j].interactions[k].couleur);
						ellipse(x,y,5,5);

						fill(messages[j].couleur);
						noStroke();
						ellipse(posX+(messageIds.length-1-i)*(width-350)/(messageIds.length-1),posY, (messages[j].interactions.length+1)*5,(messages[j].interactions.length+1)*5 );
						

						if( dist(mouseX, mouseY, x, y+map(scrollY,0, height-173, 0, -4*height))<2.5 && mouseY<height-80) {
							pushMatrix();
							translate(0,map(scrollY,0, height-173, 0, +4*height));
							messages[j].showInfoBox();
							translate(0,27+messages[j].messageHeight*14);
							messages[j].interactions[k].synapse.seuronA.showInfoBox();
							translate(0, 40+messages[j].interactions[k].synapse.seuronA.descHeight*14);
							messages[j].interactions[k].synapse.seuronB.showInfoBox();
							popMatrix();
						}
					}

					if( dist(mouseX, mouseY, posX+(messageIds.length-1-i)*(width-350)/(messageIds.length-1), posY+map(scrollY,0, height-173, 0, -4*height) ) < (messages[j].interactions.length+1)*5 ) {
						pushMatrix();
						translate(0,map(scrollY,0, height-173, 0, +4*height));
						messages[j].showInfoBox();
						popMatrix();
					}
				}
			}
		}

		
		
	}

}