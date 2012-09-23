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
	
	//add nodes to the graph
	for (int i = 0; nodes[i]; i++){
	
		g.addNode(nodes[i]);	
	
	}

	// link nodes
	// console.log(interactionIds);
	for (int i = 0; messages[i]; i++){


		for (int j = 0; messages[i].interactions[j]; j++){
	  		

			// add all interactions to seurons force graph
			int indexA = getNodeIndex(messages[i].interactions[j].synapse.seuronA.id);
			int indexB = getNodeIndex(messages[i].interactions[j].synapse.seuronB.id);
			g.linkNodes(nodes[indexA], nodes[indexB]);
		}
		
	}

	if(g!=null){

	    boolean done = g.reflow();
	    // g.draw();
	    if(!done) { loop(); } else { noLoop(); }
	}

	
}

// return index in nodes[] from a seuron Id
// the node corresponding to the seuron should have the same index
// so seuron function should work
void getNodeIndex( int seuronID ) {
	for (int i = 0; seurons[i]; i++){
		if(seurons[i].id == seuronID) return i;
	}
	return null;
}