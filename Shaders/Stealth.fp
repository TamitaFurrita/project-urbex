void main() {
	// Common variables
	vec3 color = texture(InputTexture, TexCoord).rgb;
	vec3 processedColor = color;
	
	if (stealth > 0.01) {
	// --- Desaturation + Tint ---
	// Apply this first since it's simpler
	float desatFactor = 1.0 - (stealth/2.0);
	processedColor = mix(vec3(dot(processedColor.rgb, vec3(0.3, 0.56, 0.14))), processedColor.rgb, desatFactor);
	processedColor.b += (stealth/15.0);
	
	// --- Bloom ---
		vec3 exponentialColor = pow(processedColor, vec3(2.0));
		vec2 tex_offset = 1.0 / textureSize(InputTexture, 0);
		float totalWeight = 1.0;

		// Optimized loop with early exit if stealth is low
		int iterations = int(ceil(4.0 * stealth));
		for (int i = 1; i < iterations; ++i) {
			float weight = exp(-float(i) * 0.75);
			vec2 offset = vec2(float(i) * stealth * 2.0 * tex_offset.x, 0.0);

			// Sample once and reuse for both directions
			vec3 samplePos = pow(texture(InputTexture, TexCoord + offset).rgb, vec3(2.0));
			vec3 sampleNeg = pow(texture(InputTexture, TexCoord - offset).rgb, vec3(2.0));
			
			exponentialColor += samplePos * weight;
			exponentialColor += sampleNeg * weight;
			totalWeight += 4.0 * weight;
		}

		vec3 shaderOneResult = exponentialColor * 4.0 / totalWeight;
		processedColor = mix(processedColor, shaderOneResult, stealth/2);
	}
	
	// Final output
	FragColor = vec4(clamp(processedColor, 0.0, 1.0), stealth);
}