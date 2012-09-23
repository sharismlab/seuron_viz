class Thread
{
	
	var messageIds = []; // only ids
	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	
	Thread () {
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
		
	}

}