#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 lightMapColor;
in vec4 normal;
in vec4 tintColour;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }

    vec4 col255 = tintColour * 255;
    if(
        0 <= col255.r && col255.r <= 255 &&
        253 <= col255.g && col255.g <= 255 &&
        0 <= col255.b && col255.b <= 51
    ){
        color *= lightMapColor;
        fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
    }
    else{
        fragColor = linear_fog(color * vertexColor, vertexDistance, FogStart, FogEnd, FogColor);
    }

}