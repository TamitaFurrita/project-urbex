// Adapted from Caligari87's Ugly as Sin Stealth Module for Hideous Destructo

class Seen : Powerup 
{
	Default
	{
	+INVENTORY.NOSCREENFLASH
	}
	
	double blendem;
	
	override void InitEffect()
	{
		Super.InitEffect();
		if(owner && owner.Player && !(owner.FindInventory("LoudSeen"))) {
		owner.A_StartSound("sounds/playerfound", CHAN_AUTO, CHANF_LOCAL);
		blendem = 1.0;
		}
	}
	
	override void Tick()
	{
		Super.Tick();
		if(owner && owner.Player && !(owner.FindInventory("LoudSeen"))) {
		blendem -= 0.01;
		blendem = max(0, blendem);
		if(blendem > 0) PPShader.SetEnabled("redthing", true);
		else PPShader.SetEnabled("redthing", false);
		if(owner && owner.player) Shader.SetUniform1f(owner.player,"redthing","blendem",double(blendem));
		}
	}
	
	override void EndEffect()
	{
		if(owner && owner.player) Shader.SetUniform1f(owner.player,"redthing","blendem",0);
		Super.EndEffect();
	}
}

class LoudSeen : Powerup 
{
	Default
	{
	+INVENTORY.NOSCREENFLASH
	}
	
	override void InitEffect()
	{
		Super.InitEffect();
		owner.A_SetBlend("OrangeRed", 0.1, 35);
	}
	
	
	override void DoEffect()
	{
		Super.DoEffect();
		owner.A_AlertMonsters();
	}
}

class MurderSeen : Powerup 
{
	Default
	{
	+INVENTORY.NOSCREENFLASH
	}
}

class NoiseSeen : Powerup 
{
	Default
	{
	+INVENTORY.NOSCREENFLASH
	}
}

class SeenByMonsters : PowerupGiver
{
	Default
	{
		Inventory.MaxAmount 0;
		Powerup.Duration -1;
		Powerup.Type "Seen";
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.NOSCREENFLASH
		+INVENTORY.UNTOSSABLE;
	}
}

class Murderer : PowerupGiver
{
	Default
	{
		Inventory.MaxAmount 0;
		Powerup.Duration -5;
		Powerup.Type "MurderSeen";
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.NOSCREENFLASH
		+INVENTORY.UNTOSSABLE;
	}
}

class Noisy : PowerupGiver
{
	Default
	{
		Inventory.MaxAmount 0;
		Powerup.Duration -5;
		Powerup.Type "NoiseSeen";
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.NOSCREENFLASH
		+INVENTORY.UNTOSSABLE;
	}
}

class FiredLoudWeapon : PowerupGiver
{
	Default
	{
	Inventory.MaxAmount 0;
	Powerup.Duration 2147483646;
	Powerup.Type "LoudSeen";
	+INVENTORY.AUTOACTIVATE;
	+INVENTORY.NOSCREENFLASH
	+INVENTORY.UNTOSSABLE;
	}
}

class NotInSight : Inventory 
{
	Default
	{
	+INVENTORY.NOSCREENFLASH
	}
}

class FlashlightPoweredOn : Powerup
{
	Default
	{
	+INVENTORY.NOSCREENFLASH
	Powerup.Duration 1;
	}
}

class InvulnFrames : Powerup
{
	Default
	{
	+INVENTORY.NOSCREENFLASH
	Powerup.Duration 5;
	}
}

class Smacked : Powerup
{
	Default
	{
	Inventory.MaxAmount 985;
	Powerup.Duration -1;
	+INVENTORY.ADDITIVETIME;
	+INVENTORY.NOSCREENFLASH
	}
	
	override void EndEffect()
	{
		if(owner && owner.Health > 0) {
		owner.A_PlaySound("armor/regen", CHAN_AUTO, 1.0);
		owner.A_PlaySound("misc/spawn", CHAN_AUTO, 0.1);
		}
	Super.EndEffect();
	}
}