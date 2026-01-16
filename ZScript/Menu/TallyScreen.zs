class BunnyStatusScreen : DoomStatusScreen
{	
	GlassHandler event;
	
		override void updateStats ()
	{
		if (acceleratestage && sp_state != 10)
		{
			acceleratestage = 0;
			sp_state = 10;
			PlaySound("intermission/nextstage");

			cnt_kills[0] = Plrs[me].skills;
			cnt_items[0] = Plrs[me].sitems;
			cnt_secret[0] = Plrs[me].ssecret;
			cnt_time = Thinker.Tics2Seconds(Plrs[me].stime);
			cnt_par = wbs.partime / GameTicRate;
			cnt_total_time = Thinker.Tics2Seconds(wbs.totaltime);
		}

		if (sp_state == 2)
		{
			if (intermissioncounter)
			{
				cnt_kills[0] += 2;

				if (!(bcnt&3))
					PlaySound("intermission/tick");
			}
			if (!intermissioncounter || cnt_kills[0] >= Plrs[me].skills)
			{
				cnt_kills[0] = Plrs[me].skills;
				PlaySound("intermission/nextstage");
				sp_state++;
			}
		}
		else if (sp_state == 4)
		{
			if (intermissioncounter)
			{
				cnt_items[0] += 2;

				if (!(bcnt&3))
					PlaySound("intermission/tick");
			}
			if (!intermissioncounter || cnt_items[0] >= Plrs[me].sitems)
			{
				cnt_items[0] = Plrs[me].sitems;
				PlaySound("intermission/nextstage");
				sp_state++;
			}
		}
		else if (sp_state == 6)
		{
			if (intermissioncounter)
			{
				cnt_secret[0] += 2;

				if (!(bcnt&3))
					PlaySound("intermission/tick");
			}
			if (!intermissioncounter || cnt_secret[0] >= Plrs[me].ssecret)
			{
				cnt_secret[0] = Plrs[me].ssecret;
				PlaySound("intermission/nextstage");
				sp_state++;
			}
		}
		else if (sp_state == 8)
		{
			if (intermissioncounter)
			{
				if (!(bcnt&3))
					PlaySound("intermission/tick");

				cnt_time += 3;
				cnt_par += 3;
				cnt_total_time += 3;
			}

			int sec = Thinker.Tics2Seconds(Plrs[me].stime);
			if (!intermissioncounter || cnt_time >= sec)
				cnt_time = sec;

			int tsec = Thinker.Tics2Seconds(wbs.totaltime);
			if (!intermissioncounter || cnt_total_time >= tsec)
			{
				cnt_total_time = tsec;
				PlaySound("intermission/nextstage");
				sp_state++;
			}
		}
		else if (sp_state == 10)
		{
			if (acceleratestage)
			{
				PlaySound("intermission/paststats");
				initShowNextLoc();
			}
		}
		else if (sp_state & 1)
		{
			if (!--cnt_pause)
			{
				sp_state++;
				cnt_pause = GameTicRate;
			}
		}
	}
	
	override void drawStats (void)
	{
		event = GlassHandler(EventHandler.Find("GlassHandler"));
		
		bool GetLoudSeen = event.StealthedMap;
		
		// line height
		int lh = IntermissionFont.GetHeight() * 3 / 2;

		drawLF();

		Font textFont = "BigUpper";
		int tcolor = Font.CR_ICE;

		DrawText (textFont, tcolor, 50, 65, "Kills", shadow:true);
		DrawText (textFont, tcolor, 50, 115, "$TXT_IMSECRETS", shadow:true);

		if (sp_state >= 2)
		{
			DrawNum (textFont, 285, 65, max(0, cnt_kills[0]), 3, false, tcolor);
		}
		if (sp_state >= 4)
		{
			if(GetLoudSeen) DrawText (textFont, tcolor, 90, 90, "Cleared in stealth!", shadow:true);
			else DrawText (textFont, tcolor, 108, 90, 			"You went loud.", shadow:true);
		}
		if (sp_state >= 6)
		{
			drawPercent (textFont, 285, 115, cnt_secret[0], wbs.maxsecret, true, tcolor);
		}
		if (sp_state >= 8)
		{
			DrawText (textFont, tcolor, 85, 160, "$TXT_IMTIME", shadow:true);
			drawTimeFont (textFont, 249, 160, cnt_time, tcolor);
			if (wi_showtotaltime)
			{
				drawTimeFont (textFont, 249, 180, cnt_total_time, tcolor);
			}
		}
	}
}