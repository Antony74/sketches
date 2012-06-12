<?php

	//
	// Do not run this script unless you have a backup of the directory it's in the sub-directories.
	//
	// 1. If you knew exactly what this was going to overwrite you probably wouldn't
	//    need to run it in the first place.
	//
	// 2. Obviously commiting to some sort of version control is the easiest way of ensuring
	//    you have some sort of backup.
	//

	error_reporting(E_ALL);
	set_time_limit(0);

	$arrModules = array();

	enumerateModules(".\\", 1);
	enumerateModules(".\\", 2);


function enumerateModules($sDir, $nPass)
{
	$arr = scandir($sDir);
	for ($n = 0; $n < count($arr); ++$n)
	{
		$sItem = $arr[$n];
		$sPath = $sDir . $sItem;
		
		if (substr($sItem, 0, 1) == ".")
			continue;
		
		if (is_dir($sPath))
		{
			if ($sItem == "applet")
				continue;
		
			enumerateModules($sPath . "\\", $nPass); // recursion
		}
		else
		{
			if ($sItem == "main.pde") // Special case.  Probably isn't clever having a module called main.pde
				continue;

			if (substr($sItem, -4) == ".pde")
			{
				if ($nPass == 1)
					examineModule($sItem, $sPath);
				else
					processModule($sItem, $sPath);
			}
		}
	}
}

function examineModule($sItem, $sPath)
{
	global $arrModules;
	
	$nLastChanged = filectime($sPath);
	
	if (isset($arrModules[$sItem]))
	{
		if ($nLastChanged <= $arrModules[$sItem][1])
			return; // We already have the more up to date file
	}

	$arr = array($sPath, $nLastChanged);
	$arrModules[$sItem] = $arr;
}

function processModule($sItem, $sPath)
{
	global $arrModules;
	
	$nLastChanged = filectime($sPath);
	
	if (isset($arrModules[$sItem]))
	{
		if ($nLastChanged >= $arrModules[$sItem][1])
			return; // We already have the more up to date file

		$sSrcPath = $arrModules[$sItem][0];
		copy($sSrcPath, $sPath);
		echo("Copied $sSrcPath to $sPath\r\n");
	}
}

?>

