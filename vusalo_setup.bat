:: >>CHANGE THIS IF YOU DON'T USE THE DEFAULT TF2 DIRECTORY (DO *NOT* REMOVE QUOTATION MARKS)<<
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
						echo ERROR: COULD NOT FIND TF2 DIRECTORY! PLEASE EDIT THIS FILE AND PLACE IT AT THE TOP AS INDICATED!
						pause
						exit 3
					)
				)
			)
		)
	)
)
cd ..
if not exist Vusaline (
	echo ERROR: COULD NOT FIND VUSALO FILES! PLEASE KEEP THIS BATCH FILE IN THE SAME FOLDER!
	pause
	exit 3
) else (
	cd Vusaline
	if not exist bats (
		echo ERROR: COULD NOT FIND VUSALO "bats" FOLDER! PLEASE KEEP THEM IN THE SAME FOLDER!
		pause
		exit 2
	) else (
		if not exist vpks (
			echo ERROR: COULD NOT FIND "vpks" FOLDER! PLEASE KEEP THEM IN THE SAME FOLDER!
			pause
			exit 2
		) else (
			if not exist bats\vusalo_file_operations.bat (
				echo ERROR: COULD NOT FIND "vusalo_file_operations.bat"! PLEASE KEEP IT IN THE "Vusaline\bats" FOLDER!
				pause
				exit 2
			) else (
				if not exist vpks\vusalo_base.vpk (
					echo echo ERROR: COULD NOT FIND "vusalo_base.vpk"! PLEASE KEEP IT IN THE "Vusaline\vpks" FOLDER!
					pause
					exit 2
				)
			)
		)
	)
)
if exist %tf2dir%\Vusalo (
	if exist %tf2dir%\Vusalo\make_vusalo_base_vpk.bat (
		del %tf2dir%\Vusalo\make_vusalo_base_vpk.bat
	)
	if exist %tf2dir%\Vusalo\revert_vusalo_file_operations.bat (
		del %tf2dir%\Vusalo\revert_vusalo_file_operations.bat
	)
	if exist %tf2dir%\Vusalo\vusalo_file_operations.bat (
		del %tf2dir%\Vusalo\vusalo_file_operations.bat
	)
) else (
	md %tf2dir%\Vusalo
)
if exist %tf2dir%\tf\custom (
	if exist %tf2dir%\tf\custom\zzz_vusalo_base.vpk (
		del %tf2dir%\tf\custom\zzz_vusalo_base.vpk
	)
) else (
	md %tf2dir%\tf\custom
)
move /y bats\make_vusalo_base_vpk.bat %tf2dir%\Vusalo
move /y bats\revert_vusalo_file_operations.bat %tf2dir%\Vusalo
move /y bats\vusalo_file_operations.bat %tf2dir%\Vusalo
move /y vpks\vusalo_base.vpk %tf2dir%\tf\custom\zzz_vusalo_base.vpk
if exist %tf2dir%\tf\custom\vusalo_configuration (
	exit 0
)
move /y vusalo_configuration %tf2dir%\tf\custom\vusalo_configuration
echo FIRST TIME INSTALL DETECTED
echo WORKING AS INTENDED
cd %tf2dir%\Vusalo
start cmd /k call vusalo_file_operations.bat"
exit 0