void main() {
	vec3 base = texture(InputTexture, TexCoord).rgb;

	vec3 redOverlay;
	redOverlay.r = (base.r < 0.5) ? (2.0 * base.r) : 1.0;
	redOverlay.g = (base.g < 0.5) ? 0.0 : (2.0 * base.g - 1.0);
	redOverlay.b = (base.b < 0.5) ? 0.0 : (2.0 * base.b - 1.0);

	vec3 result = mix(base.rgb, redOverlay, blendem);
	
	result.r = min(result.r, 1.0);
	result.g = min(result.g, 1.0);
	result.b = min(result.b, 1.0);

	FragColor = vec4(result.rgb, 1.0);
}