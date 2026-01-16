void main() {
    vec3 base = texture(InputTexture, TexCoord).rgb;
    float transitionStart = 0;
    float transitionEnd = 1.0;

    // Apply smooth gradient multipliers per channel
    vec3 bunnyProcess;
    bunnyProcess.r = base.r * mix(LowR, HighR, smoothstep(transitionStart, transitionEnd, base.r));
    bunnyProcess.g = base.g * mix(LowG, HighG, smoothstep(transitionStart, transitionEnd, base.g));
    bunnyProcess.b = base.b * mix(LowB, HighB, smoothstep(transitionStart, transitionEnd, base.b));
	
	vec3 desaturated;
	float bw = (min(base.r, min(base.g, base.b)) + max(base.r, max(base.g, base.b))) * 0.5;
	desaturated.r = bw;
	desaturated.g = bw;
	desaturated.b = bw;
	
    // Blend with original and clamp
    vec3 bunnyProcessed = mix(base.rgb, bunnyProcess, 1.0);
	vec3 desaturatedProcessed = mix(base.rgb, desaturated, Desaturation);
	
	vec3 result = mix(bunnyProcessed, desaturatedProcessed, 0.5);
	vec3 finalResult = mix(base.rgb, result, BlendPercent);

    FragColor = vec4(result, 1.0);
}