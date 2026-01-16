class TracerBullet : FastProjectile
{
	Default
	{
		Radius 2;
		Height 2;
		Speed 90;
		DamageFunction 3 * random(1, 5);
		MissileType "TracerPath";
		BounceType "None";
		Projectile;
		Alpha 0;
		SeeSound "";
		DeathSound "";
	}
	States
	{
	Spawn:
		TNT1 A 1;
		Loop;
	Death:
		TNT1 A 1;
		Stop;
	}
}

class TracerPath : Actor
{
	Default
	{
		Radius 2;
		Height 1;
		Speed 0;
		Damage 0;
		DamageMultiply 0;
		RenderStyle "Add";
		Alpha 1.0;
		Tag "TracerPath";
		+NOGRAVITY;
	}
	States
	{
	Spawn:
		HERE AAAAAAAAAA 1
		{
			A_SetRenderStyle(alpha-0.1,STYLE_ADD);
			scale *= 0.95;
		}
	Death:
		TNT1 A 1;
		Stop;
	}
}

class KnifeTracer : Actor
{
	Default
	{
		Radius 2;
		Height 1;
		Speed 0;
		Damage 0;
		DamageMultiply 0;
		RenderStyle "Add";
		Alpha 1.0;
		Tag "KnifeTracer";
		+NOGRAVITY;
	}
	States
	{
	Spawn:
		HERE BBBBBBBBBBBBBBBBBBBB 1 Bright
		{
			A_SetRenderStyle(alpha-0.1,STYLE_ADD);
			scale *= 0.95;
		}
	Death:
		TNT1 A 1;
		Stop;
	}
}