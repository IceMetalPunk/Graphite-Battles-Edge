draw_set_circle_precision(64);
randomize();
var NODE_N = 10, MIN_DIST = 20;

var xx = irandom(room_width);
var yy = irandom(room_height);
nodes = ds_list_create();
with (instance_create_layer(xx, yy, "Instances", Node)) {
	nodeId = 0;
	ds_list_add(Graph.nodes, nodeId);
}

for (var i =1; i < NODE_N; ++i) {
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
		ds_list_add(Graph.nodes, nodeId);
	}
}

// Edges
edges = ds_grid_create(NODE_N, NODE_N);
ds_list_shuffle(nodes);
var polars = ds_map_create();
for (var i = 0; i < NODE_N; ++i) {
	var node1 = nodes[| i];
	var nodeInst1 = getNodeById(node1);
	if (ds_grid_value_exists(edges, 0, node1, NODE_N, node1, true)) {
		continue;
	}
	ds_map_clear(polars);
	with (Node) {
		if (nodeId == node1) { continue; }
		var r = point_distance(nodeInst1.x, nodeInst1.y, x, y);
		var theta = point_direction(nodeInst1.x, nodeInst1.y, x, y);
		ds_map_add(polars, nodeId, [r, theta]);
	}
	var visibles = ds_list_create();
	if (!ds_grid_value_exists(edges, 0, 0, NODE_N, NODE_N, true)) {
		with (Node) {
			if (nodeId == node1) { continue; }
			ds_list_add(visibles, nodeId);
		}
	}
	else {
		for (var xx = 0; xx < ds_grid_width(edges); ++xx) {
			for (var yy = 0; yy < ds_grid_height(edges); ++yy) {
				if (edges[# xx, yy]) {
					var polar1 = polars[? xx];
					var polar2 = polars[? yy];
					var th1 = polar1[1], th2 = polar2[1];
					var r1 = polar1[0], r2 = polar2[0];
					with (Node) {
						if (nodeId == node1) { continue; }
						var polar = polars[? nodeId];
						var th = polar[1], r = polar[0];
						if (!isAngleBetween(th, th1, th2) || r < min(r1, r2)) {
							ds_list_add(visibles, nodeId);
						}
					}
				}
			}
		}
	}
	if (ds_list_size(visibles) > 0) {
		ds_grid_set(edges, node1, visibles[| irandom(ds_list_size(visibles)-1)], true);
	}
	ds_list_destroy(visibles);
}

ds_map_destroy(polars);