var classes = [
		"friendfollow", 
		"following", 
		"follower",
		"unrelated"
		];

var interactionClasses = [
			"unknown", 
			"post",
			"RT",
			"answer",
			"at"
];

//create data for d3.js force graph
void createForceData() {
	
	// define some nodes
	// var nodes= [];
	// console.log(seurons.length);
	for (int i = 0; seurons[i]; i++){
		
		var node = {};
		
		if(i!=0) node.color = hex( colors[seurons[0].synapses[seurons[0].getSynapse( seurons[i].id )].level-1],6) ;

		node.name = seurons[i].screen_name;

		console.log(seurons[i].lookedUp);
		// console.log(node.name);

		//add nodes to graph data
		forceData.nodes.push( node );
	}

	// create links
	for (int i = 0; i<messages.length; i++){

		for (int j = 0; messages[i].interactions[j]; j++){

			var link = {};


				// add all interactions to seurons force graph
				link.source = seuronExists(messages[i].interactions[j].synapse.seuronA.id);
				link.target = seuronExists(messages[i].interactions[j].synapse.seuronB.id);

				link.level = messages[i].interactions[j].synapse.level+1;
				link.strength = messages[i].interactions[j].synapse.level+1;

				link.class = interactionClasses[messages[i].interactions[j].action];
				link.color = "#"+hex(messages[i].interactions[j].couleur, 6);
				

				forceData.links.push(link);
				// console.log(link);
		}
	}

	// console.log(forceData);
	launchForceViz(forceData);
}


/*// return index in nodes[] from a seuron Id
// the node corresponding to the seuron should have the same index
// so seuron function should work
void getNodeIndex( int seuronID ) {
	for (int i = 0; seurons[i]; i++){
		if(seurons[i].id == seuronID) return i;
	}
	return null;
}
*/



void mouseForce() {
	
	//mouse interactions


	/*for (int i = 0; nodes[i]; i++){
		if(dist(MX, MY, seurons[i].cx, seurons[i].cy)<seurons[i].radius/2) {
			seurons[i].isSelected = true;
			seurons[i].showInfoBox();
			seurons[i].showName();

		}
		else {
			
			seurons[i].isSelected=false;

		}

		if( dist(MX,MY, daddy.cx, daddy.cy)<daddy.radius/2) {
			daddy.isSelected = true;
			// console.log("daddy.isSelected = true")
			daddy.showName();
			daddy.showInfoBox();
		}
		else daddy.isSelected = false;
	}*/

	//add caption
	/*for(int i=4; i>=0; i--){
		strokeWeight(.6*i);
		stroke(30);
		noFill();
		// ellipse(width/2, height/2, 75+i*150, 75+i*150);
		if(i<=3){
			// line(width/2,height/2-75/2-i*75, width-15,height/2-75/2-i*75);
			fill(colors[i]);
			textAlign(RIGHT);
		 	text(captions[i].toUpperCase(), width-15, height/2-85/2-i*25);
		}
	}*/


}
/*
*/