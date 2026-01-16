class StealthScript : Inventory {
	// Internal stealth mechanics variables
	int unsneakiness;
	int stealth;
	int visibleStealth;
	
	double blender;		 // Normalized stealth value (0.0-1.0) for shader effects

	int trueLightLevel;	 // Final calculated light level affecting the player
	DynamicLight currentLight; // Temporary reference for dynamic light iteration

	// Item properties to make it function as a persistent power-up
	default {
		+INVENTORY.AUTOACTIVATE;	// Activates automatically when acquired
		+INVENTORY.PERSISTENTPOWER; // Remains active indefinitely
		+INVENTORY.UNTOSSABLE;	  // Cannot be dropped or removed
	}
	
	// Check for detection purposes
	bool DetectionRadius(double rad)
		{
		// Create the iterator
		BlockThingsIterator it = BlockThingsIterator.Create(owner, rad);
		Actor mo;

		while (it.Next())
		{
			mo = it.thing; // Get the Actor it's currently on
			if ((mo && mo.bIsMonster && mo.Health > 0) && owner.Distance3D(mo) < rad && owner.pos.z <= mo.pos.z && mo.CheckSight(owner, SF_IGNOREVISIBILITY|SF_SEEPASTSHOOTABLELINES)) 
			{
				Return True;
			}
		}
	return False;
}

	bool AreWeBeingSeen(double Distance)
		{
		// Create the iterator
		BlockThingsIterator it = BlockThingsIterator.Create(owner, Distance);
		Actor mo;

		while (it.Next())
			{
				mo = it.thing; // Get the Actor it's currently on
				if (mo && mo.bIsMonster && mo.Health > 0 && mo.CheckSight(owner, SF_IGNOREVISIBILITY|SF_SEEPASTSHOOTABLELINES))
				{
					Return True;
				}
			}
		return False;
	}
		

	// Main stealth calculation and effect application
	override void DoEffect() {
		// Safety check - abort if not attached to a valid player
		if (!owner || !owner.player) { return; }
		
		vector2 playerSpeed = (owner.vel.x, owner.vel.y);
		
		unsneakiness = clamp((GetRealLightLevel() + playerSpeed.Length() * 20) / 10 * owner.Player.CrouchFactor * 2.5, 0, 100);
		
		if(owner.FindInventory("FlashlightPoweredOn") || owner.FindInventory("MurderSeen") || owner.FindInventory("Seen") || owner.FindInventory("NoiseSeen") || DetectionRadius(128)) {
			stealth = clamp(100 - unsneakiness, 0, 100) * 0.66;
		}
		
		else stealth = clamp(100 - unsneakiness, 0, 100);
		
		if (stealth < visibleStealth) visibleStealth = max(stealth, visibleStealth - 5);
		else if (stealth > visibleStealth) visibleStealth = min(stealth, visibleStealth + 5);
		visibleStealth = clamp(visibleStealth, 0, 100);
		
		owner.A_GiveInventory("NotInSight", 1);
		
		if(AreWeBeingSeen(1024.0))
		{
		owner.A_TakeInventory("NotInSight", 999);
		}
		
		blender = 0;
		blender += clamp(visibleStealth * 0.01, 0, 1);
		blender = max(blender, 0);
		
			if(visibleStealth >= 65 && !owner.FindInventory("Seen", 1))
			{
				owner.bMVISBLOCKED = True;
			}
			else if(AreWeBeingSeen(256) || owner.FindInventory("Seen", 1) || visibleStealth < 65)
			{
				owner.bMVISBLOCKED = False;
			}
		
		// Apply stealth effects to shaders for visual feedback
		if(stealth > 0) PPShader.SetEnabled("stealthvision", true);
		else PPShader.SetEnabled("stealthvision", false);
		
		Shader.SetUniform1f(owner.player, "stealthvision", "stealth", double(blender));
		Shader.SetUniform1f(owner.player, "redthing", "blendem", 0);
		
		if(owner.Health < 1)
		{
		Shader.SetUniform1f(owner.player, "stealthvision", "stealth", double(0));
		Shader.SetUniform1f(owner.player, "redthing", "blendem", double(0));
		Return;
		}
	}
	int GetRealLightLevel() {
		// Set up light iterator
		ThinkerIterator LightFinder = ThinkerIterator.Create("DynamicLight", Thinker.STAT_DLIGHT);

		// Initial "base" lightlevel
		int trueLightLevel = owner.cursector.lightlevel;

		// Iterate lights
		while (currentLight = DynamicLight(LightFinder.Next())) {
			if (!currentLight.CheckSight(owner, SF_IGNOREVISIBILITY|SF_SEEPASTSHOOTABLELINES) || currentlight.bDORMANT == true) { continue; } //Skip if the light isn't in LoS

			vector3 posdiff = levellocals.Vec3Diff((owner.pos.x, owner.pos.y, owner.pos.z + (owner.height / 2)), currentlight.pos);
			double currentDistance = posdiff.length(); //owner.Distance3D(currentLight);

			double distanceFactor = currentDistance / (double(currentLight.args[DynamicLight.LIGHT_INTENSITY]+1) * 2);

			double avgIntensity = (
				currentLight.args[DynamicLight.LIGHT_RED] * 0.2126 +
				currentLight.args[DynamicLight.LIGHT_GREEN] * 0.7152 +
				currentLight.args[DynamicLight.LIGHT_BLUE] * 0.0722 +
				currentLight.args[DynamicLight.LIGHT_INTENSITY]) 
				/ 3;

			if (currentlight.bSPOT) {
				double offangle = abs(deltaangle(currentlight.AngleTo(owner), currentlight.angle));
				double pitchcalc = 4.0 - abs(currentlight.PitchTo(owner)) / 180;
				if (offangle < currentlight.SpotInnerAngle) { avgIntensity *= 0.25 * pitchcalc; }
				if (offangle < currentlight.SpotOuterAngle) { avgIntensity *= 0.25 * pitchcalc; }
				if (offangle > currentlight.SpotOuterAngle) { avgIntensity *= 0; }
			}
			
			avgIntensity *= 1.5 - distanceFactor;
			
			if (currentDistance < owner.radius) { avgIntensity *= 2; }

			trueLightLevel += max(0, avgIntensity);
		}
		if(LightDebug) A_Log("Stealth "..stealth.." - LightLevel "..trueLightLevel.." - unsneakiness "..unsneakiness);
		return trueLightLevel;
	}
}