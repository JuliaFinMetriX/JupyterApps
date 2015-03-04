// define margins
var margin = {top: 20, right: 80, bottom: 30, left: 150};

// graphics size without axis
var width = 960 - margin.left - margin.right;
var height = 500 - margin.top - margin.bottom;

var bisectDate = d3.bisector(function(d) { return d.idx; }).left;

var svg = d3.select(".canvasContainer").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .tickFormat(function (d) { return d/1000000000 });

// function for the x grid lines
function make_x_axis() {
    return d3.svg.axis()
        .scale(x)
        .orient("bottom")
        .ticks(5)
}

// function for the y grid lines
function make_y_axis() {
    return d3.svg.axis()
        .scale(y)
        .orient("left")
        .ticks(5)
}

var parseDate = d3.time.format("%Y-%m-%d").parse;

var line = d3.svg.line()
    .interpolate("basis")
    .x(function(d) { return x(d.idx); })
    .y(function(d) { return y(d.US); });

var tsdata = d3.csv("gdp_us.csv", function (data) {
    
    data.forEach(function(d) {
        d.idx = parseDate(d.idx);
        d.US = +d.US
    });
    
    y.domain([0, d3.max(data, function(d) { return d.US; })]);
    x.domain(d3.extent(data, function(d) { return d.idx; }));

    svg.append("g")
        .attr("class", "background")
        .append("rect")
        .attr("x", 0)
        .attr("y", 0)
        .attr("width", width)
        .attr("height", height)
    
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);


    // Add the white background to the y axis label for legibility
    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
        .append("text")
        .attr("class", "shadow")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("GDP in bn $");

    var textShadow = d3.select(".shadow")

    svg.append("g")
        .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", textShadow.attr("y"))
        .attr("dy", textShadow.attr("dy"))
        .style("text-anchor", "end")
        .text("GDP in bn $");
    
    // Draw the x Grid lines
    svg.append("g")
        .attr("class", "grid")
        .attr("transform", "translate(0," + height + ")")
        .call(make_x_axis()
              .tickSize(-height, 0, 0)
              .tickFormat("")
             )
    
    // Draw the y Grid lines
    svg.append("g")            
        .attr("class", "grid")
        .call(make_y_axis()
              .tickSize(-width, 0, 0)
              .tickFormat("")
             )
    
    svg.append("path")
        .datum(data)
        .attr("class", "line")
        .attr("d", line);
    
    var focus = svg.append("g")
        .attr("class", "focus")
        .style("display", "none");
    
    focus.append("circle")
        .attr("r", 4.5);
    
    focus.append("text")
        .attr("x", 9)
        .attr("dy", ".35em");
    
    svg.append("rect")
        .attr("class", "overlay")
        .attr("width", width)
        .attr("height", height)
        .on("mouseover", function() { focus.style("display", null); })
        .on("mouseout", function() { focus.style("display", "none"); })
        .on("mousemove", mousemove);
    
    function mousemove() {
        var x0 = x.invert(d3.mouse(this)[0]),
        i = bisectDate(data, x0, 1),
        d0 = data[i - 1],
        d1 = data[i],
        d = x0 - d0.idx > d1.idx - x0 ? d1 : d0;
        focus.attr("transform", "translate(" + x(d.idx) + "," + y(d.US) + ")");
        focus.select("text").text(d.US/1000000000);
    }
    
});

