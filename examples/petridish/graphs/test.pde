/**
 * Simmple graph layout system
 * http://processingjs.nihongoresources.com/graphs
 * (c) Mike "Pomax" Kamermans 2011
 */

DirectedGraph g=null;
int padding=30;

void setup()
{
  size(300,300);
  frameRate(24);
  noLoop();

  makeGraph();
  g.setFlowAlgorithm(new ForceDirectedFlowAlgorithm());
  redraw();
}

void draw()
{
  background(255);
   
   if(g!=null){
    
    
    boolean done = g.reflow();
    g.draw();
    if(!done) { loop(); } else { noLoop(); }
  }

}

void makeGraph() {
	// define a graph
  	g = new DirectedGraph();

	  	// define some nodes
		Node n1 = new Node("1",0,0);
		Node n2 = new Node("2",0,300);
		Node n3 = new Node("3",300,0);
		Node n4 = new Node("4",300,300);
		Node n5 = new Node("5",150,300);
		Node n6 = new Node("6",300,150);


	// add nodes to graph
	  g.addNode(n1);
	  g.addNode(n2);
	  g.addNode(n3);
	  g.addNode(n4);
	  g.addNode(n5);
	  g.addNode(n6);

	  // link nodes
	  g.linkNodes(n1,n2);
	  g.linkNodes(n1,n2);
	  g.linkNodes(n1,n2);
	  g.linkNodes(n1,n2);
	  g.linkNodes(n1,n2);
	  g.linkNodes(n1,n2);
	  g.linkNodes(n2,n3);
	  g.linkNodes(n3,n4);
	  g.linkNodes(n4,n1);
	  g.linkNodes(n1,n3);
	  g.linkNodes(n2,n4);
	  g.linkNodes(n5,n6);
	  g.linkNodes(n1,n6);
	  g.linkNodes(n2,n5);

	
}