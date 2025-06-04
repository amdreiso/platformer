//
// Simple passthrough fragment shader
//
//varying vec2 v_vTexcoord;
//varying vec4 v_vColour;

//void main()
//{
//    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
//}



varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_threshold_bias;

float bayer4x4(vec2 pos) {
    int x = int(mod(pos.x, 4.0));
    int y = int(mod(pos.y, 4.0));
    
    float threshold[16];
    threshold[0]  =  0.0 / 16.0;
    threshold[1]  =  8.0 / 16.0;
    threshold[2]  =  2.0 / 16.0;
    threshold[3]  = 10.0 / 16.0;
    threshold[4]  = 12.0 / 16.0;
    threshold[5]  =  4.0 / 16.0;
    threshold[6]  = 14.0 / 16.0;
    threshold[7]  =  6.0 / 16.0;
    threshold[8]  =  3.0 / 16.0;
    threshold[9]  = 11.0 / 16.0;
    threshold[10] =  1.0 / 16.0;
    threshold[11] =  9.0 / 16.0;
    threshold[12] = 15.0 / 16.0;
    threshold[13] =  7.0 / 16.0;
    threshold[14] = 13.0 / 16.0;
    threshold[15] =  5.0 / 16.0;

    int index = y * 4 + x;
    return threshold[index];
}

void main() {
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    
    vec2 pixel_pos = gl_FragCoord.xy;
    float threshold = bayer4x4(pixel_pos) + u_threshold_bias;

    float dithered = gray < threshold ? 0.0 : 1.0;
    gl_FragColor = vec4(v_vColour.rgb * vec3(dithered).rgb, 1.0);
}