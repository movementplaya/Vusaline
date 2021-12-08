:: >>CHANGE THIS IF YOU DON'T USE THE DEFAULT TF2 DIRECTORY (DO *NOT* REMOVE QUOTES)<<
set tf2dir="PLACE YOUR TF2 DIRECTORY HERE"

@echo off
if not exist %tf2dir% (
	if exist "C:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2" (
		set tf2dir="C:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2"
	) else (
		if exist "D:\Steam\steamapps\common\Team Fortress 2" (
			set tf2dir="D:\Steam\steamapps\common\Team Fortress 2" (
		) else (
			if exist "D:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2" (
				set tf2dir="D:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2"
			) else (
				if exist "E:\Steam\steamapps\common\Team Fortress 2" (
					set tf2dir="E:\Steam\steamapps\common\Team Fortress 2"
				) else (
					if exist "E:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2" (
						set tf2dir="E:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2"
					) else (
						echo ERROR: COULD NOT FIND TF2 DIRECTORY!
						pause
						exit 3
					)
				)
			)
		)
	)
)
if not exist %tf2dir%\Vusalo (
	md %tf2dir%\Vusalo
)
if not exist %tf2dir%\tf\custom (
	md %tf2dir%\tf\custom
)
if not exist bats (
	echo ERROR: COULD NOT FIND VUSALO FILES! PLEASE KEEP THIS BATCH IN THE SAME FOLDER!
	pause
	exit 2
) else (
	if not exist vpks (
		echo ERROR: COULD NOT FIND VUSALO FILES! PLEASE KEEP THIS BATCH IN THE SAME FOLDER!
		pause
		exit 2
	) else (
		if not exist bats\vusalo_file_operations.bat (
			echo ERROR: COULD NOT FIND VUSALO BATCH FILE! PLEASE KEEP IT IN THE "Vusalo-master\bats" FOLDER!
			pause
			exit 2
		) else (
			if not exist vpks\vusalo_base.vpk (
				echo echo ERROR: COULD NOT FIND VUSALO BASE VPK! PLEASE KEEP IT IN THE "Vusalo-master\vpks" FOLDER!
				pause
				exit 2
			)
		)
	)
)
move /y bats\make_vusalo_base_vpk.bat %tf2dir%\Vusalo
move /y bats\vusalo_file_operations.bat %tf2dir%\Vusalo
move /y bats\revert_vusalo_file_operations.bat %tf2dir%\Vusalo
move /y vpks\vusalo_base.vpk %tf2dir%\tf\custom\zzz_vusalo_base.vpk
if not exist %tf2dir%\tf\custom\vusalo_configuration (
	move /y vusalo_configuration %tf2dir%\tf\custom\vusalo_configuration
)
pause
exit 0