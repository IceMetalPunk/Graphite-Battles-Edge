draw_circle(x, y, 5, false);

if (!is_undefined(edges)) {
	for (var i = 0; i < array_length_1d(edges); ++i) {
		draw_line(x, y, edges[i].x, edges[i].y);	
	}
}