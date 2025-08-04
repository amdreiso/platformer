//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D palette;
uniform float palette_size;

void main() 
{
  vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
  float index = color.r;
  gl_FragColor = texture2D(palette, vec2(index / palette_size, 0.0));
}
