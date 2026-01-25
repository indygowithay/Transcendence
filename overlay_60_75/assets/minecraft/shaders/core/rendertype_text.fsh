#version 150
precision highp float;

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec3 xyzPos;

out vec4 fragColor;

vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;

void main() {
    if (color.a < 0.1) {
        discard;
    }

    if(color.r <= 126.50/255.0 && color.r > 126.49/255.0 && color.g == 252/255.0 && color.b <= 31.63/255.0 && color.b > 31.62/255.0){
        color = vec4(1, 1, 1, color.a);
    }

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}