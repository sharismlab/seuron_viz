var nodes = [];
DirectedGraph g=null;


//create graph
void createForceGraph() {
	
	// define a graph
  	g = new DirectedGraph();

	// define some nodes
	for (int i = 0; seurons[i]; i++){
		nodes.push( new Node( i, seurons[i].tarX, seurons[i].tarY ) );
	}

	// add force
	g.setFlowAlgorithm(new ForceDirectedFlowAlgorithm());
  	redraw();
}

void drawForce() {

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
	
	//add nodes to the graph
	for (int i = 0; nodes[i]; i++){
	
		if( dispIds.indexOf( seurons[i].id ) != -1) g.addNode(nodes[i]);
		if(seurons[i].isSelected) seurons[i].showName();

		if(dist(mouseX, mouseY, seurons[i].cx, seurons[i].cy)<seurons[i].radius/2) {
			seurons[i].isSelected = true;
		}
		else {
				seurons[i].isSelected=false;
		}

		if( dist(mouseX,mouseY, daddy.cx, daddy.cy)<daddy.radius/2) {
			daddy.isSelected = true;
			// console.log("daddy.isSelected = true")
			daddy.showName();
			showInfoBox();
		}
		else daddy.isSelected = false;
	}

	// link nodes
	// console.log(interactionIds);
	for (int i = 0; messages[i]; i++){

		for (int j = 0; messages[i].interactions[j]; j++){
	  		
			// if(messages[i].interactions[j].synapse.seuronA.id != daddy.id && messages[i].interactions[j].synapse.seuronB.id != daddy.id ){
				
				// add all interactions to seurons force graph
				int indexA = getNodeIndex(messages[i].interactions[j].synapse.seuronA.id);
				int indexB = getNodeIndex(messages[i].interactions[j].synapse.seuronB.id);
				// console.log(g);
				g.linkNodes( nodes[indexA], nodes[indexB] );}

		// }
		
	}

	if(g!=null){
	    boolean done = g.reflow();
	    g.draw();
	    if(!done) { loop(); } else { noLoop(); }
	}

}

/*
DirectedGraph graphThread=null;
nodesThread = [];
graphs = [];

void createThreadsForce() {
	
	for (int i = 0; threads[i]; i++){
		graphs.push(new DirectedGraph())	

		for (int i = 0; messages[i]; i++){
			graphs[i].push( new Node( "message", random(50, width-50), random(100,height-100) ) );
			
		}


	}

	// add force
	graphThread.setFlowAlgorithm(new ForceDirectedFlowAlgorithm());
  	redraw();

  	//add nodes to the graph
	for (int i = 0; nodesThread[i]; i++){
		graphThread.addNode(nodesThread[i]);
	}

	//add links
	for (int i = 0; threads[i]; i++){
		for (int j = 1; threads[i].messageIds[j]; j++){
				
			console.log(k);
			int indexA = getMessageIndex(threads[i].messageIds[j]);
			int indexB = getMessageIndex(threads[i].messageIds[k]);

			graphThread.linkNodes(nodesThread[indexA],nodesThread[indexB] );
			
		}
	}
}

void drawThreadsForce() {
	if(graphThread!=null){

	    boolean done = graphThread.reflow();
	    graphThread.draw();
	    if(!done) { loop(); } else { noLoop(); }
	}
	
}
*/
// return index in nodes[] from a seuron Id
// the node corresponding to the seuron should have the same index
// so seuron function should work
void getNodeIndex( int seuronID ) {
	for (int i = 0; seurons[i]; i++){
		if(seurons[i].id == seuronID) return i;
	}
	return null;
}