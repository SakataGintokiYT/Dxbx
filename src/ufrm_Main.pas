(*
    This file is part of Dxbx - a XBox emulator written in Delphi (ported over from cxbx)
    Copyright (C) 2007 Shadow_tj and other members of the development team.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*)
unit ufrm_Main;

{$INCLUDE Dxbx.inc}

interface

uses
  // Delphi
  Windows, SysUtils, StrUtils, Classes, Messages, Controls, StdCtrls, ComCtrls, ExtCtrls,
  Types, GraphUtil,
  Grids, Menus, ActnList, Forms, Dialogs, Graphics, jpeg,
  ShellAPI, IniFiles,
  xmldom, XMLIntf, msxmldom, XMLDoc,
  // Jedi Win32API
  JwaWinType,
  // Jcl
  JclShell, // SHDeleteFiles
  // Dxbx
  uTypes,
  uConsts,
  uLog,
  uWindows,
  uDxbxUtils,
  uXbe,
  uEmuShared,
  uDxbxXml,
  uData,
  ufrm_ControllerConfig,
  ufrm_VideoConfig,
  ufrm_About;

const
  clXboxGreen = $22CC88;//22BB77;//27BB73;//00DE97;//0DB366;//0FB869;

type
  Tfrm_Main = class(TForm)
    MainMenu1: TMainMenu;
    mnu_File: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    Edit1: TMenuItem;
    View1: TMenuItem;
    Settings1: TMenuItem;
    Emulation1: TMenuItem;
    Help1: TMenuItem;
    mnu_About: TMenuItem;
    mnu_OpenXbe: TMenuItem;
    mnu_CloseXbe: TMenuItem;
    N2: TMenuItem;
    mnu_RecentXbefiles: TMenuItem;
    mnu_Logbitmap: TMenuItem;
    mnu_Patch: TMenuItem;
    N3: TMenuItem;
    mnu_DumpxbeinfoTo: TMenuItem;
    mnu_DebugoutputGUI: TMenuItem;
    mnu_DebugoutputKernel: TMenuItem;
    mnu_ConfigControler: TMenuItem;
    mnu_ConfigAudio: TMenuItem;
    mnu_Configvideo: TMenuItem;
    Start1: TMenuItem;
    ActionList: TActionList;
    ActStartEmulation: TAction;
    actAbout: TAction;
    actConfigController: TAction;
    actConfigAudio: TAction;
    actConfigVideo: TAction;
    actClose: TAction;
    actOpenXbe: TAction;
    actCloseXbe: TAction;
    actSaveXbe: TAction;
    actSaveXbeAs: TAction;
    XbeOpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    mnu_GuiOutputConsole: TMenuItem;
    mnu_DebugOutputGuiFile: TMenuItem;
    mnu_DebugKernelOutputConsole: TMenuItem;
    mnu_DebugOutputKernelFile: TMenuItem;
    Console3: TMenuItem;
    mnu_DumpXbeInfoToFile: TMenuItem;
    actConsoleXbeInfo: TAction;
    actFileXbeInfo: TAction;
    actConsoleDebugGui: TAction;
    actFileDebugGui: TAction;
    actConsoleDebugKernel: TAction;
    actFileDebugKernel: TAction;
    Import1: TMenuItem;
    mnu_ExportLogoBitmap: TMenuItem;
    actImportLogo: TAction;
    actExportLogo: TAction;
    LogoSaveDialog: TSaveDialog;
    ExeSaveDialog: TSaveDialog;
    ools1: TMenuItem;
    XdkTracker1: TMenuItem;
    xIso1: TMenuItem;
    actXdkTracker: TAction;
    actXIso: TAction;
    N8: TMenuItem;
    XDKTracker2: TMenuItem;
    actXdkTrackerXbeInfo: TAction;
    StatusBar: TStatusBar;
    ImageIcon: TImage;
    ImageLogo: TImage;
    mnu_Gambitmap: TMenuItem;
    mnu_ExportGameBitmap: TMenuItem;
    actExportGameImage: TAction;
    miXbeExplorer: TMenuItem;
    actXbeExplorer: TAction;
    actCleanSymbolCache: TAction;
    miCleanSymbolCache: TMenuItem;
    dgXbeInfos: TDrawGrid;
    Label1: TLabel;
    imgLaunchButton: TImage;
    XMLDocument: TXMLDocument;
    lblFreeTextFilter: TLabel;
    cbFreeTextFilter: TComboBox;
    procedure actStartEmulationExecute(Sender: TObject);
    procedure actOpenXbeExecute(Sender: TObject);
    procedure actCloseXbeExecute(Sender: TObject);
    procedure actConfigControllerExecute(Sender: TObject);
    procedure actConfigVideoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actConsoleXbeInfoExecute(Sender: TObject);
    procedure actFileXbeInfoExecute(Sender: TObject);
    procedure actConsoleDebugGuiExecute(Sender: TObject);
    procedure actFileDebugGuiExecute(Sender: TObject);
    procedure actConsoleDebugKernelExecute(Sender: TObject);
    procedure actFileDebugKernelExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actExportLogoExecute(Sender: TObject);
    procedure actXdkTrackerExecute(Sender: TObject);
    procedure actXIsoExecute(Sender: TObject);
    procedure actXdkTrackerXbeInfoExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actExportGameImageExecute(Sender: TObject);
    procedure actXbeExplorerExecute(Sender: TObject);
    procedure actCleanSymbolCacheExecute(Sender: TObject);
    procedure dgXbeInfosDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgLaunchButtonMouseLeave(Sender: TObject);
    procedure imgLaunchButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgLaunchButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure imgLaunchButtonMouseEnter(Sender: TObject);
    procedure imgLaunchButtonClick(Sender: TObject);
    procedure dgXbeInfosClick(Sender: TObject);
    procedure cbFreeTextFilterKeyPress(Sender: TObject; var Key: Char);
    procedure cbFreeTextFilterSelect(Sender: TObject);
  private
    procedure RedrawBackground;
    procedure UpdateLaunchButton;
    function LoadXbe(const aFileName: string): Boolean;
  private
    MyXBEList: TStringList;
    EnabledItems: array of TXbeInfo;
    procedure UpdateFilter;
//    function FindDuplicate(const aXBEInfo: TXBEInfo): Integer;
//    function FindByFileName(const aFileName: string): Integer;
    function InsertXBEInfo(const aXbeInfo: TXBEInfo{; const aPreventDuplicates: Boolean}): Boolean;
//    procedure SaveXBEList(const aFilePath, aPublishedBy: string);
//    function ShowImportList(const XBEImportList: TStringList; Publisher: string): Integer;
    function LoadXBEList(aImportFilePath: string = ''; aUseImportDialog: Boolean = False): Integer;
//    procedure ImportTxtDumps(const aTxtDumpsFolder: TFileName);
//    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
  private
    m_Xbe: TXbe;

    Emulation_State: EMU_STATE;

    OldLBWindowProc: TWndMethod;
    BackgroundImage: TBitmap;
    procedure LaunchXBE(const aXbe: TXbe);
    procedure CloseXbe;

    procedure ReadSettingsIni;
    procedure WriteSettingsIni;

    procedure RecentXbeAdd(aFileName: string);
    procedure ReopenXbe(Sender: TObject);

    function SendCommandToXdkTracker: Boolean;

    procedure WMDROPFILES(var Msg: TMessage); //message WM_DROPFILES;
    procedure LBWindowProc(var Message: TMessage);

    procedure AdjustMenu;
    procedure UpdateIcon(const aXbe: TXBE);
    function GetCellText(aCol, aRow: Integer): string;
  public
    FApplicationDir: string;

    destructor Destroy; override;
  end;

var
  KernelDebugMode: TDebugMode = dmFile;
  KernelDebugFileName: string = '';

  frm_Main: Tfrm_Main;

implementation

procedure GradientHorizontalLineCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const X, Y, Width: Integer);
var
  ARect: TRect;
begin
  ARect := Types.Rect(X, Y, X + Width, Y + ACanvas.Pen.Width);
  GradientFillCanvas(ACanvas, AStartColor, AEndColor, ARect, gdHorizontal);
end;

procedure GradientVerticalLineCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const X, Y, Height: Integer);
var
  ARect: TRect;
begin
  ARect := Types.Rect(X, Y, X + ACanvas.Pen.Width, Y + Height);
  GradientFillCanvas(ACanvas, AStartColor, AEndColor, ARect, gdVertical);
end;

{ Tfrm_Main }

{$R *.DFM}

const
  cXbeExplorerPath = 'XbeExplorer.exe';
  cXDKTrackerPath = 'XdkTracker.exe';
  cXIsoPath = 'xIso.exe';

procedure Tfrm_Main.FormCreate(Sender: TObject);
var
  XBEFilePath: string;
//  i: Integer;
begin
  dgXbeInfos.ColCount := 5;

  BackgroundImage := TBitmap.Create;

  RedrawBackground;
  UpdateLaunchButton;

  FApplicationDir := ExtractFilePath(Application.ExeName);

  MyXBEList := TStringList.Create;
  MyXBEList.CaseSensitive := False;
  if LoadXBEList(FApplicationDir + cXDK_TRACKER_DATA_FILE) > 0 then
    UpdateFilter;

  PEmuShared(nil).Init;

  Emulation_State := esNone;
(*
  // Calculated the exact X resolution :
  i := GetSystemMetrics(SM_CXFIXEDFRAME);
  i := i + 800 + i;
  Constraints.MaxWidth := i; Constraints.MinWidth := i;
  ClientWidth := i;

  // Calculated the exact Y resolution :
  i := GetSystemMetrics(SM_CYFIXEDFRAME);
  i := i + GetSystemMetrics(SM_CYMENU) + 600 + StatusBar.Height + i;
  Constraints.MaxHeight := i; Constraints.MinHeight := i;
  ClientHeight := i;

(*
  // This proves the emulated screen is resized :
  dgXbeInfos.Width := 320;
  dgXbeInfos.Height := 200;
*)

  // Dxbx Note : This prevents close-exceptions (we have with a "message WM_DROPFILES" procedure) :
  OldLBWindowProc := WindowProc; // store defualt WindowProc
  WindowProc := LBWindowProc; // replace default WindowProc
  DragAcceptFiles(Handle, True); // now ListBox1 accept dropped files

  StatusBar.SimpleText := 'DXBX: No Xbe Loaded...';

  ReadSettingsIni;

  CreateLogs(DebugMode, DebugFileName);

  AdjustMenu;

  XBEFilePath := ParamStr(1);

  if  (XBEFilePath <> '')
  and SameText(ExtractFileExt(XBEFilePath), '.xbe')
  and TXbe.FileExists(XBEFilePath) then
  begin
    if OpenXbe(XBEFilePath, {var}m_Xbe) then
      LaunchXBE(m_Xbe);
    // TODO : Error logging should go here
  end;
end; // FormCreate

procedure Tfrm_Main.FormDestroy(Sender: TObject);
begin
  WriteSettingsIni();
  CloseLogs();
  if Assigned(m_Xbe) then
    CloseXbe();
end;

destructor Tfrm_Main.Destroy;
begin
  WindowProc := OldLBWindowProc;

  PEmuShared(nil).Cleanup;

  FreeAndNil(BackgroundImage);

  inherited Destroy;
end;

procedure Tfrm_Main.WMDROPFILES(var Msg: TMessage);
var
  pcFileName: PChar;
  i, iSize, iFileCount: Integer;
begin
  pcFileName := ''; // to avoid compiler warning message
  iFileCount := DragQueryFile(Msg.wParam, $FFFFFFFF, pcFileName, 255);
  for i := 0 to iFileCount - 1 do
  begin
    iSize := DragQueryFile(Msg.wParam, i, nil, 0) + 1;
    pcFileName := StrAlloc(iSize);
    try
      DragQueryFile(Msg.wParam, i, pcFileName, iSize);
      if LoadXbe(pcFileName) then
        Break;
    finally
      StrDispose(pcFileName);
    end;
  end;

  DragFinish(Msg.wParam);
end; // WMDROPFILES

procedure Tfrm_Main.LBWindowProc(var Message: TMessage);
begin
  if Message.Msg = WM_DROPFILES then
    WMDROPFILES(Message); // handle WM_DROPFILES message

  OldLBWindowProc(Message);
  // call default ListBox1 WindowProc method to handle all other messages
end;

procedure Tfrm_Main.FormPaint(Sender: TObject);
begin
  if Assigned(BackgroundImage) then
    Canvas.Draw(0, 0, BackgroundImage);
end;

procedure Tfrm_Main.FormResize(Sender: TObject);
begin
  RedrawBackground;
  Invalidate;
end;

procedure Tfrm_Main.RedrawBackground;
var
  MinWidth: Integer;
  JPEGImage: TJPEGImage;
begin
  MinWidth := 0;
  if Assigned(BackgroundImage) then
  begin
    BackgroundImage.SetSize(Width, Height);
    BackgroundImage.Canvas.Brush.Color := Color;
    BackgroundImage.Canvas.FillRect(BackgroundImage.Canvas.ClipRect);

    JPEGImage := GetJPEGResource('GUIHeaderLeft');
    Inc(MinWidth, JPEGImage.Width);
    BackgroundImage.Canvas.Draw(0, 0, JPEGImage);

    JPEGImage := GetJPEGResource('GUIHeaderRight');
    Inc(MinWidth, JPEGImage.Width);
    BackgroundImage.Canvas.Draw(Width - JPEGImage.Width, 0, JPEGImage);

    JPEGImage := GetJPEGResource('GUIHeaderCenter');
    Inc(MinWidth, JPEGImage.Width);
    BackgroundImage.Canvas.Draw((Width - JPEGImage.Width) div 2, 0, JPEGImage);

    BackgroundImage.Canvas.Pen.Width := 2;
    GradientHorizontalLineCanvas(BackgroundImage.Canvas, clBlack, clXboxGreen, 0, dgXbeInfos.Top - 2, Width div 2);
    GradientHorizontalLineCanvas(BackgroundImage.Canvas, clXboxGreen, clBlack, 0 + Width div 2, dgXbeInfos.Top - 2, Width div 2);

    Constraints.MinWidth := MinWidth;
  end;
end; // RedrawBackground

function Tfrm_Main.GetCellText(aCol, aRow: Integer): string;
begin
  Result := '';
  if aRow = 0 then
  begin
    case aCol of
      0: Result := 'Title';
      1: Result := 'Region';
      2: Result := 'Version';
      3: Result := 'DumpInfo';
      4: Result := 'Path';
    end;
    Exit;
  end;

  Dec(aRow);
  if aRow < Length(EnabledItems) then
    case aCol of
      0: Result := EnabledItems[aRow].Title;
      1: Result := GameRegionToString(EnabledItems[aRow].GameRegion); // TODO : Show this as images later on
      2: Result := EnabledItems[aRow].LibVersions.Values['D3D8'];
      3: Result := EnabledItems[aRow].DumpInfo;
      4: Result := EnabledItems[aRow].FileName;
    end;
end; // GetCellText

procedure Tfrm_Main.dgXbeInfosClick(Sender: TObject);
begin
  LoadXbe(GetCellText(dgXbeInfos.Row, {Path=Col}4));
end;

procedure Tfrm_Main.dgXbeInfosDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Where: TRect;
  Format: UINT;
begin
  if gdFixed in State then
  begin
    // Put gradient lines next to the header columns :
    Where := Rect;
    TDrawGrid(Sender).Canvas.Pen.Color := clLime;
    TDrawGrid(Sender).Canvas.Pen.Width := 2;
    GradientVerticalLineCanvas(TDrawGrid(Sender).Canvas, clBlack, clXboxGreen, Where.Right-2, Where.Top, Where.Bottom - Where.Top);
    // Render titles in bold :
    TDrawGrid(Sender).Canvas.Font.Style := [fsBold];
  end;

  // Draw cell's text :
  Where := Rect;
  InflateRect(Where, -4, -4);
  Inc(Where.Top, 3);
  if aCol = 2 then // Align 'Version' column right :
    Format := DT_RIGHT
  else
    Format := DT_LEFT;
  DrawText(TDrawGrid(Sender).Canvas.Handle, GetCellText(aCol, aRow), -1, Where, Format or DT_RTLREADING);
end; // dgXbeInfosDrawCell

procedure Tfrm_Main.cbFreeTextFilterKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  Str: string;
begin
  if Key = #13 then
  begin
    // Make the current text the first in the dropdown list :
    Str := cbFreeTextFilter.Text;
    i := cbFreeTextFilter.Items.IndexOf(Str);
    if i >= 0 then
      cbFreeTextFilter.Items.Move(i, 0)
    else
    begin
      cbFreeTextFilter.Items.Add(Str);
      if cbFreeTextFilter.Items.Count > 10 then
        cbFreeTextFilter.Items.Delete(cbFreeTextFilter.Items.Count - 1);
    end;

    // Apply the chosen filter :
    UpdateFilter;
  end;
end; // cbFreeTextFilterKeyPress

procedure Tfrm_Main.cbFreeTextFilterSelect(Sender: TObject);
begin
  UpdateFilter;
end;

procedure Tfrm_Main.UpdateFilter;
var
  i, CurrentRow: Integer;
  FilterStr: string;

  function _MaySee: Boolean;
  var
    i: Integer;
  begin
    Result := (FilterStr = '');
    if not Result then
      for i := 0 to dgXbeInfos.ColCount - 1 do
      begin
        Result := AnsiContainsText(GetCellText(i, CurrentRow+1), FilterStr);
        if Result then
          Exit;
      end;
  end;

begin
  // Build a list of Xbe's that pass the filter :
  SetLength(EnabledItems, MyXBEList.Count);
  CurrentRow := 0;
  FilterStr := cbFreeTextFilter.Text;
  for i := 0 to MyXBEList.Count - 1 do
  begin
    EnabledItems[CurrentRow] := TXbeInfo(MyXBEList.Objects[i]);
    if _MaySee then
      Inc(CurrentRow);
  end;

  SetLength(EnabledItems, CurrentRow);
  // Make the grid show the filtered list :
  dgXbeInfos.RowCount := 1 + CurrentRow;
  dgXbeInfos.Repaint;
end; // UpdateFilter

procedure Tfrm_Main.UpdateLaunchButton;
var
  LaunchButtonResName: string;
begin
  case imgLaunchButton.Tag of
    2: LaunchButtonResName := 'ButtonLaunchPressed';
    1: LaunchButtonResName := 'ButtonLaunchHoover';
  else LaunchButtonResName := 'ButtonLaunchNormal';
  end;

  imgLaunchButton.Canvas.Draw(0, 0, GetJPEGResource(LaunchButtonResName));
end;

procedure Tfrm_Main.imgLaunchButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgLaunchButton.Tag := 2;
  UpdateLaunchButton;
end;

procedure Tfrm_Main.imgLaunchButtonMouseEnter(Sender: TObject);
begin
  imgLaunchButton.Tag := 1;
  UpdateLaunchButton;
end;

procedure Tfrm_Main.imgLaunchButtonMouseLeave(Sender: TObject);
begin
  imgLaunchButton.Tag := 0;
  UpdateLaunchButton;
end;

procedure Tfrm_Main.imgLaunchButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  imgLaunchButton.Tag := 1;
  UpdateLaunchButton;
end;

procedure Tfrm_Main.imgLaunchButtonClick(Sender: TObject);
begin
  actStartEmulationExecute(Sender);
end;

procedure Tfrm_Main.actConfigControllerExecute(Sender: TObject);
begin
  frm_ControllerConfig := Tfrm_ControllerConfig.Create(nil);

  if frm_ControllerConfig.ShowModal = mrOk then
  begin
  end;

  FreeAndNil({var}frm_ControllerConfig);
end;

procedure Tfrm_Main.actConfigVideoExecute(Sender: TObject);
begin
  frm_VideoConfig := Tfrm_VideoConfig.Create(nil);

  if frm_VideoConfig.ShowModal = mrOk then
  begin
  end;

  FreeAndNil({var}frm_VideoConfig);
end;

procedure Tfrm_Main.actStartEmulationExecute(Sender: TObject);
begin
  if not Assigned(m_Xbe) then
  begin
    MessageDlg('No xbe file loaded', mtInformation, [mbOk], 0);
    Exit;
  end;

  LaunchXBE(m_Xbe);
end;

procedure Tfrm_Main.actConsoleXbeInfoExecute(Sender: TObject);
begin
  // dump xbe information to debug console
  if m_Xbe.DumpInformation then
    WriteLog(m_szAsciiTitle + '`s .xbe info was successfully dumped.')
  else
    WriteLog(m_szAsciiTitle + '`s .xbe info was successfully dumped.'); // NOT!
end;

procedure Tfrm_Main.actFileXbeInfoExecute(Sender: TObject);
begin
  SaveDialog.FileName := m_Xbe.DetermineDumpFileName;
  SaveDialog.Filter := DIALOG_FILTER_TEXT;

  if SaveDialog.Execute then
  begin
    // ask permisssion to override if file exists
    if FileExists(SaveDialog.FileName) then
    begin
      if MessageDlg('Overwrite existing file?', mtConfirmation, [mbYes, mbNo], -1) = mrNo then
        Exit;
    end;

    m_Xbe.DumpInformation(SaveDialog.FileName);
    WriteLog(m_szAsciiTitle + '''s .xbe info was successfully dumped.');
    MessageDlg(m_szAsciiTitle + '''s .xbe info was successfully dumped.', mtInformation, [mbOk], 0);
  end;
end; // actFileXbeInfoExecute

procedure Tfrm_Main.actConsoleDebugGuiExecute(Sender: TObject);
begin
  if DebugMode = dmConsole then
  begin
    actConsoleDebugGui.Checked := False;
    DebugMode := dmNone;
    CloseLogs;
  end
  else
  begin
    CloseLogs;
    actFileDebugGui.Checked := False;
    actConsoleDebugGui.Checked := True;
    DebugMode := dmConsole;
    CreateLogs(DebugMode, DebugFileName);
  end;
end; // actConsoleDebugGuiExecute

procedure Tfrm_Main.actFileDebugGuiExecute(Sender: TObject);
begin
  if DebugMode = dmFile then
  begin
    actFileDebugGui.Checked := False;
    CloseLogs;
    AdjustMenu;
  end
  else
  begin
    if DebugFileName <> '' then
      SaveDialog.FileName := DebugFileName
    else
      SaveDialog.FileName := DXBX_CONSOLE_DEBUG_FILENAME;

    SaveDialog.Filter := DIALOG_FILTER_TEXT;
    if SaveDialog.Execute then
    begin
      CloseLogs;
      DebugMode := dmFile;
      DebugFileName := SaveDialog.FileName;

      CreateLogs(DebugMode, DebugFileName);
      AdjustMenu;
    end;
  end;
end; // actFileDebugGuiExecute

procedure Tfrm_Main.actConsoleDebugKernelExecute(Sender: TObject);
begin
  if KernelDebugMode = dmConsole then
  begin
    actConsoleDebugKernel.Checked := False;
    CloseLogs;
  end
  else
  begin
    CloseLogs;
    actFileDebugKernel.Checked := False;
    actConsoleDebugKernel.Checked := True;
    KernelDebugMode := dmConsole;
  end;
end; // actConsoleDebugKernelExecute

procedure Tfrm_Main.actFileDebugKernelExecute(Sender: TObject);
begin
  if KernelDebugMode = dmFile then
  begin
    actFileDebugKernel.Checked := False;
    CloseLogs;
    AdjustMenu;
  end
  else
  begin
    if KernelDebugFileName <> '' then
      SaveDialog.FileName := KernelDebugFileName
    else
      SaveDialog.FileName := DXBX_KERNEL_DEBUG_FILENAME;

    SaveDialog.Filter := DIALOG_FILTER_TEXT;
    if SaveDialog.Execute then
    begin
      CloseLogs;
      KernelDebugMode := dmFile;
      KernelDebugFileName := SaveDialog.FileName;
      AdjustMenu;
    end;
  end;
end; // actFileDebugKernelExecute

procedure Tfrm_Main.actAboutExecute(Sender: TObject);
begin
  frm_About := Tfrm_About.Create(Self);

  if frm_About.ShowModal = mrOk then
  begin
  end;

  FreeAndNil({var}frm_About);
end;

procedure Tfrm_Main.actCleanSymbolCacheExecute(Sender: TObject);
begin
  SHDeleteFiles(Handle, SymbolCacheFolder + '\*' + SymbolCacheFileExt, [doAllowUndo, doFilesOnly]);
end;

procedure Tfrm_Main.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Main.actOpenXbeExecute(Sender: TObject);
begin
//  XbeOpenDialog.Filter := DIALOG_FILTER_XBE;
  if XbeOpenDialog.Execute then
    LoadXbe(XbeOpenDialog.FileName);
end;

procedure Tfrm_Main.actCloseXbeExecute(Sender: TObject);
begin
  CloseXbe();
end;

procedure Tfrm_Main.actExportGameImageExecute(Sender: TObject);
var
  bmp: TBitmap;
begin
  LogoSaveDialog.FileName := m_szAsciiTitle + '.bmp';
  if not LogoSaveDialog.Execute then
    Exit;

  // ask permission to overwrite if file exists
  if FileExists(LogoSaveDialog.FileName) then
  begin
    if MessageDlg('Overwrite existing file?', mtConfirmation, [mbYes, mbNo], -1) = mrYes then
      DeleteFile(LogoSaveDialog.FileName)
    else
      Exit;
  end;

  // export logo bitmap
  bmp := TBitmap.Create;
  try
    m_Xbe.ExportIconBitmap(bmp);
    bmp.SaveToFile(LogoSaveDialog.FileName);
  finally
    FreeAndNil(bmp);
    WriteLog(m_szAsciiTitle + '''s game image was successfully exported.');
  end;
end; // actExportGameImageExecute

procedure Tfrm_Main.actExportLogoExecute(Sender: TObject);
var
  bmp: TBitmap;
begin
  LogoSaveDialog.FileName := 'logo.bmp';
  if not LogoSaveDialog.Execute then
    Exit;

  // ask permission to overwrite if file exists
  if FileExists(LogoSaveDialog.FileName) then
  begin
    if MessageDlg('Overwrite existing file?', mtConfirmation, [mbYes, mbNo], -1) = mrYes then
      DeleteFile(LogoSaveDialog.FileName)
    else
      Exit;
  end;

  // export logo bitmap
  bmp := TBitmap.Create;
  try
    m_Xbe.ExportLogoBitmap(bmp);
    bmp.SaveToFile(LogoSaveDialog.FileName);
  finally
    FreeAndNil(bmp);
    WriteLog(m_szAsciiTitle + '''s logo bitmap was successfully exported.');
  end;
end; // actExportLogoExecute

procedure Tfrm_Main.actXbeExplorerExecute(Sender: TObject);
var
  Arg: PChar;
begin
  if FileExists(FApplicationDir + cXbeExplorerPath) then
  begin
    if Assigned(m_Xbe) then
      Arg := PChar(AnsiQuotedStr(m_Xbe.XbePath, '"'))
    else
      Arg := nil;

    ShellExecute(0, 'open', PChar(FApplicationDir + cXbeExplorerPath), Arg, nil, SW_SHOWNORMAL);
  end;
end;

procedure Tfrm_Main.actXdkTrackerExecute(Sender: TObject);
begin
  if FileExists(FApplicationDir + cXDKTrackerPath) then
    ShellExecute(0, 'open', PChar(FApplicationDir + cXDKTrackerPath), nil, nil, SW_SHOWNORMAL);
end;

procedure Tfrm_Main.actXIsoExecute(Sender: TObject);
begin
  if FileExists(FApplicationDir + cXIsoPath) then
    ShellExecute(0, 'open', PChar(FApplicationDir + cXIsoPath), nil, nil, SW_SHOWNORMAL);
end;

procedure Tfrm_Main.actXdkTrackerXbeInfoExecute(Sender: TObject);
var
  DumpFilePath: string;
begin
  if FileExists(FApplicationDir + cXDKTrackerPath) then
  begin
    DumpFilePath := FApplicationDir + 'Tools\Dump.dat';
    DxbxXml.CreateXmlXbeDump(DumpFilePath, m_Xbe);

    if not SendCommandToXdkTracker then
      ShellExecute(0, 'open', PChar(FApplicationDir + cXDKTrackerPath), '/XBEDUMP', nil, SW_SHOWNORMAL);
  end;
end;

procedure Tfrm_Main.ReadSettingsIni;
var
  DxbxIniFilePath: string;
  IniFile: TIniFile;
  i: Integer;
begin
  DxbxIniFilePath := FApplicationDir + 'Dxbx.Ini';
  if not FileExists(DxbxIniFilePath) then
  begin
    // Setting defaults
    DebugMode := dmNone;
    KernelDebugMode := dmFile;

    Exit;
  end;

  IniFile := TIniFile.Create(DxbxIniFilePath);
  try
    DebugMode := TDebugMode(IniFile.ReadInteger('Settings', 'DxbxDebug', Ord(dmNone)));
    DebugFileName := IniFile.ReadString('Settings', 'DxbxDebugFileName', '');

    KernelDebugMode := TDebugMode(IniFile.ReadInteger('Settings', 'KrnlDebug', Ord(dmNone)));
    KernelDebugFileName := IniFile.ReadString('Settings', 'KrnlDebugFileName', '');

    // Read recent XBE files
    with TStringList.Create do
    try
      Delimiter := '|';
      StrictDelimiter := True;

      DelimitedText := IniFile.ReadString('Recent', 'XBEs', '');
      mnu_RecentXbefiles.Clear;
      for i := 0 to Count - 1 do
        RecentXbeAdd(Strings[i]);
    finally
      Free;
    end;
  finally
    FreeAndNil({var}IniFile);
  end;
end; // ReadSettingsIni

procedure Tfrm_Main.WriteSettingsIni;
var
  IniFile: TIniFile;
  RecentTMP: string;
  i: Integer;
begin
  IniFile := TIniFile.Create(FApplicationDir + 'Dxbx.Ini');
  try
    // Recent XBEs write
    RecentTMP := '';
    if mnu_RecentXbefiles.Count >= 1 then
    begin
      RecentTMP := mnu_RecentXbefiles.Items[0].Hint;
      for i := 1 to mnu_RecentXbefiles.Count - 1 do
        RecentTMP := RecentTMP + '|' + mnu_RecentXbefiles.Items[i].Hint;
    end;
    IniFile.WriteString('Recent', 'XBEs', RecentTMP);

    IniFile.WriteInteger('Settings', 'DxbxDebug', Ord(DebugMode));
    IniFile.WriteString('Settings', 'DxbxDebugFileName', DebugFileName);

    IniFile.WriteInteger('Settings', 'KrnlDebug', Ord(KernelDebugMode));
    IniFile.WriteString('Settings', 'KrnlDebugFileName', KernelDebugFileName);
  finally
    FreeAndNil(IniFile);
  end;
end; // WriteSettingsIni

procedure Tfrm_Main.AdjustMenu;
begin
  // Init File
  actOpenXbe.Enabled := True;
  actCloseXbe.Enabled := False;

  actSaveXbe.Enabled := False;
  actSaveXbeAs.Enabled := False;

  mnu_RecentXbefiles.Enabled := (mnu_RecentXbefiles.Count > 0);

  actClose.Enabled := True;

  // Init Edit
  mnu_Logbitmap.Enabled := False;
  mnu_Patch.Enabled := False;
  mnu_DumpxbeinfoTo.Enabled := False;
  mnu_Gambitmap.Enabled := False;

  // Init View
  actConsoleDebugGui.Checked := (DebugMode = dmConsole);
  actFileDebugGui.Checked := (DebugMode = dmFile);

  actConsoleDebugKernel.Checked := (KernelDebugMode = dmConsole);
  actFileDebugKernel.Checked := (KernelDebugMode = dmFile);

  ActStartEmulation.Enabled := False;

  if Emulation_State = esFileOpen then
  begin
    mnu_Logbitmap.Enabled := True;
    mnu_Gambitmap.Enabled := True;
    mnu_DumpxbeinfoTo.Enabled := FileExists(FApplicationDir + cXDKTrackerPath);
    mnu_CloseXbe.Enabled := True;
    actCloseXbe.Enabled := True;
    ActStartEmulation.Enabled := True;
  end;

  // Init Tools
  actXbeExplorer.Enabled := FileExists(FApplicationDir + cXbeExplorerPath);
  actXdkTracker.Enabled := FileExists(FApplicationDir + cXDKTrackerPath);
  actXIso.Enabled := FileExists(FApplicationDir + cXIsoPath);
end; // AdjustMenu

procedure Tfrm_Main.LaunchXBE(const aXbe: TXbe);
begin
  ShellExecute(0, 'open', PChar(ParamStr(0)), PChar(
    '/load ' +
    AnsiQuotedStr(aXbe.XbePath, '"') + ' ' +
//    IntToStr(Self.Handle) + ' ' +
    IntToStr(dgXbeInfos.Handle) + ' ' +
    IntToStr(Ord(KernelDebugMode)) + ' ' +
    AnsiQuotedStr(KernelDebugFileName, '"')
    ), nil, SW_SHOWNORMAL);

  Caption := m_szAsciiTitle + ' - Dxbx [Emulating]'
end;

function Tfrm_Main.LoadXbe(const aFileName: string): Boolean;
begin
  if Assigned(m_Xbe) then
    CloseXbe();

  Result := OpenXbe(aFileName, {var}m_Xbe);
  if Result then
  begin
    StatusBar.SimpleText := Format('DXBX: %s Loaded', [m_szAsciiTitle]);
    UpdateIcon(m_Xbe);

    RecentXbeAdd(XbeOpenDialog.FileName);
    Emulation_State := esFileOpen;
    AdjustMenu;
  end
  else
  begin
    MessageDlg('Can not open Xbe file.', mtWarning, [mbOk], 0);
    Emulation_State := esNone;
    AdjustMenu;
  end;
end; // LoadXbe

procedure Tfrm_Main.CloseXbe;
begin
  FreeAndNil(m_Xbe);
  Emulation_State := esNone;
  UpdateIcon(nil);
  AdjustMenu;

  WriteLog(Format('DXBX: %s Closed...', [m_szAsciiTitle]));
  StatusBar.SimpleText := 'DXBX:';
end;

procedure Tfrm_Main.ReopenXbe(Sender: TObject);
var
  TempItem: TMenuItem;
begin
  TempItem := Sender as TMenuItem;
  if not TXbe.FileExists(TempItem.Hint) then
  begin
    MessageDlg('Could not locate file : ' + TempItem.Hint, mtWarning, [mbOk], 0);
    mnu_RecentXbefiles.Remove(TempItem);
    Exit;
  end;

  if Assigned(m_Xbe) then
    CloseXbe();

  if not OpenXbe(TempItem.Hint, {var}m_Xbe) then
  begin
    MessageDlg('Can not open Xbe file.', mtWarning, [mbOk], 0);
    Exit;
  end;

  StatusBar.SimpleText := Format('DXBX: %s Loaded', [m_szAsciiTitle]);
  UpdateIcon(m_Xbe);
  Emulation_State := esFileOpen;
  AdjustMenu;
end; // ReopenXbe

procedure Tfrm_Main.RecentXbeAdd(aFileName: string);
var
  TempItem: TMenuItem;
  i: Integer;
begin
  for i := 0 to mnu_RecentXbefiles.Count - 1 do
  begin
    if mnu_RecentXbefiles.Items[i].Hint = aFileName then
    begin
      mnu_RecentXbefiles.Remove(mnu_RecentXbefiles.Items[i]);
      Break;
    end;
  end;

  TempItem := TMenuItem.Create(mnu_RecentXbefiles);
  TempItem.Hint := aFileName;
  TempItem.Caption := aFileName;
  TempItem.OnClick := ReopenXbe;

  while mnu_RecentXbefiles.Count >= _RecentXbeLimit do
    mnu_RecentXbefiles.Remove(mnu_RecentXbefiles.Items[mnu_RecentXbefiles.Count - 1]);

  mnu_RecentXbefiles.Insert(0, TempItem);
  mnu_RecentXbefiles.Enabled := True;
end; // RecentXbeAdd

procedure Tfrm_Main.UpdateIcon(const aXbe: TXBE);
var
  i: Integer;
  LibName: string;
  Version: string;
begin
  if Assigned(aXBE) and aXbe.ExportLogoBitmap(ImageLogo.Picture.Bitmap) then
    ImageLogo.Show
  else
    ImageLogo.Hide;

  if Assigned(aXBE) and aXbe.ExportIconBitmap(ImageIcon.Picture.Bitmap) then
    ImageIcon.Show
  else
    ImageIcon.Hide;

  if Assigned(aXBE) then
  try
    Label1.Caption := Format(
      '%s'#13 +
      'ID:%.08x'#13 +
      'Region:%s'#13 +
      #13 +
      'Library versions', [
      PChar(m_szAsciiTitle),
      aXbe.m_Certificate.dwTitleId,
      GameRegionToString(aXbe.m_Certificate.dwGameRegion)]);

    // Add library versions (TODO : Sort them alfabetically)
    for i := 0 to aXbe.m_Header.dwLibraryVersions - 1 do
    begin
      LibName := string(Copy(aXbe.m_LibraryVersion[i].szName, 1, XBE_LIBRARYNAME_MAXLENGTH));
      Version := IntToStr(aXbe.m_LibraryVersion[i].wMajorVersion) + '.' +
        IntToStr(aXbe.m_LibraryVersion[i].wMinorVersion) + '.' +
        IntToStr(aXbe.m_LibraryVersion[i].wBuildVersion);
      Label1.Caption := Label1.Caption +
        #13 + LibName + StringOfChar(' ', 8 - Length(LibName)) + ':' + Version;
    end;
  except
  end
  else
    Label1.Caption := '';

  if m_szAsciiTitle <> ''  then
    Caption := m_szAsciiTitle + ' - Dxbx'
  else
    Caption := 'Dxbx';
end; // UpdateIcon

function _ReadXBEInfoFromNode(const XBEInfoNode: IXMLNode): TXBEInfo;
var
  XDKNode, LibNode: IXMLNode;
begin
  Result := TXBEInfo.Create;
  Result.FileName := XML_ReadString(XBEInfoNode, 'FileName');
  if Result.FileName = '' then
  begin
    // Old-style 'Name' values are read here :
    Result.Title := XML_ReadString(XBEInfoNode, 'Name');
    Result.DumpInfo := '';
    Result.GameRegion := 0;
  end
  else
  begin
    Result.Title := XML_ReadString(XBEInfoNode, 'Title');
    Result.GameRegion := Cardinal(StrToIntDef(XML_ReadString(XBEInfoNode, 'GameRegion'), 0));
    Result.DumpInfo := XML_ReadString(XBEInfoNode, 'DumpInfo');
  end;

  XDKNode := XBEInfoNode.ChildNodes.FindNode('XDKVersions');
  if Assigned(XDKNode) then
  begin
    LibNode := XDKNode.ChildNodes.First;
    while Assigned(LibNode) do
    begin
      Result.LibVersions.Values[LibNode.LocalName] := LibNode.Text;
      LibNode := LibNode.NextSibling;
    end;

    Result.LibVersions.Sort;
  end;
end; // _ReadXBEInfoFromNode

function Tfrm_Main.InsertXBEInfo(const aXBEInfo: TXBEInfo{; const aPreventDuplicates: Boolean}): Boolean;
(*var
  i: Integer;*)
begin
  Result := False;
  if not Assigned(aXBEInfo) then
    Exit;

(*
  if aPreventDuplicates then
    i := FindDuplicate(aXbeInfo)
  else
    i := -1;

  if i >= 0 then
  begin
    // Replace existing :
    MyXBEList.Objects[i].Free;
    MyXBEList.Objects[i] := aXBEInfo;
    MyXBEList.Strings[i] := aXBEInfo.Title;
  end
  else
*)
    MyXBEList.AddObject(aXBEInfo.Title, aXBEInfo);

  Result := True;
end; // TfrmMain.InsertXBEInfo

function Tfrm_Main.LoadXBEList(aImportFilePath: string = '';
  aUseImportDialog: Boolean = False): Integer;
var
  XMLRootNode: IXMLNode;
  XMLNode: IXMLNode;
  XBEInfoNode: IXMLNode;
  Publisher: string;
  FileName: string;
  XBEImportList: TStringList;
  i: Integer;
begin
  Result := 0;
  if aImportFilePath = '' then
    aImportFilePath := FApplicationDir + 'Dump.dat';

  if not FileExists(aImportFilePath) then
    Exit;

  XmlDocument.Active := False;
  XmlDocument.FileName := aImportFilePath;
  try
    XmlDocument.Active := True;
  except
    on E: EDOMParseError do
    begin
      MessageDlg('Error parsing the file!', mtError, [mbOk], -1);
      XmlDocument.Active := False;
    end
    else
      XmlDocument.Active := False;
  end;

  if not XmlDocument.Active then
    Exit;

  XBEImportList := TStringList.Create;
  try
    XMLRootNode := XMLDocument.DocumentElement;

    XMLNode := XMLRootNode.ChildNodes.FindNode('PublishedInfo');
    if Assigned(XMLNode) then
      Publisher := XML_ReadString(XMLNode, 'PublishedBy');

    XMLNode := XMLRootNode.ChildNodes.FindNode('GameList');
    if Assigned(XMLNode) then
      XBEInfoNode := XMLNode.ChildNodes.First
    else
      XBEInfoNode := XMLRootNode;

    while Assigned(XBEInfoNode) do
    begin
      FileName := XML_ReadString(XBEInfoNode, 'FileName');
      if FileName = '' then
        // Old-style 'Name' values are read here, interpreted as FileName :
        FileName := XML_ReadString(XBEInfoNode, 'Name');

      // For now, only add to list when the user can intervene,
      // or when not yet present :
//      if aUseImportDialog
//      or (FindByFileName(FileName) < 0) }then
        XBEImportList.AddObject('', _ReadXBEInfoFromNode(XBEInfoNode));

      XBEInfoNode := XBEInfoNode.NextSibling;
    end;

//    if aUseImportDialog then
//      Result := ShowImportList(XBEImportList, Publisher)
//    else
      for i := 0 to XBEImportList.Count - 1 do
        if InsertXBEInfo(TXBEInfo(XBEImportList.Objects[i])) then
          Inc(Result);

    MyXBEList.Sort;

  finally
    FreeAndNil({var}XBEImportList);
  end;
end; // Tfrm_Main.LoadXBEList

function Tfrm_Main.SendCommandToXdkTracker: Boolean;
var
  stringToSend: string;
  copyDataStruct: TCopyDataStruct;

  function _SendData(copyDataStruct: TCopyDataStruct): Boolean;
  var
    receiverHandle: Windows.THandle;
    res: Integer;
  begin
    Result := False;
    receiverHandle := FindWindow(PChar('TfrmXdkTracker'), nil);
    if receiverHandle = 0 then
      Exit;

    res := SendMessage(receiverHandle, WM_COPYDATA, Integer(Handle), Integer(@copyDataStruct));
    if res > 0 then
      Result := True;
  end;

begin
  stringToSend := 'READXML';

  copyDataStruct.dwData := Integer(0); //use it to identify the message contents
  copyDataStruct.cbData := 1 + Length(stringToSend);
  copyDataStruct.lpData := PChar(stringToSend);

  Result := _SendData(copyDataStruct);
end; // SendCommandToXdkTracker

end.
