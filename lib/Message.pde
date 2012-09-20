class Message {

	int id;
	Transmitter service;
	Object data;
	var interactions = [];
	int seconds;

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

	}
	
	var hashtags = [];
	var links = [];
	String date, text;
	int seconds, type;
	color couleur = colors[0];
	
	void splitData( Object data ) {
		// console.log(data);

		text = data.text;
		
		date = parseTwitterDate(data.created_at);
		// console.log(date);

		seconds = Date.parse(date);
			if(seconds<dateMin){
				dateMin = seconds;
				// println("dateMin: " + dateMin);
			}
			else if(seconds>dateMax){ 
				dateMax = seconds;
				// println("dateMax: " + dateMax);
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


}