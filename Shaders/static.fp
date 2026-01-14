void SetupMaterial(inout Material mat)
{
    vec2 texCoord = vTexCoord.st;
	vec4 basicColor = getTexel(texCoord);
	
	vec2 texSize = vec2(textureSize(tex, 0));

	texCoord.x = float( int(texCoord.x * texSize.x) ) / texSize.x;
	texCoord.y = float( int(texCoord.y * texSize.y) ) / texSize.y;
	
    // Simple pseudo-random noise based on UV + time
    float noise = fract(
        sin(dot(texCoord.st * (timer * 35),
        vec2(12.9898, 78.233))) * 43758.5453
    );
	
	float noise2 = fract(
        cos(dot(texCoord.st * (timer * 35),
        vec2(12.9898, 78.233))) * 43758.5453
    );
	
	float noise3 = mix(noise, noise2, noise);
	
    // Grayscale static
    mat.Base = vec4(noise3, 0.0, 0.0, basicColor.a);
}