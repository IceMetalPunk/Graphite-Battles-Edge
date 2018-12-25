var target = argument0, angle1 = argument1, angle2 = argument2;

var rAngle = ((angle2 - angle1) % 360 + 360) % 360;
if (rAngle >= 180) {
	var temp = angle1;
	angle1 = angle2;
	angle2 = temp;
}

if (angle1 <= angle2) {
	return (target >= angle1 && target <= angle2);
}
else {
	return (target >= angle1 || target <= angle2);
}  

