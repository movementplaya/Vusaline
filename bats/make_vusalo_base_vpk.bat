@echo off
if exist "C:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2\tf\custom\zzz_vusalo_base" (
	"C:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2\bin\vpk.exe" "C:\Program Files (x86)\Steam\steamapps\common\Team Fortress 2\tf\custom\zzz_vusalo_base"
	rd /s /q "C:Program Files (x86)\Steam\steamapps\common\Team Fortress 2\tf\custom\zzz_vusalo_base"
	exit 0
)
cd
echo 'zzz_vusalo_base' directory doesn't exist
pause