class Message {

	int id;
	Transmitter service;
	Object data;
	var interactions = [];
	int seconds;
	color[] colors = [#8d2eb0,#d42026,#e9e32e,#40be3c]

	Message( Transmitter _service, int _id, Object _data  ) {

		service = _service;
		data = _data;
		id = _id;
		// console.log(data);
		if( service.name.equals("Twitter") ) {
				if(data) splitData( data );		
		}

	}
	
	var hashtags = [];
	var links = [];
	String date, text;
	int seconds;
	color couleur;
	
	void splitData( Object data ) {
		// console.log(data);

		text = data.text;
		
		date = parseTwitterDate(data.created_at);
		seconds = Date.parse(date);
			if(seconds<dateMin){
				dateMin = seconds;
				// println("dateMin: " + dateMin);
			}
			else if(seconds>dateMax){ 
				dateMax = seconds;
				// println("dateMax: " + dateMax);
			}

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

		if(data.retweeted_status) couleur = colors[0];
		else if(data.in_reply_to_status_id != null ) couleur = colors[1];
		else couleur = colors[2];

		// console.log( "this is a tweet! " );
		// console.log( data ) ;
	}

	void parseTwitterDate(String twitterDate) {
			var tmp=twitterDate.substr(-4,4) +' . '+ twitterDate.substr(4,15);
			return tmp;
	}


}