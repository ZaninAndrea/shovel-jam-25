shader_type canvas_item;

void vertex() {
	if (mod(TIME, 14.0) < 0.2){
		UV.x += sin(mod(TIME, 12.0) * 30.0) * 0.03;
		UV.y += sin(mod(TIME, 12.0) * 55.0) * 0.03;
	}
}
