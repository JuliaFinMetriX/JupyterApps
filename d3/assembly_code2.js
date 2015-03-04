// define margins
var margin = {top: 20, right: 80, bottom: 30, left: 150};
var nodeRadius = 18;

// graphics size without axis
var width = 960 - margin.left - margin.right;
var height = 500 - margin.top - margin.bottom;

var svg = d3.select(".canvasContainer2").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var treeData = {
    name: "3",
    copulaLink: [
        {
            name: "2",
            copulaLink: [
                { name: "1" },
                { name: "5" },
            ]
        },
        {
            name: "4",
            copulaLink: [
            ]
        },
        {
            name: "6",
            copulaLink: [
                { name: "7" },
            ]
        }
    ]
};

var tree = d3.layout.tree()
    .sort(function comparator(a, b) {
        return +a.name - +b.name;
    })
// .size([height, width - maxLabelLength*options.fontSize])
    .size([height, width])
    .children(function(d)
              {
                  return (!d.copulaLink || d.copulaLink.length === 0) ? null : d.copulaLink;
              });

var nodes = tree.nodes(treeData);
var links = tree.links(nodes);

nodes.forEach(function(d) { d.y = d.depth * 200; });

var link = d3.svg.diagonal()
    .projection(function(d)
                {
                    return [d.x, d.y];
                });

svg.selectAll("path.link")
    .data(links)
    .enter()
    .append("svg:path")
    .attr("class", "link")
    .attr("d", link);

var nodeGroup = svg.selectAll("g.node")
    .data(nodes)
    .enter()
    .append("svg:g")
    .attr("class", "node")
    .attr("transform", function(d)
          {
              return "translate(" + d.x + "," + d.y + ")";
          });

nodeGroup.append("svg:circle")
    .attr("class", "node-dot")
    .attr("r", nodeRadius)

nodeGroup.append("svg:text")
    .attr("text-anchor", "middle")
    .attr("alignment-baseline", "central")
    .text(function(d) { return d.name; });

