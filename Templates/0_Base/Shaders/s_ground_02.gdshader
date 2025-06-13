shader_type spatial;
render_mode unshaded;

uniform float size_modify = 2.0f;

vec3 NumberPlane(vec2 uv)
{
    vec3 col = vec3(0.0);
    vec3 color1 = vec3(0.4);
    vec3 color2 = vec3(0.5);
    
    col = mix(color1, color2, step(0.5, mod(floor(uv.x) + floor(uv.y), 2.0)));

    return col;
}

void vertex() {
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = NumberPlane(vec2(UV.x, UV.y) * size_modify);
}