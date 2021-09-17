cd tf\cfg
move /y autoexec.cfg.disabled autoexec.cfg
cd ..\..

cd bin
move /y bugreporter.dll.disabled bugreporter.dll
move /y bugreporter_filequeue.dll.disabled bugreporter_filequeue.dll
move /y bugreporter_public.dll.disabled bugreporter_public.dll
move /y mssdolby.flt.disabled mssdolby.flt
move /y mssds3d.flt.disabled mssds3d.flt
move /y mssdsp.flt.disabled mssdsp.flt
move /y msseax.flt.disabled msseax.flt
move /y msssrs.flt.disabled msssrs.flt
move /y stdshader_dbg.dll.disabled stdshader_dbg.dll
move /y stdshader_dx6.dll.disabled stdshader_dx6.dll
move /y stdshader_dx7.dll.disabled stdshader_dx7.dll
move /y stdshader_dx8.dll.disabled stdshader_dx8.dll
move /y video_bink.dll.disabled video_bink.dll
move /y video_quicktime.dll.disabled video_quicktime.dll
move /y vaudio_speex.dll.disabled vaudio_speex.dll
move /y openvr_api.dll.disabled openvr_api.dll
move /y sourcevr.dll.disabled sourcevr.dll
move /y mssmp3.asi.disabled mssmp3.asi
move /y SDL2.dll.disabled SDL2.dll
move /y steamerrorreporter.exe.disabled steamerrorreporter.exe

cd ..\..\..\..
move /y crashhandler.dll.disabled crashhandler.dll
move /y crashhandler64.dll.disabled crashhandler64.dll
move /y steamerrorreporter.exe.disabled steamerrorreporter.exe
move /y steamerrorreporter64.exe.disabled steamerrorreporter64.exe

cd "steamapps\common\Team Fortress 2\hl2"
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

cd ..\tf
move /y media_disabled media