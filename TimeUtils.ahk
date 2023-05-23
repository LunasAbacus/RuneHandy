#Requires AutoHotkey v2.0

idlePercent := 0.02

RandomSleep(min, max, shouldIdle)
{
	waitTime := Random(min, max)
	if (shouldIdle and Random() < idlePercent)
	{
		waitTime := Random(15000,60000)
	}
	Sleep waitTime
}