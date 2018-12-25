draw_set_color(c_black);
draw_circle(round(x), round(y), 2, false);

if (!is_undefined(Graph.edges)) {
	for (var i = 0; i < ds_grid_width(Graph.edges); ++i) {
		if (Graph.edges[# nodeId, i]) {
			var nextNode = getNodeById(i);
			draw_line(x, y, nextNode.x, nextNode.y);
		}
	}
}