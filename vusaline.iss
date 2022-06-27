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
DisableDirPage=no
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
Source: "cfgs\*"; DestDir: "{app}\tf\custom\vusaline_configuration\cfg"; Flags: ignoreversion
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
	if not RegQueryStringValue(HKLM, ExpandConstant('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1'), 'InstallLocation', TF2Path) then
	begin
		if not RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 440', 'InstallLocation', TF2Path) then
		begin
			if RegQueryStringValue(HKLM, 'SOFTWARE\WOW6432Node\Valve\Steam', 'InstallPath', TF2Path) or RegQueryStringValue(HKLM, 'SOFTWARE\Valve\Steam', 'InstallPath', TF2Path) then
			begin
				Insert('\steamapps\common\Team Fortress 2', TF2Path, Length(TF2Path) + 1);
			end;
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

procedure CreateDropDown(page: TWizardPage; caption: String; cb: TNewComboBox; cvar: String; item0, item1, item2, item3, item4, item5 : String);
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
	cb.ItemIndex:= StrToInt(
		Copy(
			cfgStr,
			Pos(
				cvar,
				cfgStr
			) + Length(
				cvar
			) + 1,
			1
		)
	)
	cb.OnChange:= @DropDownChange;
end;

procedure TextBoxChange(Sender: TObject);
begin
	//This is ungodly
	Delete(
		cfgStr,
		Pos(
			'bind',
			Copy(
				cfgStr,
				Pos(
					TEdit(Sender).Hint,
					cfgStr
				) - 19,
				18
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
				) - 19,
				18
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
	tb.Text:= Copy(
		cfgStr,
		Pos(
			'bind',
			Copy(
				cfgStr,
				Pos(
					cmd,
					cfgStr
				) - 19,
				18
			)
		) + Pos(
			cmd,
			cfgStr
		) - 15,
		Pos(
			cmd, 
			cfgStr
		) - Pos(
			'bind',
			Copy(
				cfgStr,
				Pos(
					cmd,
					cfgStr
				) - 19,
				18
			)
		) - Pos(
			cmd,
			cfgStr
		) + 14
	);
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
	if not LoadStringFromFile(TF2Path + '\tf\custom\vusaline_configuration\cfg\settings.cfg', cfgAnsiStr) then
	begin
		ExtractTemporaryFile('settings.cfg');
		LoadStringFromFile(ExpandConstant('{tmp}\settings.cfg'), cfgAnsiStr);
	end;
	cfgStr:= cfgAnsiStr;
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
	CreateDropDown(SettingsPageC, 'Weather particle effects', cbWP, 'weather_particles', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Player x-rays', cbXR, 'xray', 'Disabled', 'Names & healthbars', 'Names, healthbars & outlines', '', '', '');
	CreateDropDown(SettingsPageC, 'Screenshot match end scoreboard', cbASS, 'auto_scoreboard_screenshot', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Backpack item borders', cbBP, 'backpack_borders', 'Disabled', 'Item quality borders', 'Item marketability borders', '', '', '');
	CreateDropDown(SettingsPageC, 'Block catbot identify', cbBCI, 'block_cathook_identify', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Block minidumps', cbBMD, 'block_minidumps', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Block player stats reset', cbBSR, 'block_stats_reset', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Dashboard panel sliding animation', cbDBA, 'dashboard_anim', 'Disabled', 'Normal', 'Extra smooth', '', '', '');
	CreateDropDown(SettingsPageC, 'All dashboard panels visible', cbDBF, 'dashboard_full', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Hit sounds', cbDL, 'ding_limit', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Disconnect prompt', cbDCP, 'disconnect_prompt', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Allow downloads', cbDLF, 'download_filter', 'None', 'Maps only', 'All except sounds', 'All', '', '');
	CreateDropDown(SettingsPageC, 'Mute players mode', cbMA, 'mute_all', 'Mute voice chat only', 'Mute voice chat & text chat', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Crash protection', cbP, 'protection', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Additional sound delay', cbSAD, 'sound_additional_delay', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Voice chat delay', cbVCD, 'voice_chat_delay', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageC, 'Movement keys', cbMK, 'movement_keys', 'WASD', 'ESDF', 'IJKL', 'ZQSD', ',AOE', 'WARS');
	CreateTextBox(SettingsPageC, 'Left map vote bind', tbMSL, 'vote_mapleft');
	CreateTextBox(SettingsPageC, 'Centre map vote bind', tbMSC, 'vote_mapcenter');
	CreateTextBox(SettingsPageC, 'Right map vote bind', tbMSR, 'vote_mapright');
	CreateTextBox(SettingsPageC, 'Instant resupply bind', tbIRS, 'force_resupply');

	SettingsPageB:= CreateCustomPage(wpSelectDir, 'Settings page 2', 'Performance settings');
	BackgroundBmp:= TBitmapImage.Create(SettingsPageB);
	BackgroundBmp.Bitmap.LoadFromFile(ExpandConstant('{tmp}\PageBackground.bmp'))
	BackgroundBmp.Stretch:= True;
	BackgroundBmp.Align:= alClient;
	BackgroundBmp.Parent:= SettingsPageB.Surface;
	CreateDropDown(SettingsPageB, 'Anti-aliasing (MSAA)', cbMSA, 'msaa', 'Disabled', '2x', '4x', '8x', '', '');
	CreateDropDown(SettingsPageB, 'OpenGL', cbOGL, 'opengl', 'NOT AVAILABLE', '', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Overlay decals (signs & posters)', cbOLD, 'overlay_decals', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Texture quality (picmip)', cbPM, 'picmip', 'Very low', 'Low', 'Medium', 'High', '', '');
	CreateDropDown(SettingsPageB, 'Pyrovision effects', cbPFX, 'pyrofx', 'Enable none', 'Enable static vignette', 'Enable DoF (depth of field)', 'Enable static vignette & DoF', '', '');
	CreateDropDown(SettingsPageB, 'Ragdolls', cbRD, 'ragdolls', 'Disabled', 'Enable for 6 seconds', 'Enable for 11 seconds', '', '', '');
	CreateDropDown(SettingsPageB, 'Raw mouse input', cbRIP, 'raw_input', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Demo recording requirements', cbRMD, 'remove_demos_with_no_kills', 'None', '2 kills in 10 minutes', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Ropes', cbR, 'ropes', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Player shadow quality', cbS, 'shadows', 'Disabled', 'Low', 'High', '', '', '');
	CreateDropDown(SettingsPageB, 'Critical hit text', cbSCT, 'show_crit_text', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Skybox dimensions', cbSBD, 'skybox_dimensions', '2', '3', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Sleep whilst unfocused', cbSUF, 'sleep_unfocused','Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Sound quality', cbSQ, 'sound_quality', 'Low', 'High', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Player spray decals', cbSD, 'spray_decals', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'HUD teammate status', cbTS, 'team_status', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'First-person bullet tracers', cbTFP, 'tracers_firstperson', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Viewmodels', cbVM, 'viewmodels', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Voice chat mode', cbVCM, 'voice_chat_mode', 'NOT AVAILABLE', '', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Virtual reality support', cbVRS, 'vr_support', '	NOT AVAILABLE', '', '', '', '', '');
	CreateDropDown(SettingsPageB, 'Windows 10 (single monitor)', cbW10, 'win10_mouse', 'No', 'Yes', '', '', '', '');

	SettingsPageA:= CreateCustomPage(wpSelectDir, 'Settings page 1', 'Performance settings');
	BackgroundBmp:= TBitmapImage.Create(SettingsPageA);
	BackgroundBmp.Bitmap.LoadFromFile(ExpandConstant('{tmp}\PageBackground.bmp'))
	BackgroundBmp.Stretch:= True;
	BackgroundBmp.Align:= alClient;
	BackgroundBmp.Parent:= SettingsPageA.Surface;
	CreateDropDown(SettingsPageA, 'Auto record demos', cbAD, 'auto_demos', 'None', 'Competitive Matches', 'Tournament Matches', 'All matches', '', '');
	CreateDropDown(SettingsPageA, 'Blood decals', cbB, 'blood', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Centred character eyes', cbCE, 'centered_eyes', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Text chat time', cbCT, 'chat_time', 'Disabled', '5 seconds', '10 seconds', '15 seconds', '', '');
	CreateDropDown(SettingsPageA, 'Character detail', cbCD, 'class_detail', 'Disable expressions, eyes & teeth', 'Disable expressions', 'Disable none', '', '', '');
	CreateDropDown(SettingsPageA, 'Contract progress type', cbCPT, 'contract_progress_type', 'Don''t show contracts', 'Show active contracts only', 'Show all contracts', '', '', '');
	CreateDropDown(SettingsPageA, 'Complex (fancy) material shaders', cbCM, 'complex_mats', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Max decals', cbD, 'decals', 'Disabled', '1', '15', '75', '200', '2048');
	CreateDropDown(SettingsPageA, 'Detail prop sprites', cbDPD, 'detail_props_distance', 'Disabled', 'Low', 'Medium', 'High', 'Very high', '');
	CreateDropDown(SettingsPageA, 'Dual-core processor', cbDC, 'dual_core', 'No', 'Yes', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Gibs/giblets', cbG, 'gibs', 'Disabled', 'Enabled', 'Brutal', '', '', '');
	CreateDropDown(SettingsPageA, 'Glow outlines', cbGOL, 'glow_outlines', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'High dynamic range', cbHDR, 'hdr', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Crosshair target avatar', cbIDA, 'idavatar', 'Disabled', 'Friends only', 'Everyone', '', '', '');
	CreateDropDown(SettingsPageA, 'In-game prompts', cbIGP, 'ingame_prompts', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Jigglebones', cbJB, 'jigglebones', 'Disabled', 'Enabled', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Level of detail', cbLOD, 'lod', 'Low', 'Medium', 'High', '', '', '');
	CreateDropDown(SettingsPageA, 'Packet loss (unstable network)', cbLS, 'loss_severity', 'None', 'Low', 'High', '', '', '');
	CreateDropDown(SettingsPageA, 'Low frame rate (<60fps)', cbLFP, 'low_fps', 'No', 'Yes', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Low RAM', cbLRA, 'low_ram', 'No', 'Yes', '', '', '', '');
	CreateDropDown(SettingsPageA, 'Low VRAM', cbLVR, 'low_vram', 'NOT AVAILABLE', '', '', '', '', '');
	
	WizardForm.NextButton.Left := WizardForm.BackButton.Left + WizardForm.BackButton.Width + ScaleX(2);
	WizardForm.CancelButton.Left := WizardForm.NextButton.Left + WizardForm.NextButton.Width + ScaleX(3);
	WizardForm.CancelButton.Top := WizardForm.NextButton.Top;
end;

function InitializeSetup(): Boolean;
begin
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