class OptionMenuItemStaticTextTwo : OptionMenuItem
{
	int mColor;
	string myString;
	double xCoords;
	double yCoords;

	// this function is only for use from MENUDEF, it needs to do some strange things with the color for backwards compatibility.
	OptionMenuItemStaticTextTwo Init(String label, int cr = -1, int x = 0, int y = 0)
	{
		Super.Init(label, 'None', true);
		mColor = OptionMenuSettings.mFontColor;
		myString = label;
		xCoords = x;
		yCoords = y;
		if ((cr & 0xffff0000) == 0x12340000) mColor = cr & 0xffff;
		else if (cr > 0) mColor = OptionMenuSettings.mFontColorHeader;
		return self;
	}
	
	override int Draw(OptionMenuDescriptor desc, int x, int y, bool selected)
	{
		screen.DrawText(SmallFont, mColor, xCoords, yCoords, myString, DTA_VirtualWidth, 480, DTA_VirtualHeight, 270, DTA_KeepRatio, 1);
		return -1;
	}
	
	override bool Selectable()
	{
		return false;
	}
}

class OptionMenuItemStaticPatch : OptionMenuItem
{
	TextureID DaTexture;
	double xCoords;
	double yCoords;
	double blend;

	OptionMenuItemStaticPatch Init(OptionMenuDescriptor desc, double x, double y, string patch, double inAlpha, string label = "", string command = "", bool centered = false)
	{
		Super.Init(label, command, centered);
		
		DaTexture = TexMan.CheckForTexture(patch);
		xCoords = x;
		SetX(xCoords);
		
		yCoords = y;
		SetY(yCoords);
		
		blend = inAlpha;
		return self;
	}
	
	override int Draw(OptionMenuDescriptor desc, int y, int indent, bool selected)
	{

		if (DaTexture.Exists())
		{
			Screen.DrawTexture(
				DaTexture,
				false,
				xCoords, yCoords,
				DTA_VirtualWidth, 480,
				DTA_VirtualHeight, 270,
				DTA_KeepRatio, true,
				DTA_Alpha, blend
			);
		}
		return -1;
	}

	override bool Selectable()
	{
		return false;
	}
}

class OptionMenuItemCommandTwo : OptionMenuItemCommand
{
	double xCoords;
	double yCoords;
	string myString;
	int mColor;
	String ccmd;
	bool mUnsafe;
	
	OptionMenuItemCommandTwo Init(String label, Name command, double x, double y, int cr = -1, bool centered = 0, bool closeonselect = false)
	{
		Super.Init(label, command, 0, centered);		
		ccmd = command;
		myString = label;
		mCloseOnSelect = closeonselect;
		mUnsafe = true;
		xCoords = x;
		
		yCoords = y;
		
		if ((cr & 0xffff0000) == 0x12340000) mColor = cr & 0xffff;
		else if (cr > 0) mColor = OptionMenuSettings.mFontColorHeader;
		return self;
	}

	void DrawBadOptionText(int x, int y, int color, String text, bool grayed = false, bool localize = true)
	{
		String label = localize ? Stringtable.Localize(text) : text;
		int overlay = grayed? Color(96,48,0,0) : 0;
		screen.DrawText (SmallFont, color, x, y, text, DTA_VirtualWidth, 480, DTA_VirtualHeight, 270, DTA_KeepRatio, 1);
	}

	override int Draw(OptionMenuDescriptor desc, int y, int indent, bool selected)
	{
		desc.mDrawTop = yCoords + 8;
		
		DrawBadOptionText(xCoords, yCoords, selected? OptionMenuSettings.mFontColorSelection : OptionMenuSettings.mFontColor, myString);
		return -1;
	}
}