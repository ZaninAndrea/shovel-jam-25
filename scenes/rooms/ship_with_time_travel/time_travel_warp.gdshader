shader_type canvas_item;

uniform float time : hint_range(0.0, 1.0);
uniform float intensity : hint_range(0.0, 5.0) = 1.0;
uniform vec2 center = vec2(0.5, 0.5); // Screen center

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 offset = uv - center;

    float dist = length(offset);
    float angle = atan(offset.y, offset.x);

    // Spiral swirl that increases over time
    float spiral = time * dist * 4.0 * 3.14159; // up to 2 full turns outward
    angle += spiral * intensity;

    // Ripple effect grows with time
    float ripple = sin(dist * 40.0 - time * 60.0) * 0.005 * time;

    float warp_strength = intensity * (0.05 * dist + ripple);

    vec2 warped_offset = vec2(cos(angle), sin(angle)) * (dist + warp_strength);
    vec2 warped_uv = center + warped_offset;

    // Chromatic aberration
    vec4 col;
    col.r = texture(TEXTURE, warped_uv + vec2(0.0015, 0.0)).r;
    col.g = texture(TEXTURE, warped_uv).g;
    col.b = texture(TEXTURE, warped_uv - vec2(0.0015, 0.0)).b;
    col.a = 1.0;

    // Fade to white as time increases
    vec4 white = vec4(1.0);
    col = mix(col, white, -time*(time-2.0));

    COLOR = col;
}