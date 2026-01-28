varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_normal;   // normal map
uniform vec2 u_light_pos;     // same space as v_vPos
uniform float u_light_radius;
uniform vec3 u_light_color;
uniform float u_ambient;      // 0.0–1.0

void main() {
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

    // normal map (tangent space, Y+)
    vec3 normal = texture2D(u_normal, v_vTexcoord).rgb;
    normal = normalize(normal * 2.0 - 1.0);

    // light
    vec2 toLight = u_light_pos - u_light_pos;
    float dist = length(toLight);
    vec3 lightDir = normalize(vec3(toLight, 0.0));

    float NdotL = max(dot(normal, lightDir), 0.0);
    float attenuation = clamp(1.0 - dist / u_light_radius, 0.0, 1.0);

    float light = NdotL * attenuation;

    vec3 color = base.rgb * (u_ambient + light * u_light_color);
    gl_FragColor = vec4(color, base.a);
}