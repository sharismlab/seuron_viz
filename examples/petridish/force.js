var width = 720, height= 720;

var force = d3.layout.force()
    .charge(-120)
    .linkDistance(30)
    .size([width, height]);

force.
	nodes(seurons)