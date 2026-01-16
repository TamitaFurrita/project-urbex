class RegenArmor : BasicArmorBonus
{
	Default
	{
		Inventory.Icon "ARM1A0";
		Inventory.PickupSound "";
		Armor.Savepercent 100;
		Armor.Saveamount 1;
		Armor.MaxSaveAmount 100;
		+INVENTORY.ALWAYSPICKUP;
		+Inventory.AUTOACTIVATE;
	}
}

class SamDoom : DoomPlayer
{
	double blend;
	double blendDamage;
	
	Default
	{
		Height 64;
		Scale 1.2;
		Speed 0.5;
		Player.ViewBob 0.5;
		Player.ViewBobSpeed 40;
		Player.ViewHeight 56;
		Player.AttackZOffset 20;
		Player.GruntSpeed 24;
		Player.DamageScreenColor "Red", 0;

		Player.StartItem "Flashlight";
		
		Player.WeaponSlot 1, "Flashlight";
	}
	
	States
	{
	Pain:
		PLAY G 8;
		Goto Spawn;
	}

	override void Tick()
	{
		Super.Tick();
		if(!CheckInventory("Smacked", 1) && self.Health > 0) {
		A_GiveInventory("RegenArmor", 1);
		}
		
		if(self.FindInventory("StealthScript") && self.FindInventory("LoudSeen")) {
		PPShader.SetUniform1f("stealthvision", "stealth", 0);
		PPShader.SetEnabled("stealthvision", false);
		}
		
		blend -= 0.1 + (CountInv("BasicArmor") * 0.001);
		blend = max(0, blend);
		
		blendDamage -= 0.05 + (self.Health * 0.001);
		blendDamage = max(0, blendDamage);
		if(Self.Health <= 0) blendDamage = 1.0;
		
		if(blendDamage > 0) PPShader.SetEnabled("redthingdamage", true);
		else PPShader.SetEnabled("redthingdamage", false);
		
		if(blend > 0) PPShader.SetEnabled("whiteflash", true);
		else PPShader.SetEnabled("whiteflash", false);
		
		Shader.SetUniform1f(self.player,"whiteflash","blend",double(blend));
		Shader.SetUniform1f(self.player,"redthingdamage","blendem",double(blendDamage));
	}
	
	override int TakeSpecialDamage(Actor inflictor, Actor source, int damage, Name damagetype)
	{
		if(FindInventory("InvulnFrames")) return 0;
		else self.A_GiveInventory("InvulnFrames", 1);
		
		int FutureHealth = (self.Health + CountInv("BasicArmor")) - damage;
	
		if(CountInv("BasicArmor") - damage > 0) 
			{
			A_StartSound("*land", CHAN_7);
			blend = 1.0 * clamp(damage * 0.1, 0, 2); 
			}
			
		if(CountInv("BasicArmor") - damage <= 0 && FutureHealth > 0) 
			{ 
			
			blendDamage = 1.0 * clamp(damage * 0.1, 0, 2); 
			
			if(FutureHealth <= 100 && FutureHealth > 75) A_StartSound("*pain100", CHAN_7);
			if(FutureHealth <= 75 && FutureHealth > 50) A_StartSound("*pain75", CHAN_7);
			if(FutureHealth <= 50 && FutureHealth > 25) A_StartSound("*pain50", CHAN_7);
			if(FutureHealth <= 25 && FutureHealth >= 1) A_StartSound("*pain25", CHAN_7);
			}
			
			
		self.A_GiveInventory("Smacked", damage);
		
		if(CountInv("BasicArmor") - damage <= 0 && CheckArmorType("RegenArmor", 1)) 
		{
			A_StartSound("armor/break", CHAN_AUTO);
			return CountInv("BasicArmor");
		}
		if(damage < 10 && !CheckArmorType("RegenArmor", 1)) return 10;
		return damage;
	}
	
	override void Die(Actor source, Actor inflictor, int dmgflags, Name MeansOfDeath)
	{
		self.A_TakeInventory("StealthScript", 999);
		S_ChangeMusic("DEAD", 0, false, true);
		super.Die(source, inflictor, dmgflags, MeansOfDeath);
	}
}