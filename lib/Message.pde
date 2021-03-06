/*
	Class containing all informations relative to a Message
*/

class Message {

	int id;
	Transmitter service;
	Object data;
	var interactions = [];
	int seconds;
	float timelinePosX, timelinePosY;
	float posX, posY,radius;

	/*
	1 :		post
	2 : 	RT
	3 :		reply
	*/
	color[] colors = [#FF0000, #8d2eb0,#d42026,#e9e32e,#40be3c]

	Message( Transmitter _service, int _id, Object _data  ) {

		service = _service;
		data = _data;
		id = _id;
		// console.log(data);
		if( service.name.equals("Twitter") ) {
				if(data) splitData( data );	
		}
		radius = 10;
		posX = random(50,width-50);
		posY = random(200, height-200);
	}
	
	var hashtags = [];
	var links = [];
	String date, message;
	int seconds, type;
	color couleur = colors[0];
	
	void splitData( Object data ) {
		// console.log(data.created_at);

		message = data.text;
		
		date = parseTwitterDate(data.created_at);

		// console.log(date);
		// console.log("dateMax: " + dateMax);
		// console.log("dateMin: " + dateMin);
		
		seconds = Date.parse(date);
		// console.log("seconds : " + seconds);
		// if(seconds < dateMin) console.log("true");

		if(seconds < dateMin){
			dateMin = seconds;
		}
		else if(seconds > dateMax){ 
			dateMax = seconds;
			// console.log(date);
			// console.log("------------------ dateMax: " + dateMax);
		}
		// console.log(seconds);

		if(data.entities.hashtags.length>0) {
			for (int i = 0; data.entities.hashtags[i]; i++){
				hashtags.push(data.entities.hashtags[i]);
			}
		}

		if(data.entities.urls.length>0) {
			for (int i = 0; data.entities.urls[i]; i++){
				links.push( data.entities.urls[i] );
			}
		}
			/*
			1 :		post
			2 : 	RT
			3 :		reply
			*/
			type = data.in_reply_to_status_id!=null? 3 :
				   data.retweeted_status? 2 :
				   1;
			couleur = colors[type];

		// console.log( "this is a tweet! " );
		// console.log( data ) ;
	}

	void parseTwitterDate(String twitterDate) {
			var tmp=twitterDate.substr(-4,4) +' . '+ twitterDate.substr(4,15);
			return tmp;
	}

	float messageHeight;
	void showInfoBox(){
		// info box
		messageHeight=1+floor(textWidth("Message: "+message)/440);
		rectMode(CORNER);
		noStroke();
		fill(255,230);
		rect(15,15,460,20+messageHeight*14,3,3);
		fill(0);
		textAlign(LEFT);
		text("Date: "+date+"\nMessage: "+message,20,20,440,12+messageHeight*14);
	}

	void setPosition() {

		timelinePosX = map( seconds,dateMin,dateMax,45,width-25 );
		timelinePosY = (type==3)? height-75 + 15 :
						(type==2)? height-75 + 30 :
						height-75 + 45;
	}

	void display() {
		radius = interactions.length;
		fill(couleur);
		posX = timelinePosX;
		ellipse(posX,posY,radius*10,radius*10);


		for (int i = 0; interactions[i]; i++){

			// interactions[i].display();
			
			stroke(interactions[i].couleur);
			line( interactions[i].synapse.seuronA.cx, interactions[i].synapse.seuronA.cy, interactions[i].synapse.seuronB.cx, interactions[i].synapse.seuronB.cy)
			// line(x1, y1, z1, x2);
		}
	}

}