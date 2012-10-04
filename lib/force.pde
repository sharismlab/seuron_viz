
//create data for d3.js force graph
void createForceData() {
	
	// define some nodes
	// var nodes= [];
	for (int i = 0; seurons[i]; i++){
		
		var node = {};
		node.color = seurons.couleur;
		
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
			// if( link.source == seuronExists(daddy.id) ) 

			link.strength = messages[i].interactions[j].synapse.level+1;
			
			// console.log (link.source + " -- " + link.target);
			link.couleur = messages[i].interactions[j].couleur;
			
			forceData.links.push(link);

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

/*
void drawForce() {

	for (int i = 0; nodes[i]; i++){

		if( seuronIds.indexOf( seurons[i].id ) != -1) seurons[i].cx = seurons[i].ease(seurons[i].cx, nodes[i].x, 0.8);
		if( seuronIds.indexOf( seurons[i].id ) != -1) seurons[i].cy = seurons[i].ease(seurons[i].cy, nodes[i].y, 0.8);
		if( seuronIds.indexOf( seurons[i].id ) != -1) seurons[i].display();

	}

	//add caption
	for(int i=4; i>=0; i--){
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
	}
	
	//mouse interactions
	for (int i = 0; nodes[i]; i++){
		if(dist(mouseX, mouseY, seurons[i].cx, seurons[i].cy)<seurons[i].radius/2) {
			seurons[i].isSelected = true;
			seurons[i].showInfoBox();
			seurons[i].showName();

		}
		else {
			
			seurons[i].isSelected=false;

		}

		if( dist(mouseX,mouseY, daddy.cx, daddy.cy)<daddy.radius/2) {
			daddy.isSelected = true;
			// console.log("daddy.isSelected = true")
			daddy.showName();
			daddy.showInfoBox();
		}
		else daddy.isSelected = false;
	}


	if(g!=null){
	    boolean done = g.reflow();
	    if(!done) { loop(); } else { noLoop(); }
	}
}
*/