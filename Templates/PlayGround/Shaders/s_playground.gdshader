shader_type spatial;

const lowp vec3 v[1] = lowp vec3[1] ( vec3(0, 0, 1) );
uniform lowp vec3 w[1];

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	ALBEDO = v[0] + w[0];
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
