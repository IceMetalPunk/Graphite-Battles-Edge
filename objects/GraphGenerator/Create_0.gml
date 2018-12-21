var NODE_N = 10, MIN_DIST = 20;
for (var i = 0; i < NODE_N; ++i) {
	var xx, yy, nearest, dist;
	do {
		xx = irandom(room_width);
		yy = irandom(room_height);
		nearest = instance_nearest(xx, yy, Node);
		if (instance_exists(nearest)) {
			dist = point_distance(xx, yy, nearest.x, nearest.y);
		}
		else {
			dist = -1;
		}
	} until (dist > MIN_DIST);
	with (instance_create_layer(xx, yy, "Instances", Node)) {
		nodeId = i;
	}
}