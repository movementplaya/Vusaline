@echo off
cd ..
:start
if exist tf\custom (
	if exist tf\custom\vusalo_base (
		bin\vpk tf\custom\vusalo_base
		move /y tf\custom\vusalo_base.vpk tf\custom\zzz_vusalo_base.vpk
		if not exist tf\custom\zzz_vusalo_base.vpk goto :start
		rd /s /q tf\custom\vusalo_base
		echo Operation went through successfully!
		pause
		exit 0
	) else (
		echo ERROR: "vusalo_base" doesn't exist! Make sure it's placed in "Team Fortress 2\custom"!
		pause
		exit 2
	)
) else (
	echo ERROR: INCORRECT DIRECTORY PLACEMENT! THIS FILE MUST BE PLACED IN "Team Fortress 2\Vusalo"!
	pause
	exit 3
)