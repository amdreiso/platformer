varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_palette;
uniform float u_colors;
uniform float u_intensity;

void main() {
  vec4 col = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

  float intensity = dot(col.rgb, vec3(0.299 * u_intensity, 0.587 * u_intensity, 0.114 * u_intensity));

  float index = floor(intensity * u_colors);
  index = clamp(index, 0.0, u_colors - 1.0);

  float u = (index + 0.5) / u_colors;
  vec4 paletteColor = texture2D(u_palette, vec2(u, 0.5));

  gl_FragColor = vec4(paletteColor.rgb, 1.0);
}