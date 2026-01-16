void main() {
	vec3 color = texture(InputTexture, TexCoord).rgb;

	vec3 finalColor = mix(color, vec3(color.r * 2, color.g * 2, color.b * 2), min(blend, 1.0));

	FragColor = vec4(
	finalColor.rgb,
	1.0);
}