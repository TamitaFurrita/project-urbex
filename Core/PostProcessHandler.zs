class WarmPostProcessing : EventHandler
{
	override void WorldLoaded(WorldEvent e)
	{
		PPShader.SetEnabled("postprocess", True);
		
		PPShader.SetUniform1f("postprocess", "LowR", 1.25);
		PPShader.SetUniform1f("postprocess", "LowG", 1.0);
		PPShader.SetUniform1f("postprocess", "LowB", 1.5);
		
		PPShader.SetUniform1f("postprocess", "HighR", 1.5);
		PPShader.SetUniform1f("postprocess", "HighG", 1.25);
		PPShader.SetUniform1f("postprocess", "HighB", 1.0);
		
		PPShader.SetUniform1f("postprocess", "Desaturation", 0.0);
	}
	
		override void WorldUnloaded(WorldEvent e)
	{
		PPShader.SetEnabled("postprocess", False);
	}
}

class ColdPostProcessing : EventHandler
{
	override void WorldLoaded(WorldEvent e)
	{
		PPShader.SetEnabled("postprocess", True);
		
		PPShader.SetUniform1f("postprocess", "LowR", 0.5);
		PPShader.SetUniform1f("postprocess", "LowG", 0.66);
		PPShader.SetUniform1f("postprocess", "LowB", 1.0);
		
		PPShader.SetUniform1f("postprocess", "HighR", 1.0);
		PPShader.SetUniform1f("postprocess", "HighG", 1.0);
		PPShader.SetUniform1f("postprocess", "HighB", 1.25);
		
		PPShader.SetUniform1f("postprocess", "Desaturation", 0.5);
	}
	
	override void WorldUnloaded(WorldEvent e)
	{
		PPShader.SetEnabled("postprocess", False);
	}
}

class OurPostProcessing : EventHandler
{
	override void WorldLoaded(WorldEvent e)
	{
		PPShader.SetEnabled("postprocess", True);
		
		PPShader.SetUniform1f("postprocess", "LowR", 0.0);
		PPShader.SetUniform1f("postprocess", "LowG", 0.0);
		PPShader.SetUniform1f("postprocess", "LowB", 0.0);
		
		PPShader.SetUniform1f("postprocess", "HighR", 1.2);
		PPShader.SetUniform1f("postprocess", "HighG", 0.0);
		PPShader.SetUniform1f("postprocess", "HighB", 0.0);
		
		PPShader.SetUniform1f("postprocess", "Desaturation", 1.0);
	}
	
	override void WorldUnloaded(WorldEvent e)
	{
		PPShader.SetEnabled("postprocess", False);
	}
}