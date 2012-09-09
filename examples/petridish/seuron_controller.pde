/*  
controller file for Seuron 
objects to handle changes 
*/


void addFriends(Object data){
	// friends = new Seuron[ data.ids.length ];

	for (int i = 0; i<data.ids.length; i++){
		// friends[i]=new Seuron(data.ids[i], 2);
		seurons.add( new Seuron(data.ids[i], 2) );
	}
	// console.log( "friends : " + friends.length);
}


void addFollowers(Object data){
	// followers=new SeuronTmp[data.ids.length];

	for (int i = 0; i<data.ids.length; i++){
		// followers[i]=new SeuronTmp(data.ids[i], 3);

		// check if already friend boolean isCloseFriend(id){}

		// if false:
		seurons.add(bnew Seuron(data.ids[i], 3) );
		// else: seurons.get(?).level=1
	}

	// console.log("followers : " + followers.length);
}

void addUnknown(Object data){
	// unknown = new SeuronTmp[data.ids.length];
	
	unknowns.push( new SeuronTmp(data.id, 4) );

	console.log("unknowns size changed : " + unknowns.length );
	console.log(unknowns);

}