// create seurons
void addSeuron( Object data ) {

	Seuron s = new Seuron(random(20,screenWidth-50), random(100, screenHeight-150), 35, color(random(255),random(255),random(255)), data );
	seurons.add(s);
	// s.addMessage( new Message (twitterTransmitter , data) );
	seuronIds.add(s.id);
	// return s;

}

void analyzeTimeline( Object timeline ) {
	// console.log(timeline);

	for(int i; i < timeline.length; i++ ) {
		
		analyzeTweet( timeline[i] );

	}
}

// function to add a new Tweet
void analyzeTweet( Object tweet ) {
	
	// check if seurons already exists
	int index = seuronIds.indexOf( tweet.user.id );

	if( index!=-1 ) {

			// println(index);
			Seuron s = seurons.get(index);
		
			//add message to list
			s.addMessage( new Message (twitterTransmitter , tweet) );
			exist=true;
	} 
	else {

		addSeuron(tweet);

	}

	// 
	if(tweet.entities.user_mentions.length>0){
		// console.log(tweet.entities.user_mentions.length);
		for (int i = 0; tweet.entities.user_mentions[i]; i++){
			//console.log(tweet.entities.user_mentions[i]);

			int index2 = seuronIds.indexOf(tweet.entities.user_mentions[i].id);// check if seuron has already been added to seuronsIds
			//console.log(index2);
			int index3 = lookup.indexOf(tweet.entities.user_mentions[i].id);// check if seuron has already been added to lookup
			//console.log(index3);

			if(index2==-1 && index3==-1){
				lookup.add( tweet.entities.user_mentions[i].id );
				seuronIds.add( tweet.entities.user_mentions[i].id );
				// println("lookup.size(): "+ lookup.size());
				// println("seuronIds.size(): "+ seuronIds.size());
			}
		}
	}

	if( lookup.size() == 100 ) {
		loadLookup();
		lookup = new ArrayList;
	}

}


void loadLookup() {

	String url = "https://api.twitter.com/1/users/lookup.json?include_entities=true";
	url += "&user_id=";
	for (int i = 0; i<lookup.size()-1; i++){
		url += lookup.get(i) + ",";

	}
	url += lookup.get( lookup.size()-1 );

	// console.log(url);
	url="datasamples/makio135_lookup.json";
	$.getJSON(url, function(data) {
		$.each( data, function(key, item) {

			item.isProfile =true;
			// allUsers.push( item );
			seurons.add( new Seuron( random(20,canvasWidth-50), random(100, canvasHeight-150), 35, color(random(255),random(255),random(255)), item ) );

		});
	});
}