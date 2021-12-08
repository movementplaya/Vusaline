:: DON'T CHANGE THESE UNLESS YOU KNOW WHAT YOU ARE DOING
:: A player with a modified TF2 instance isn't valuable data
set /A block_crash_reporting=1
:: Inferior to the new Opus codec in every conceivable way; Speex might be used on a community server for nostalgia and/or memeing reasons
set /A block_speex_voice_codec=1
:: Also worse than Opus (sv_voicecodec steam); again, a community server might use this
set /A block_celt_voice_codec=1
:: Virtual Reality only works on VR headsets with a Direct Mode OFF option; you can use 'Virtual Desktop' on Quest 1/2 to workaround having no Direct Mode, but good luck getting that working correctly
set /A block_vr=1
:: Class voicelines don't play anymore, it's an interesting experience
set /A block_all_voicelines=0
:: Never set to 1 if you know nothing about SDL2 (including its usage in TF2)
set /A use_new_sdl2=0
:: Breaks unimportant sounds on maps, notably on arena_byre; will also spam console with attempts to load missing audio files
set /A disable_hl2_sounds=0
:: Gets in the way of playing the game
set /A disable_map_intros=1

cd ..
cd tf\cfg
move /y autoexec.cfg autoexec2.cfg
cd ..\..

cd bin
move /y bugreporter.dll bugreporter.dll.disabled
move /y bugreporter_filequeue.dll bugreporter_filequeue.dll.disabled
move /y bugreporter_public.dll bugreporter_public.dll.disabled
move /y mssdolby.flt mssdolby.flt.disabled
move /y mssds3d.flt mssds3d.flt.disabled
move /y mssdsp.flt mssdsp.flt.disabled
move /y msseax.flt msseax.flt.disabled
move /y msssrs.flt msssrs.flt.disabled
move /y stdshader_dbg.dll.disabled stdshader_dbg.dll
move /y stdshader_dx6.dll stdshader_dx6.dll.disabled
move /y stdshader_dx7.dll stdshader_dx7.dll.disabled
move /y stdshader_dx8.dll stdshader_dx8.dll.disabled
move /y video_bink.dll video_bink.dll.disabled
move /y video_quicktime.dll video_quicktime.dll.disabled

if %block_crash_reporting%==1 (
	move /y steamerrorreporter.exe steamerrorreporter.exe.disabled
	cd ..\..\..\..
	move /y crashhandler.dll crashhandler.dll.disabled
	move /y crashhandler64.dll crashhandler64.dll.disabled
	move /y steamerrorreporter.exe steamerrorreporter.exe.disabled
	move /y steamerrorreporter64.exe steamerrorreporter64.exe.disabled
	cd "steamapps\common\Team Fortress 2\bin"
)
if %block_crash_reporting%==0 (
	move /y steamerrorreporter.exe.disabled steamerrorreporter.exe
	cd ..\..\..\..
	move /y crashhandler.dll.disabled crashhandler.dll
	move /y crashhandler64.dll.disabled crashhandler64.dll
	move /y steamerrorreporter.exe.disabled steamerrorreporter.exe
	move /y steamerrorreporter64.exe.disabled steamerrorreporter64.exe
	cd "steamapps\common\Team Fortress 2\bin"
)

if %block_speex_voice_codec%==1 (
	move /y vaudio_speex.dll vaudio_speex.dll.disabled
)
if %block_speex_voice_codec%==0 (
	move /y vaudio_speex.dll.disabled vaudio_speex.dll
)

if %block_celt_voice_codec%==1 (
	move /y vaudio_celt.dll vaudio_celt.dll.disabled
)
if %block_celt_voice_codec%==0 (
	move /y vaudio_celt.dll.disabled vaudio_celt.dll
)

if %block_vr%==1 (
	move /y openvr_api.dll openvr_api.dll.disabled
	move /y sourcevr.dll sourcevr.dll.disabled
)
if %block_vr%==0 (
	move /y openvr_api.dll.disabled openvr_api.dll
	move /y sourcevr.dll.disabled sourcevr.dll
)

if %block_all_voicelines%==1 (
	move /y mssmp3.asi mssmp3.asi.disabled
)
if %block_all_voicelines%==0 (
	move /y mssmp3.asi.disabled mssmp3.asi
)

if %use_new_sdl2%==1 (
	move /y SDL2.dll SDL2.dll.disabled
)
if %use_new_sdl2%==0 (
	move /y SDL2.dll.disabled SDL2.dll
)

if %disable_hl2_sounds%==1 (
	cd ..\hl2
	move /y hl2_sound_misc_000.vpk hl2_sound_misc_000.vpk.disabled
	move /y hl2_sound_misc_001.vpk hl2_sound_misc_001.vpk.disabled
	move /y hl2_sound_misc_002.vpk hl2_sound_misc_002.vpk.disabled
	move /y hl2_sound_misc_dir.vpk hl2_sound_misc_dir.vpk.disabled
	move /y hl2_sound_vo_english_000.vpk hl2_sound_vo_english_000.vpk.disabled
	move /y hl2_sound_vo_english_001.vpk hl2_sound_vo_english_001.vpk.disabled
	move /y hl2_sound_vo_english_002.vpk hl2_sound_vo_english_002.vpk.disabled
	move /y hl2_sound_vo_english_003.vpk hl2_sound_vo_english_003.vpk.disabled
	move /y hl2_sound_vo_english_004.vpk hl2_sound_vo_english_004.vpk.disabled
	move /y hl2_sound_vo_english_dir.vpk hl2_sound_vo_english_dir.vpk.disabled
)
if %disable_hl2_sounds%==0 (
	cd ..\hl2
	move /y hl2_sound_misc_000.vpk.disabled hl2_sound_misc_000.vpk
	move /y hl2_sound_misc_001.vpk.disabled hl2_sound_misc_001.vpk
	move /y hl2_sound_misc_002.vpk.disabled hl2_sound_misc_002.vpk
	move /y hl2_sound_misc_dir.vpk.disabled hl2_sound_misc_dir.vpk
	move /y hl2_sound_vo_english_000.vpk.disabled hl2_sound_vo_english_000.vpk
	move /y hl2_sound_vo_english_001.vpk.disabled hl2_sound_vo_english_001.vpk
	move /y hl2_sound_vo_english_002.vpk.disabled hl2_sound_vo_english_002.vpk
	move /y hl2_sound_vo_english_003.vpk.disabled hl2_sound_vo_english_003.vpk
	move /y hl2_sound_vo_english_004.vpk.disabled hl2_sound_vo_english_004.vpk
	move /y hl2_sound_vo_english_dir.vpk.disabled hl2_sound_vo_english_dir.vpk
)

if %disable_map_intros%==1 (
	cd ..\tf
	move /y media_disabled media
)
if %disable_map_intros%==0 (
	cd ..\tf
	move /y media media_disabled
)
exit 0