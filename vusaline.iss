#define MyAppName "Vusaline"
#define MyAppVersion "2022-06-23"
#define MyAppPublisher "Spookbuster"
#define MyAppURL "https://github.com/high-brow/Vusaline"

[Setup]
ArchitecturesInstallIn64BitMode=x64
Compression=lzma
DefaultDirName={code:GetTF2Path}
Output=yes
OutputBaseFilename=vusaline_installer
OutputDir=.
SolidCompression=yes

AppId={{53454E44-2048-454C-5020504C45415345}
AppName={#MyAppName}
AppPublisher={#MyAppPublisher}
AppUpdatesURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppVersion={#MyAppVersion}
CloseApplicationsFilter=*.dll,*.cfg,*.vpk
DirExistsWarning=no
UninstallDisplayName=vusaline_uninstall
UninstallFilesDir={app}\Vusaline
SetupIconFile=assets\dur.ico
WindowResizable=no
WizardResizable=no
WizardSizePercent=150,150
WizardSmallImageFile=assets\dur_small.bmp
WizardStyle=modern

[Files]
Source: "assets\*"; Flags: dontcopy
Source: "bats\*"; DestDir: "{app}\Vusaline"; Flags: ignoreversion
Source: "cfgs\*"; DestDir: "{app}\tf\custom\vusaline_configuration\cfg"; Flags: ignoreversion onlyifdoesntexist
Source: "vpks\*"; DestDir: "{app}\tf\custom"; Flags: ignoreversion

[Run]
Filename: "{app}\Vusaline\file_operations.bat"; Flags: postinstall runhidden

[UninstallRun]
Filename: "{app}\Vusaline\revert_file_operations.bat"; Flags: runhidden

[Code]
var
	cfgAnsiStr: AnsiString;
	cfgStr, TF2Path, cvar : String;
	curWidthA, curHeightA, curWidthB, curHeightB, curWidthC, curHeightC : Integer;
	cb: TNewComboBox;
	tb: TEdit;
	BackgroundBmp: TBitmapImage;
	SettingsPageA, SettingsPageB, SettingsPageC : TWizardPage;

procedure LoadVCLStyle(VClStyleFile: String); external 'LoadVCLStyleW@files:VclStylesInno.dll stdcall delayload setuponly';
procedure LoadVCLStyle_UnInstall(VClStyleFile: String); external 'LoadVCLStyleW@{tmp}\VclStylesInno.dll stdcall delayload uninstallonly';
procedure UnLoadVCLStyles; external 'UnLoadVCLStyles@files:VclStylesInno.dll stdcall delayload setuponly';
procedure UnLoadVCLStyles_UnInstall; external 'UnLoadVCLStyles@{tmp}\VclStylesInno.dll stdcall delayload uninstallonly';

function GetTF2Path(Parameter: String): String;
begin
	if not RegQueryStringValue(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 440','InstallLocation',TF2Path) then
	begin
		if RegQueryStringValue(HKEY_LOCAL_MACHINE,'SOFTWARE\WOW6432Node\Valve\Steam','InstallPath',TF2Path) or RegQueryStringValue(HKEY_LOCAL_MACHINE,'SOFTWARE\Valve\Steam','InstallPath',TF2Path) and DirExists(TF2Path) then
		begin
			Insert('\steamapps\common\Team Fortress 2', TF2Path, Length(TF2Path) + 1);
		end;
	end;
	Result:= TF2Path;
end;

procedure DropDownChange(Sender: TObject);
begin
	Delete(
		cfgStr,
		Pos(
			TNewComboBox(Sender).Hint,
			cfgStr
		) + Length(
			TNewComboBox(Sender).Hint
		) + 1,
		1
	);
	Insert(
		IntToStr(
			TNewComboBox(Sender).ItemIndex
		),
		cfgStr,
		Pos(
			TNewComboBox(Sender).Hint,
			cfgStr
		) + Length(
			TNewComboBox(Sender).Hint
		) + 1
	);
end;

procedure CreateDropDown(page: TWizardPage; caption: String; cb: TNewComboBox; cvar: String; index: Integer; item0, item1, item2, item3, item4, item5 : String);
var
	newLabel: TLabel;
begin
	newLabel:= TLabel.Create(page);
	newLabel.Parent:= page.Surface;
	newLabel.Caption:= caption;
	case page of
		SettingsPageA:
		begin
			newLabel.Left:= ScaleX(curWidthA);
			newLabel.Top:= ScaleY(curHeightA);
			case curWidthA of
				0:
				begin
					curWidthA:= curWidthA + 242;
				end;
				242:
				begin
					curWidthA:= curWidthA + 242;
				end;
				484:
				begin
					curWidthA:= 0;
					curHeightA:= curHeightA + 60;
				end;
			end;
		end;
		SettingsPageB:
		begin
			newLabel.Left:= ScaleX(curWidthB);
			newLabel.Top:= ScaleY(curHeightB);
			case curWidthB of
				0:
				begin
					curWidthB:= curWidthB + 242;
				end;
				242:
				begin
					curWidthB:= curWidthB + 242;
				end;
				484:
				begin
					curWidthB:= 0;
					curHeightB:= curHeightB + 60;
				end;
			end;
		end;
		SettingsPageC:
		begin
			newLabel.Left:= ScaleX(curWidthC);
			newLabel.Top:= ScaleY(curHeightC);
			case curWidthC of
				0:
				begin
					curWidthC:= curWidthC + 242;
				end;
				242:
				begin
					curWidthC:= curWidthC + 242;
				end;
				484:
				begin
					curWidthC:= 0;
					curHeightC:= curHeightC + 60;
				end;
			end;
		end;
	end;
	newLabel.Width:= ScaleX(186);
	newLabel.Height:= ScaleY(18);
	newLabel.Transparent:= True;

	cb:= TNewComboBox.Create(page);
	cb.Hint:= cvar;
	cb.Parent:= page.Surface;
	cb.Left:= newLabel.Left;
	cb.Top:= newLabel.Top + newLabel.Height + ScaleY(4);
	cb.Width:= newLabel.Width;
	cb.Height:= newLabel.Height;
	cb.Style:= csDropDownList;
	cb.Items.Add(item0);
	if Length(item1) > 0 then
	begin
		cb.Items.Add(item1);
		if Length(item2) > 0 then
		begin
			cb.Items.Add(item2);
			if Length(item3) > 0 then
			begin
				cb.Items.Add(item3);
				if Length(item4) > 0 then
				begin
					cb.Items.Add(item4);
					if Length(item5) > 0 then
					begin
						cb.Items.Add(item5);
					end;
				end;
			end;
		end;
	end;
	cb.ItemIndex:= index;
	cb.OnChange:= @DropDownChange;
end;

procedure TextBoxChange(Sender: TObject);
begin
	//This is ungodly
	Delete(cfgStr,
		Pos(
			'bind',
			Copy(
				cfgStr,
				Pos(
					TEdit(Sender).Hint,
					cfgStr
				) - 19, 18
			)
		) + Pos(
			TEdit(Sender).Hint,
			cfgStr
		) - 15,
		Pos(
			TEdit(Sender).Hint, 
			cfgStr
		) - Pos(
			'bind',
			Copy(
				cfgStr,
				Pos(
					TEdit(Sender).Hint,
					cfgStr
				) - 19, 18
			)
		) - Pos(
			TEdit(Sender).Hint,
			cfgStr
		) + 14
	);
	Insert(
		TEdit(Sender).Text,
		cfgStr,
		Pos(
			TEdit(Sender).Hint,
			cfgStr
		) - 1
	);
end;

procedure CreateTextBox(page: TWizardPage; caption: String; tb: TEdit; cmd: String);
var
	newLabel: TLabel;
begin
	newLabel:= TLabel.Create(page);
	newLabel.Parent:= page.Surface
	newLabel.Caption:= caption;
	case page of
		SettingsPageA:
		begin
			newLabel.Left:= ScaleX(curWidthA);
			newLabel.Top:= ScaleY(curHeightA);
			case curWidthA of
				0:
				begin
					curWidthA:= curWidthA + 242;
				end;
				242:
				begin
					curWidthA:= curWidthA + 242;
				end;
				484:
				begin
					curWidthA:= 0;
					curHeightA:= curHeightA + 60;
				end;
			end;
		end;
		SettingsPageB:
		begin
			newLabel.Left:= ScaleX(curWidthB);
			newLabel.Top:= ScaleY(curHeightB);
			case curWidthB of
				0:
				begin
					curWidthB:= curWidthB + 242;
				end;
				242:
				begin
					curWidthB:= curWidthB + 242;
				end;
				484:
				begin
					curWidthB:= 0;
					curHeightB:= curHeightB + 60;
				end;
			end;
		end;
		SettingsPageC:
		begin
			newLabel.Left:= ScaleX(curWidthC);
			newLabel.Top:= ScaleY(curHeightC);
			case curWidthC of
				0:
				begin
					curWidthC:= curWidthC + 242;
				end;
				242:
				begin
					curWidthC:= curWidthC + 242;
				end;
				484:
				begin
					curWidthC:= 0;
					curHeightC:= curHeightC + 60;
				end;
			end;
		end;
	end;
	newLabel.Width:= ScaleX(186);
	newLabel.Height:= ScaleY(18);
	newLabel.Transparent:= True;

	tb:= TEdit.Create(page);
	tb.Hint:= cmd;
	tb.Parent:= page.Surface;
	tb.Left:= newLabel.Left;
	tb.Top:= newLabel.Top + newLabel.Height + ScaleY(4);
	tb.Width:= newLabel.Width;
	tb.Height:= newLabel.Height;
	tb.OnChange:= @TextBoxChange;
end;

procedure ReplaceLabel(sourceLabel: TNewStaticText);
var
	newLabel: TLabel;
begin
  newLabel:= TLabel.Create(WizardForm);
  newLabel.Parent:= sourceLabel.Parent;
  newLabel.Font:= sourceLabel.Font;
  newLabel.Caption:= sourceLabel.Caption;
  newLabel.WordWrap:= sourceLabel.WordWrap;
  newLabel.Left:= sourceLabel.Left;
  newLabel.Top:= sourceLabel.Top;
  newLabel.Width:= sourceLabel.Width;
  newLabel.Height:= sourceLabel.Height;
  newLabel.Visible:= sourceLabel.Visible;
  newLabel.Transparent := True;

  sourceLabel.Visible:= False;
end;

procedure SetPageBackground(page: TNewNotebookPage; fileName: string);
begin
	BackgroundBmp:= TBitmapImage.Create(WizardForm);
	BackgroundBmp.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + fileName);
	BackgroundBmp.Stretch:= True;
	BackgroundBmp.Align:= alClient;
	BackgroundBmp.Parent:= page;
end;

procedure InitializeWizard();
var
	cbAD, cbB, cbCE, cbCT, cbCD, cbCPT, cbCM, cbD, cbDPD, cbDL, cbDC, cbG, cbGOL, cbHDR, cbIDA, cbIGP, cbJB, cbLOD, cbLRA, cbLS, cbLFP, cbLVR, cbMSA, cbOGL, cbOLD, cbPM, cbPFX, cbRD, cbRIP, cbRMD, cbR, cbS, cbSCT, cbSBD, cbSUF, cbSQ, cbSD, cbTS, cbTFP, cbVM, cbVCM, cbVRS, cbW10, cbWP, cbXR, cbASS, cbBP, cbBCI, cbBMD, cbBSR, cbDLF, cbDBA, cbDBF, cbDCP, cbMA, cbP, cbSAD, cbVCD, cbMK : TNewComboBox;
	tbMSL, tbMSC, tbMSR, tbIRS : TEdit;
begin
	ExtractTemporaryFile('InnerPageBackground.bmp');
	ExtractTemporaryFile('PageBackground.bmp');
	ExtractTemporaryFile('WizardFormBackground.bmp');

	SetPageBackground(WizardForm.WelcomePage, 'InnerPageBackground.bmp');
	SetPageBackground(WizardForm.InnerPage, 'InnerPageBackground.bmp');
	SetPageBackground(WizardForm.FinishedPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.LicensePage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.PasswordPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.InfoBeforePage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.UserInfoPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.SelectDirPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.SelectComponentsPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.SelectProgramGroupPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.SelectTasksPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.ReadyPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.PreparingPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.InstallingPage, 'PageBackground.bmp');
	SetPageBackground(WizardForm.InfoAfterPage, 'PageBackground.bmp');

	BackgroundBmp:= TBitmapImage.Create(WizardForm);
	BackgroundBmp.Bitmap.LoadFromFile(ExpandConstant('{tmp}\WizardFormBackground.bmp'))
	BackgroundBmp.Stretch:= True;
	BackgroundBmp.Align:= alClient;
	BackgroundBmp.Parent:= WizardForm;

	WizardForm.FinishedHeadingLabel.Visible:= False;
	WizardForm.Bevel1.Visible:= False;
	WizardForm.Bevel.Visible:= False;
	WizardForm.MainPanel.Visible:= False;
	WizardForm.SelectDirBitmapImage.Visible:= False;
	WizardForm.SelectGroupBitmapImage.Visible:= False;
	WizardForm.WizardSmallBitmapImage.Visible:= False;
	WizardForm.WizardBitmapImage.Visible:= False;

	ReplaceLabel(WizardForm.DiskSpaceLabel);
	ReplaceLabel(WizardForm.PasswordLabel);
	ReplaceLabel(WizardForm.PasswordEditLabel);
	ReplaceLabel(WizardForm.WelcomeLabel1);
	ReplaceLabel(WizardForm.InfoBeforeClickLabel);
	ReplaceLabel(WizardForm.PageNameLabel);
	ReplaceLabel(WizardForm.WelcomeLabel2);
	ReplaceLabel(WizardForm.LicenseLabel1);
	ReplaceLabel(WizardForm.InfoAfterClickLabel);
	ReplaceLabel(WizardForm.ComponentsDiskSpaceLabel);
	ReplaceLabel(WizardForm.BeveledLabel);
	ReplaceLabel(WizardForm.StatusLabel);
	ReplaceLabel(WizardForm.FilenameLabel);
	ReplaceLabel(WizardForm.SelectDirLabel);
	ReplaceLabel(WizardForm.SelectStartMenuFolderLabel);
	ReplaceLabel(WizardForm.SelectComponentsLabel);
	ReplaceLabel(WizardForm.SelectTasksLabel);
	ReplaceLabel(WizardForm.UserInfoNameLabel);
	ReplaceLabel(WizardForm.UserInfoOrgLabel);
	ReplaceLabel(WizardForm.PreparingLabel);
	ReplaceLabel(WizardForm.FinishedHeadingLabel);
	ReplaceLabel(WizardForm.UserInfoSerialLabel);
	ReplaceLabel(WizardForm.SelectDirBrowseLabel);
	ReplaceLabel(WizardForm.SelectStartMenuFolderBrowseLabel);

	SettingsPageC:= CreateCustomPage(wpSelectDir, 'Settings page 3', 'Performance settings & user preference')
	BackgroundBmp:= TBitmapImage.Create(SettingsPageC);
	BackgroundBmp.Bitmap.LoadFromFile(ExpandConstant('{tmp}\PageBackground.bmp'))
	BackgroundBmp.Stretch:= True;
	BackgroundBmp.Align:= alClient;
	BackgroundBmp.Parent:= SettingsPageC.Surface;
	CreateDropDown(SettingsPageC, 'Windows 10 (single monitor)', cbW10, 'win10_mouse', 0, 'No', 'Yes', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Weather particle effects', cbWP, 'weather_particles', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Player x-rays', cbXR, 'xray', 0, 'Disabled', 'Names & healthbars', 'Names, healthbars & outlines', '', '', '');
	CreateDropDown(SettingsPageC, 'Screenshot match end scoreboard', cbASS, 'auto_scoreboard_screenshot', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Backpack item borders', cbBP, 'backpack_borders', 1, 'Disabled', 'Item quality borders', 'Item marketability borders', '', '', '');
	CreateDropDown(SettingsPageC, 'Block catbot identify', cbBCI, 'block_cathook_identify', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Block minidumps', cbBMD, 'block_minidumps', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Block player stats reset', cbBSR, 'block_stats_reset', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Dashboard sliding animation', cbDBA, 'dashboard_anim', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Full dashboard', cbDBF, 'dashboard_full', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Disconnect prompt', cbDCP, 'disconnect_prompt', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Allow downloads', cbDLF, 'download_filter', 0, 'None', 'Maps only', 'All except sounds', 'All', '', '');
	CreateDropDown(SettingsPageC, 'Mute players mode', cbMA, 'mute_all', 1, 'Mute voice chat only', 'Mute voice chat & text chat', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Crash protection', cbP, 'protection', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Additional sound delay', cbSAD, 'sound_additional_delay', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Voice chat delay', cbVCD, 'voice_chat_delay', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Movement keys', cbMK, 'movement_keys', 0, 'WASD', 'ESDF', 'IJKL', 'ZQSD', ',AOE', 'WARS');
	CreateTextBox(SettingsPageC, 'Left map vote bind', tbMSL, 'vote_mapleft');
	CreateTextBox(SettingsPageC, 'Centre map vote bind', tbMSC, 'vote_mapcenter');
	CreateTextBox(SettingsPageC, 'Right map vote bind', tbMSR, 'vote_mapright');
	CreateTextBox(SettingsPageC, 'Instant resupply bind', tbIRS, 'force_respawn');

	SettingsPageB:= CreateCustomPage(wpSelectDir, 'Settings page 2', 'Performance settings');
	BackgroundBmp:= TBitmapImage.Create(SettingsPageB);
	BackgroundBmp.Bitmap.LoadFromFile(ExpandConstant('{tmp}\PageBackground.bmp'))
	BackgroundBmp.Stretch:= True;
	BackgroundBmp.Align:= alClient;
	BackgroundBmp.Parent:= SettingsPageB.Surface;
	CreateDropDown(SettingsPageB, 'Low VRAM', cbLVR, 'low_vram', 0, 'NOT AVAILABLE', '', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Anti-aliasing (MSAA)', cbMSA, 'msaa', 0, 'Disabled', '2x', '4x', '8x', '', '');
	CreateDropDown(SettingsPageB, 'OpenGL', cbOGL, 'opengl', 0, 'NOT AVAILABLE', '', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Overlay decals (signs && posters)', cbOLD, 'overlay_decals', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Texture quality (picmip)', cbPM, 'picmip', 3, 'Very low', 'Low', 'Medium', 'High', '', '');
	CreateDropDown(SettingsPageB, 'Pyrovision effects', cbPFX, 'pyrofx', 0, 'Enable none', 'Enable static vignette', 'Enable DoF (depth of field)', 'Enable static vignette & DoF', '', '');
	CreateDropDown(SettingsPageB, 'Ragdolls', cbRD, 'ragdolls', 2, 'Disabled', 'Enable for 6 seconds', 'Enable for 11 seconds', '', '', '');
	CreateDropDown(SettingsPageB, 'Raw mouse input', cbRIP, 'raw_input', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Demo recording requirements', cbRMD, 'remove_demos_with_no_kills', 0, 'None', '2 kills in 10 minutes', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Ropes', cbR, 'ropes', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Player shadow quality', cbS, 'shadows', 2, 'Disabled', 'Low', 'High', '', '', '');
	CreateDropDown(SettingsPageB, 'Critical hit text', cbSCT, 'show_crit_text', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Skybox dimensions', cbSBD, 'skybox_dimensions', 1, '2', '3', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Sleep whilst unfocused', cbSUF, 'sleep', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Sound quality', cbSQ, 'sound_quality', 1, 'Low', 'High', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Player spray decals', cbSD, 'spray_decals', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'HUD teammate status', cbTS, 'team_status', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'First-person bullet tracers', cbTFP, 'tracers_firstperson', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Viewmodels', cbVM, 'viewmodels', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Voice chat mode', cbVCM, 'voice_chat_mode', 0, 'NOT AVAILABLE', '', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Virtual reality support', cbVRS, 'vr_support', 0, '	NOT AVAILABLE', '', '', '', '', '');

	SettingsPageA:= CreateCustomPage(wpSelectDir, 'Settings page 1', 'Performance settings');
	BackgroundBmp:= TBitmapImage.Create(SettingsPageA);
	BackgroundBmp.Bitmap.LoadFromFile(ExpandConstant('{tmp}\PageBackground.bmp'))
	BackgroundBmp.Stretch:= True;
	BackgroundBmp.Align:= alClient;
	BackgroundBmp.Parent:= SettingsPageA.Surface;
	CreateDropDown(SettingsPageA, 'Auto record demos', cbAD, 'auto_demos', 0, 'None', 'Competitive Matches', 'Tournament Matches', 'All matches', '', '');
	CreateDropDown(SettingsPageA, 'Blood decals', cbB, 'blood', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Centred character eyes', cbCE, 'centered_eyes', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Text chat time', cbCT, 'chat_time', 2, 'Disabled', '5 seconds', '10 seconds', '15 seconds', '', '');
	CreateDropDown(SettingsPageA, 'Character detail', cbCD, 'class_detail', 2, 'Disable expressions, eyes & teeth', 'Disable expressions', 'Disable none', '', '', '');
	CreateDropDown(SettingsPageA, 'Contract progress type', cbCPT, 'contract_progress_type', 1, 'Don''t show contracts', 'Show active contracts only', 'Show all contracts', '', '', '');
	CreateDropDown(SettingsPageA, 'Complex (fancy) material shaders', cbCM, 'complex_mats', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Max decals', cbD, 'decals', 3, 'Disabled', '1', '15', '75', '200', '2048');
	CreateDropDown(SettingsPageA, 'Detail prop sprites', cbDPD, 'detail_props_distance', 2, 'Disabled', 'Low', 'Medium', 'High', 'Very high', '');
	CreateDropDown(SettingsPageA, 'Hit sounds', cbDL, 'dinglimit', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Dual-core processor', cbDC, 'dual_core', 0, 'No', 'Yes', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Gibs/giblets', cbG, 'gibs', 1, 'Disabled', 'Enabled', 'Brutal', '', '', '');
	CreateDropDown(SettingsPageA, 'Glow outlines', cbGOL, 'glow_outlines', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'High dynamic range', cbHDR, 'hdr', 0, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Crosshair target avatar', cbIDA, 'idavatar', 1, 'Disabled', 'Friends only', 'Everyone', '', '', '');
	CreateDropDown(SettingsPageA, 'In-game prompts', cbIGP, 'ingame_prompts', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Jigglebones', cbJB, 'jigglebones', 1, 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Level of detail', cbLOD, 'lod', 2, 'Low', 'Medium', 'High', '', '', '');
	CreateDropDown(SettingsPageA, 'Packet loss (unstable network)', cbLS, 'loss_severity', 0, 'None', 'Low', 'High', '', '', '');
	CreateDropDown(SettingsPageA, 'Low frame rate (<60fps)', cbLFP, 'low_fps', 0, 'No', 'Yes', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Low RAM', cbLRA, 'low_ram', 0, 'No', 'Yes', '', '', '', '');
	
	WizardForm.NextButton.Left := WizardForm.BackButton.Left + WizardForm.BackButton.Width + ScaleX(2);
	WizardForm.CancelButton.Left := WizardForm.NextButton.Left + WizardForm.NextButton.Width + ScaleX(3);
	WizardForm.CancelButton.Top := WizardForm.NextButton.Top;
end;

function InitializeSetup(): Boolean;
begin
	LoadStringFromFile(ExpandConstant('{src}/cfgs/settings.cfg'), cfgAnsiStr);
	cfgStr:= cfgAnsiStr;
	ExtractTemporaryFile('Dark.vsf');
	LoadVCLStyle(ExpandConstant('{tmp}\Dark.vsf'));
	Result:=True;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
	if CurPageID = wpSelectDir then
	begin
		WizardForm.DirEdit.Text:= TF2Path;
	end
	else if CurPageID = wpReady then
	begin
		ReplaceLabel(WizardForm.ReadyLabel);
		WizardForm.ReadyMemo.Height:= 90;
	end
	else if CurPageID = wpFinished then
	begin
		ReplaceLabel(WizardForm.FinishedLabel);
		WizardForm.RunList.Width:= ScaleX(141);
		WizardForm.RunList.Height:= ScaleY(21);
	end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
	if CurStep = ssDone then
	begin
		cfgAnsiStr:= cfgStr;
		SaveStringToFile(ExpandConstant('{app}/tf/custom/vusaline_configuration/cfg/settings.cfg'), cfgAnsiStr, False);
	end;
end;

procedure DeinitializeSetup();
begin
	UnLoadVclStyles;
end;