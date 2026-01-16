class NewGreenArmor : BasicArmorBonus REPLACES GreenArmor
{
	Default
	{
		Radius 20;
		Height 16;
		Inventory.Pickupmessage "$GOTARMOR";
		Inventory.Icon "ARM1B0";
		Armor.Savepercent 33.335;
		Armor.Saveamount 50;
		Armor.Maxsaveamount 200;
		+COUNTITEM
		+INVENTORY.ALWAYSPICKUP
	}
	States
	{
		Spawn:
			ARM1 A 6;
			ARM1 B 7 bright;
			loop;
	}
}

class NewBlueArmor : BasicArmorBonus REPLACES BlueArmor
{
	Default
	{
		Radius 20;
		Height 16;
		Inventory.Pickupmessage "$GOTMEGA";
		Inventory.Icon "ARM2B0";
		Armor.Savepercent 33.335;
		Armor.Saveamount 100;
		Armor.Maxsaveamount 200;
		+COUNTITEM
		+INVENTORY.ALWAYSPICKUP
	}
	States
	{
		Spawn:
			ARM2 A 6;
			ARM2 B 7 bright;
			loop;
	}
}