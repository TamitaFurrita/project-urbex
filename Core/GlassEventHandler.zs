class GlassHandler : EventHandler
{
	const SPEED_DIVIDER = 2;
	const FUZZ_DISTANCE = 512;
	
	bool StealthedMap;
	
	override void PlayerEntered(PlayerEvent e)
	{
		players[e.PlayerNumber].mo.TakeInventory("PickedUpTreasure", 999);
		players[e.PlayerNumber].mo.GiveInventory("StealthScript",1);
		players[e.PlayerNumber].mo.GiveInventory("RegenArmor",100);
		
		StealthedMap = True;
	}
	
	override void WorldThingSpawned(WorldEvent e) {
		if (!e.thing) return;
		
		string treasures[6] = {
			"TreasureDagger", "TreasureBox", "TreasureStaff", 
			"TreasureBook", "TreasureChalice", "TreasureSkull"
		};
		
		// Treasure Spawner
		if (e.thing is "Treasure") {
			if(G_SkillPropertyInt(SKILLP_ACSReturn) < 6)
				{
				if(random(0,100) >= 90) {
					e.thing.A_SpawnItemEx(treasures[random(0,5)]);
					}
				}
			else e.thing.A_SpawnItemEx(treasures[random(0,5)]);
			e.thing.Destroy();
		}
		
		// 50% Treasure Spawner
		if (e.thing is "TreasureFifty") {
			if(G_SkillPropertyInt(SKILLP_ACSReturn) < 6)
				{
				if(random(0,100) >= 50) {
					e.thing.A_SpawnItemEx(treasures[random(0,5)]);
					}
				}
			e.thing.Destroy();
		}
		
		// 10% Treasure Spawner
		if (e.thing is "TreasureMaybe") {
			if(G_SkillPropertyInt(SKILLP_ACSReturn) < 6)
				{
				if(random(0,100) >= 90) {
					e.thing.A_SpawnItemEx(treasures[random(0,5)]);
					}
				}
			e.thing.Destroy();
		}
	}
	
	override void WorldTick()
	{
		ThinkerIterator PlayerPoker = ThinkerIterator.Create("SamDoom");
		Actor mo;
		
		while (mo = SamDoom(PlayerPoker.Next()))
		{
			if(mo.FindInventory("LoudSeen")) StealthedMap = False;
		}
	}
	
	override void WorldThingDied(WorldEvent e)
	{
		if(e.thing && e.thing.bIsMonster && e.thing.target && e.thing.target.player) e.thing.target.A_GiveInventory("Murderer", 1);
	}
}