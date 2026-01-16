class RedCross : RedCard REPLACES RedCard
{
	Default
	{
		Inventory.Pickupmessage "Picked up the Red Cross.";
		Inventory.Icon "STKEYS2";
		Species "RedCard";
	}
	States
	{
	Spawn:
		RKEY A 10;
		Loop;
	}
}

class BlueCross : BlueCard REPLACES BlueCard
{
	Default
	{
		Inventory.Pickupmessage "Picked up the Blue Cross.";
		Inventory.Icon "STKEYS1";
		Species "BlueCard";
	}
	States
	{
	Spawn:
		BKEY A 10;
		Loop;
	}
}

class YellowCross : YellowCard REPLACES YellowCard
{
	Default
	{
		Inventory.Pickupmessage "Picked up the Yellow Cross.";
		Inventory.Icon "STKEYS0";
		Species "YellowCard";
	}
	States
	{
	Spawn:
		YKEY A 10;
		Loop;
	}
}