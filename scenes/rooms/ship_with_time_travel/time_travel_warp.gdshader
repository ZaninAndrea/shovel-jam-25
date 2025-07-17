shader_type canvas_item;

uniform float time : hint_range(-1.0, 1.0);
uniform float intensity : hint_range(0.0, 5.0) = 1.0;
uniform vec2 center = vec2(0.5, 0.5); // Screen center

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 offset = uv - center;

    float dist = length(offset);
    float angle = atan(offset.y, offset.x);

    // Spiral swirl that increases over time
	float half_loops = 7.0;
    float spiral = pow(time, 1.0) * dist * half_loops * 3.14159;
    angle += spiral * intensity;

    // Ripple effect grows with time
	float ripple_strength = 0.0015;
    float ripple = sin(dist * 40.0 - time * 60.0) * ripple_strength * time;

    float warp_strength = intensity * ripple;

    vec2 warped_offset = vec2(cos(angle), sin(angle)) * (dist + warp_strength);
    vec2 warped_uv = center + warped_offset;

    // Chromatic aberration
    //vec4 col;
	//float aberration_strength = 0.0015*time;
    //col.r = texture(TEXTURE, warped_uv + vec2(aberration_strength, 0.0)).r;
    //col.g = texture(TEXTURE, warped_uv).g;
    //col.b = texture(TEXTURE, warped_uv - vec2(aberration_strength, 0.0)).b;
    //col.a = 1.0;
	vec4 col = texture(TEXTURE, warped_uv);

    // Fade to white as time increases
    vec4 white = vec4(1.0);
	float abs_time = abs(time);
    col = mix(col, white, min(pow(abs_time*1.1,2.0), 1.0));

    COLOR = col;
}