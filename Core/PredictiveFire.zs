class HadTarget : Inventory 
{
	Default
	{
	Inventory.MaxAmount 1;
	}
}

class TamiActorBase : Actor
{
	Default
	{
	FriendlySeeBlocks 0;
	}
	
	void A_Patrol(StateLabel melee = "Melee", StateLabel missile = "Missile")
    {
        if (ActiveSound && random(0,100) > 97)
        {
            A_StartSound(ActiveSound, CHAN_BODY, CHANF_NOSTOP);
        }
		A_SetChaseThreshold(Default.defThreshold);

        // Check if we've reached the patrol point
        if (self.CheckIfCloser(target, MeleeRange))
        {	
		
			bFRIENDLY = True;
            if(!bINTRYMOVE) A_Chase(melee, missile, CHF_DONTLOOKALLAROUND);
			if(target && target.bISMONSTER && !target.bNOBLOCKMAP) A_ClearTarget();
			
			bFRIENDLY = False;
			
		}
			if(target)
			{
				A_SetAngle(self.movedir * 45);
				if((LineTrace(self.Angle, self.Speed/3, TRF_THRUACTORS, offsetforward: radius))) RandomChaseDir();
				if(!(LineTrace(self.Angle, self.Speed/3, TRF_THRUACTORS, offsetforward: radius))) NewChaseDir();
			}
	}
}