shader_type spatial;
render_mode specular_toon;

uniform float height_scale = 0.2;
uniform sampler2D noise;
uniform sampler2D normalmap;

varying vec2 tex_position;

float height(vec2 position, float time) {
  //return texture(noise, position / 10.0).x; // Scaling factor is based on mesh size (this PlaneMesh is 10×10).
	vec2 offset = 0.01 * cos(position + time);
	return texture(noise, (position / 10.0) - offset).x;
}

float wave(vec2 position){
  position += texture(noise, position / 10.0).x * 2.0 - 1.0;
  vec2 wv = 1.0 - abs(sin(position));
  return pow(1.0 - pow(wv.x * wv.y, 0.65), 4.0);
}

void vertex() {
	tex_position = VERTEX.xz / 2.0 + 0.5;
	
	vec2 pos = VERTEX.xz;
	float height = height(pos, TIME);
	VERTEX.y = height * height_scale;
	
	//NORMAL = normalize(vec3(k - height(pos + vec2(0.1, 0.0), TIME), 0.1, k - height(pos + vec2(0.0, 0.1), TIME)));
}

void fragment() {
	NORMAL_MAP = texture(normalmap, tex_position).xyz;
	
	float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));
	RIM = 0.2;
	METALLIC = 0.0;
	ROUGHNESS = 0.01 * (1.0 - fresnel);
	ALBEDO = vec3(0.1, 0.3, 0.5) + (0.1 * fresnel);
}