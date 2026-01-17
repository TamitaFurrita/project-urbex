Class Flashlight : Weapon
	{
	bool LightOn;

	Default
	{
		Weapon.SelectionOrder 4000;
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "Pickedupaflashlight!";
		Scale 0.75;
		+WEAPON.NOALERT
		+WEAPON.NOAUTOFIRE
		+WEAPON.NOAUTOAIM
		+NOTRIGGER
	}

	States
	{
	Spawn:
		FLSH B -1;
		Loop;
	Ready:
		FLIT B 1 A_WeaponReady();
		Loop;
	LightReady:
		FLIT B 0 A_Light(2);
		FLIT B 1 A_WeaponReady();
		FLIT B 0 {
		A_AttachLightDef("CloseLight", "FLASHLIGHT");
		A_AttachLightDef("CloseLight2", "FLASHLIGHT_2");
		
		A_AttachLightDef("Light", "FLASHLIGHT2");
		A_AttachLightDef("Light2", "FLASHLIGHT2_2");
		A_GiveInventory("FlashlightPoweredOn", 1);
		}
		Loop;
	Deselect:
		FLIT B 0 A_JumpIf(invoker.LightOn, "LightLower");
	  Lower:
		FLIT B 0 A_Light(1);
		FLIT B 1 A_Lower();
		Loop;
	LightLower:
		FLIT B 0 {
		A_PlaySound("wart/dead", pitch: 1.3);
		A_RemoveLight("CloseLight");
		A_RemoveLight("CloseLight2");
		
		A_RemoveLight("Light");
		A_RemoveLight("Light2");
		}
		FLIT B 0 { invoker.LightOn=false; }
	TrueLightLower:
		FLIT B 0 A_Light(1);
		FLIT B 1 A_Lower();
		Loop;
	Select:
		FLIT B 1 A_Raise();
		Loop;
	Fire:
		FLIT B 1 A_JumpIf(invoker.LightOn, "LightOff");
		FLIT B 1 A_PlaySound("wart/dead", pitch: 1.6);
		FLIT B 1 A_Light(3);
		FLIT B 1 { invoker.LightOn=true; }
		Goto LightReady;
	LightOff:
		FLIT B 1 {
		A_PlaySound("wart/dead", pitch: 1.3);
		A_RemoveLight("CloseLight");
		A_RemoveLight("CloseLight2");
		
		A_RemoveLight("Light");
		A_RemoveLight("Light2");
		}
		FLIT B 1 A_Light0();
		FLIT B 1 { invoker.LightOn=false; }
		Goto Ready;
	}
}

Class DebugFlashlight : Weapon
	{
	bool LightOn;

	Default
	{
		Weapon.SelectionOrder 4000;
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "Pickedupaflashlight!";
		Scale 0.75;
		+WEAPON.NOALERT
		+WEAPON.NOAUTOFIRE
		+WEAPON.NOAUTOAIM
		+NOTRIGGER
	}

	States
	{
	Spawn:
		FLSH B -1;
		Loop;
	Ready:
		FLIT D 1 A_WeaponReady();
		Loop;
	LightReady:
		FLIT D 1 A_WeaponReady();
		FLIT D 0 {
		A_GiveInventory("DebugInfrared");
		A_GiveInventory("FlashlightPoweredOn", 1);
		}
		Loop;
	Deselect:
		FLIT D 0 A_JumpIf(invoker.LightOn, "LightLower");
	Lower:
		FLIT D 1 A_Lower();
		Loop;
	LightLower:
		FLIT D 0 {
		A_PlaySound("flashlight/off");
		}
		FLIT D 0 { invoker.LightOn=false; }
	TrueLightLower:
		FLIT D 1 A_Lower();
		Loop;
	Select:
		FLIT D 1 A_Raise();
		Loop;
	Fire:
		FLIT D 1 A_JumpIf(invoker.LightOn, "LightOff");
		FLIT D 1 A_PlaySound("flashlight/on");
		FLIT D 1 { invoker.LightOn=true; }
		Goto LightReady;
	LightOff:
		FLIT D 1 {
		A_PlaySound("flashlight/off");
		}
		FLIT D 1 { invoker.LightOn=false; }
		Goto Ready;
	}
}

class DebugInfrared : PowerupGiver
{
	Default
	{
		+COUNTITEM
		+INVENTORY.AUTOACTIVATE
		+INVENTORY.ALWAYSPICKUP
		Inventory.MaxAmount 0;
		Powerup.Duration -1;
		Powerup.Type "PowerLightAmp";
		Inventory.PickupMessage "";
	}
}