/*																					 
by @makio135 and @clemsos
for Sharism Lab
2012
*/

var forceData = {};
forceData.nodes = [];
forceData.links = [];


// get our data
console.log(forceData);
// launchForceViz(forceData);

///////////// START D3 VIZ
function launchForceViz (data) {
	console.log("start viz now !");

	///////////// SETUP INIT

		// console.log(data);

		var selectingColor = "blue";
		var selectedColor = "green";

		// console.log($(window).height());
		var width = window.innerWidth*95/100,
			height = window.innerHeight*95/100,
			path,
			node,
			trans=[0,0],
			scale=1;;

		var color = d3.scale.category20();


		var svg = d3.select("#force")
			.append("svg:svg")
				.attr("width", width)
				.attr("height", height)
				.call(d3.behavior.zoom().on("zoom", redraw));

		force = d3.layout.force()
			.size([width, height])
			.on("tick",tick);

	
	///////////// DRAWING FUNCTIONS
		function redraw() {
			trans=d3.event.translate;
			scale=d3.event.scale;

			svg.attr("transform",
				"translate(" + trans + ")"
				+ " scale(" + scale + ")");
		}

		draw();

		function draw() {
			// Restart the force layout.
			force
				.nodes(data.nodes)
				.links(data.links)
			    .charge(-230)
			    .linkDistance(150)
			    .gravity(.06)
		        // .distance(100)
		        .linkStrength( function(d) { return (1/(1+d.strength)) } )
		        .start();

			path = svg.append("svg:g").selectAll("path")
				.data(force.links())
			  	.enter().append("svg:path")
			    .attr("class", function(d) { return "link "+d.class })
			    .attr("fill", "none")
			    .attr("stroke-width", 2)
			    .attr("stroke", function(d) { return d.color })
			    // .attr("fill-opacity", .1)
			    .attr("stroke-opacity", .1);

			path.append("svg:path")
				.attr("fill", function (d) { return d.color })
				.attr("d", "M0,-5L10,0L0,5");

			// Update the nodes
			node = svg.selectAll("g.node")
				.data(data.nodes);

			// Enter any new nodes.
			node.enter()
				.append("svg:g")
				.attr("class", "node")
				.style("fill-opacity", .5);

			node.append("svg:circle")
				.attr("r", function(d) { return 10; })
				.call(force.drag)
<<<<<<< HEAD
				.on("mouseover", fade(1,true) )
    			.on("mouseout", fade(.5,false) )
    			// .on("click", function(d) { click(d) })
=======
				.on("mouseover", fade(1,true))
    			.on("mouseout", fade(.1,false))
    			.on("click", function(d) { click(d) })
>>>>>>> f3a21f348711947f45a57bad182961cd6aa339ad
    			// .style("fill", function(d) { return colors[d.strength]-2; })
    			// .style("stroke", function(d) { return d3.rgb(color(d.strength)).darker();})
		        .style("fill" , function(d){ return d.color; })
		        ;


			node.append("svg:text")
				.attr("class", "nodetext")
				.attr("dx", ".05em")
				.attr("dy", "-.35em")
				.style("font-size", 14)
				.style("fill" , "#ff0000")
				.style("font-family" , "Arial, sans")
				.text(function(d) { return d.name })
				.call(force.drag);

			var n = data.nodes.length;
			console.log(n);
			// force.start();
			for (var i = n; i > 0; --i) force.tick();
			force.stop();
		}
		
		function tick() {
			path.attr("d", function(d) {
				var dx = d.target.x - d.source.x,
					dy = d.target.y - d.source.y,
					dr = Math.sqrt(dx * dx + dy * dy);
				return "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y;
			});
			if(!node.selected) {
				node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
				// node.attr("display", fade(0.1));
			} else {
			}
		}

		// get all elements associated to a specific node 
		var linkedByIndex = {};
		data.links.forEach(function(d) {
			linkedByIndex[d.source.index + "," + d.target.index] = 1;
		});

		function isConnected(a, b) {
			return linkedByIndex[a.index + "," + b.index] || linkedByIndex[b.index + "," + a.index] || a.index == b.index;
		}

		function fade(opacity,selected) {
			return function(d) {
<<<<<<< HEAD

=======
>>>>>>> f3a21f348711947f45a57bad182961cd6aa339ad
				seurons[d.index].isSelected=selected;

				node.style("fill-opacity", function(o) {
					return isConnected(d, o) ? opacity : .5;
					// this.setAttribute('fill-opacity', thisOpacity);
					
				});

<<<<<<< HEAD
				path.style("fill-opacity",opacity).style("stroke-opacity", function(o) {
				 	return o.source === d || o.target === d ? opacity : .1 ;
				});

=======
				path.style("stroke-opacity", function(o) {
				 	return (o.source === d || o.target === d) ? opacity : .1;
				});
>>>>>>> f3a21f348711947f45a57bad182961cd6aa339ad
			};
		}

}

////////// CAPTION INTERACTIONS
