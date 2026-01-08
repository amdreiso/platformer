//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_glintTex;
uniform float u_time;
uniform float u_strength;
uniform vec3 u_color;

vec2 rotate(vec2 uv, float a) {
    float s = sin(a);
    float c = cos(a);
    uv -= 0.5;
    uv = mat2(c, -s, s, c) * uv;
    return uv + 0.5;
}

void main() {
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);

    // Scale & rotate UVs (key to visible motion)
    vec2 uv = v_vTexcoord * 6.0;
    uv = rotate(uv, 0.785398); // 45°

    // Strong diagonal scroll
    uv += vec2(u_time * 0.8, -u_time * 1.2);

    // Sample glint texture
    float g = texture2D(u_glintTex, uv).r;

    // Pulsing brightness
    float pulse = sin(u_time * 4.0 + uv.x * 3.0) * 0.5 + 0.5;

    // Purple glint color
    vec3 glint = u_color * g * pulse;

    // Mask by sprite alpha
    glint *= base.a;

    gl_FragColor = vec4(base.rgb + glint * u_strength, base.a);
}

//void main() {
//    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);

//    // Scroll glint diagonally
//    vec2 glintUV = v_vTexcoord;
//    glintUV.x += u_time * 0.15;
//    glintUV.y -= u_time * 0.25;

//    vec4 glint = texture2D(u_glintTex, glintUV);

//    // Purple enchant color
//    vec3 glintColor = glint.rgb * vec3(0.6, 0.2, 0.8);

//    // Mask glint by sprite alpha
//    glintColor *= base.a;

//    // Additive blend with base
//    vec3 finalRGB = base.rgb + glintColor * u_strength;

//    gl_FragColor = vec4(finalRGB, base.a);
//}