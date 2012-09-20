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

		if( service.name.equals("Twitter") ) {
				splitData( data );		
		}

	}
	
	var hashtags, links = [];
	String date, text;
	int  seconds;
	color couleur;
	
	void splitData( Object data ) {
		date = parseTwitterDate(d.created_at);
		text = data.text;

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

		if(data.entities.links.length>0) {

			
			for (int i = 0; data.entities.links[i]; i++){
				links.push(data.entities.links[i]);
				
			}
		}

		if(data.retweeted_status) couleur = color[0];
		else if(data.in_reply_to_status_id != null ) couleur = color[1];
		else couleur = color[2];

		// console.log( "this is a tweet! " );
		// console.log( data ) ;
	}

	void parseTwitterDate(String twitterDate) {
			var tmp=twitterDate.substr(-4,4) +' . '+ twitterDate.substr(4,15);
			return tmp;
	}


}