class Treasure : Inventory
{
	Default
	{
	Inventory.MaxAmount 985;
	Tag "Treasure";
	Inventory.PickupMessage "waow";
	//$Category "Keys"
	}
	States
	{
	Spawn:
		SCO2 A 1;
		Loop;
	}
}

class TreasureFifty : Inventory
{
	Default
	{
	Inventory.MaxAmount 985;
	Tag "Treasure (50% Chance)";
	Inventory.PickupMessage "waow";
	//$Category "Keys"
	}
	States
	{
	Spawn:
		SCO6 A 1;
		Loop;
	}
}

class TreasureMaybe : Inventory
{
	Default
	{
	Inventory.MaxAmount 985;
	Tag "Treasure (10% Chance)";
	Inventory.PickupMessage "waow";
	//$Category "Keys"
	}
	States
	{
	Spawn:
		SCO5 A 1;
		Loop;
	}
}

class PickedUpTreasure : Inventory 
{
	Default
	{
	Inventory.MaxAmount 985;
	Tag "Treasure";
	}
}

class TreasureDagger : CustomInventory
{
	Default
	{
	+FLOATBOB
	+COUNTITEM
	+INVENTORY.AUTOACTIVATE
	+INVENTORY.ALWAYSPICKUP
	FloatBobStrength 0.1;
	Inventory.MaxAmount 1;
	Tag "Sacrificial Dagger";
	Inventory.PickupMessage "Found a sacrificial dagger.";
	}
	States
	{
	Spawn:
		SCO1 A 1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("PickedUpTreasure", 1);
		Stop;
	}
}

class TreasureBox : CustomInventory
{
	Default
	{
	+COUNTITEM
	+INVENTORY.AUTOACTIVATE
	+INVENTORY.ALWAYSPICKUP
	Inventory.MaxAmount 1;
	Tag "Mysterious Skullcrate";
	Inventory.PickupMessage "Found a mysterious skullcrate.";
	}
	States
	{
	Spawn:
		SCO2 A 1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("PickedUpTreasure", 1);
		Stop;
	}
}

class TreasureStaff : CustomInventory
{
	Default
	{
	+FLOATBOB
	+COUNTITEM
	+INVENTORY.AUTOACTIVATE
	+INVENTORY.ALWAYSPICKUP
	FloatBobStrength 0.1;
	Inventory.MaxAmount 1;
	Tag "Skull Staff";
	Inventory.PickupMessage "Found a delapidated spinestaff.";
	}
	States
	{
	Spawn:
		SCO3 A 1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("PickedUpTreasure", 1);
		Stop;
	}
}

class TreasureBook : CustomInventory
{
	Default
	{
	+FLOATBOB
	+COUNTITEM
	+INVENTORY.AUTOACTIVATE
	+INVENTORY.ALWAYSPICKUP
	FloatBobStrength 0.1;
	Inventory.MaxAmount 1;
	Tag "Demonic Scripture";
	Inventory.PickupMessage "Found ancient texts.";
	}
	States
	{
	Spawn:
		SCO4 A 1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("PickedUpTreasure", 1);
		Stop;
	}
}

class TreasureChalice : CustomInventory
{
	Default
	{
	+COUNTITEM
	+INVENTORY.AUTOACTIVATE
	+INVENTORY.ALWAYSPICKUP
	Inventory.MaxAmount 1;
	Tag "Human Juice";
	Inventory.PickupMessage "Consumed the Blood Chalice.";
	}
	States
	{
	Spawn:
		SCO5 A 1;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("PickedUpTreasure", 1);
		TNT1 A 0 A_GiveInventory("HealthBonus", 1);
		Stop;
	}
}

class TreasureSkull : CustomInventory
{
	Default
	{
	+FLOATBOB
	+COUNTITEM
	+INVENTORY.AUTOACTIVATE
	+INVENTORY.ALWAYSPICKUP
	FloatBobStrength 0.1;
	Inventory.MaxAmount 1;
	Tag "Skull Ruby";
	Inventory.PickupMessage "Found an unholy crown.";
	}
	States
	{
	Spawn:
		SCO6 ABCDDDCBAA 8;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("PickedUpTreasure", 1);
		Stop;
	}
}