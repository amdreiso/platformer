//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
  vec4 base_color = texture2D(gm_BaseTexture, v_vTexcoord);
  float gray = dot(base_color.rgb, vec3(0.333, 0.333, 0.333)); // perceptual grayscale
  gl_FragColor = vec4(gray, gray, gray, base_color.a);
}