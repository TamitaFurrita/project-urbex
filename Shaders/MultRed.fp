void main() {
	vec3 color = texture(InputTexture, TexCoord).rgb;

	vec3 desaturated;
	float bw = (min(color.r, min(color.g, color.b)) + max(color.r, max(color.g, color.b))) * 0.5;
	desaturated.r = bw;
	desaturated.g = bw;
	desaturated.b = bw;
	
	vec3 desatColor = mix(color, desaturated, blendem);
	
	vec3 multColor = mix(
		desatColor, vec3(
			color.r*1.5, 
			color.g*0.25, 
			color.b*0.25), 
		blendem);

	FragColor = vec4(
	multColor.rgb,
	1.0);
}