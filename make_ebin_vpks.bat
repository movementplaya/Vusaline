@echo off
if exist "D:\Steam\steamapps\common\Team Fortress 2\tf\custom\zzz_vusalo_base\" (
	"D:\Steam\steamapps\common\Team Fortress 2\bin\vpk.exe" "D:\Steam\steamapps\common\Team Fortress 2\tf\custom\zzz_vusalo_base"
	robocopy /IS /IT /IM "D:\Steam\steamapps\common\Team Fortress 2\tf\custom" E:\Synced\Git\vusalo zzz_vusalo_base.vpk
	rmdir /s /q "D:\Steam\steamapps\common\Team Fortress 2\tf\custom\zzz_vusalo_base"
	exit 0
)
echo 'zzz_vusalo_base' directory doesn't exist
pause