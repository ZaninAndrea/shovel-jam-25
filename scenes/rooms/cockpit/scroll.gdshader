shader_type canvas_item;

uniform float speed = 0.5;

void vertex() {
    //vec2 center = vec2(0.5);
    //vec2 dir = UV - center;
    //float dist = length(dir);
//
    //// Move UVs inward instead of outward
    //UV -= normalize(dir) * (1.0 - dist) * (1.0 - dist) * (TIME - 20.0) * speed;
	//
	//UV.y = UV.y+TIME * 0.01;

	//if ( UV.x == 0.0){
		//UV.x+=fract(TIME * 0.1)*0.5;
	//}
	//if ( UV.x == 1.0){
		//UV.x-=fract(TIME * 0.1)*0.5;
	//}
}

void fragment() {
	vec2 uv = SCREEN_UV;

	// Scroll vertically with time
	//uv.y += TIME * 0.03;

	COLOR = texture(TEXTURE, uv);
}