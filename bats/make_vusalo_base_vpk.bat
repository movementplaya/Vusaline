@echo off
cd ..
if exist "%cd%\tf\custom" (
	if exist "%cd%\tf\custom\vusalo_base" (
		"%cd%\bin\vpk.exe" "%cd%tf\custom\vusalo_base"
		rd /s /q "%cd%\tf\custom\vusalo_base"
		move /y "%cd%tf\custom\vusalo_base.vpk" "%cd%\tf\custom\zzz_vusalo_base.vpk"
		exit 0
	) else (
		echo ERROR: vusalo_base doesn't exist! Make sure it's placed in "Team Fortress 2\custom"!
		exit 2
	)
) else (
	echo ERROR: Custom folder not found/Incorrect directory! Make sure this batch is placed in "Team Fortress 2\Vusalo"!
	exit 3
)
echo ERROR: Something went wrong! We aren't supposed to reach this point!
pause