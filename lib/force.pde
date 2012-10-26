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
	
	// console.log(seurons.length);
	for (int i = 0; seurons[i]; i++){
		
		// define some nodes
		var node = {};
		
		if(i!=0) node.color = hex( colors[seurons[0].synapses[seurons[0].getSynapse( seurons[i].id )].level-1],6) ;

		node.name = seurons[i].screen_name;

		node.name = seurons[i].name;
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