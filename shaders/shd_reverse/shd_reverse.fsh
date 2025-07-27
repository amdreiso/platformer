//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_intensity;

void main() {
  vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
  vec3 inverted = vec3(1.0) - col.rgb;
  col.rgb = mix(col.rgb, inverted, u_intensity);
  gl_FragColor = vec4(col.rgb, 1.0);
}
