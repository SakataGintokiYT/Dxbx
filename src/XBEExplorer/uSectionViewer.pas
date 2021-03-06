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
unit uSectionViewer;

interface

uses
  // Delphi
  Classes, Controls, ComCtrls,
  // Dxbx
  uViewerUtils,
  uHexViewer,
  uDisassembleViewer;

type
  TSectionViewer = class(TPageControl)
  protected
    FDisassembleViewer: TDisassembleViewer;
    FHexViewer: THexViewer;
  public
    constructor Create(Owner: TComponent); override;

    procedure SetRegion(const aRegionInfo: RRegionInfo);
  end;

implementation

{ TSectionViewer }

constructor TSectionViewer.Create(Owner: TComponent);

  procedure _NewTab(const aControl: TControl; const aTitle: string);
  var
    Tab: TTabSheet;
  begin
    Tab := TTabSheet.Create(Self);
    Tab.Parent := Self;
    Tab.PageControl := Self;
    Tab.Align := alClient;
    Tab.Caption := aTitle;

    aControl.Parent := Tab;
    aControl.Align := alClient;
  end;

begin
  inherited;

  Parent := TWinControl(Owner);

  FDisassembleViewer := TDisassembleViewer.Create(Self);
  FHexViewer := THexViewer.Create(Self);

  _NewTab(FDisassembleViewer, 'Disassembly');
  _NewTab(FHexViewer, 'Hex view');
end;

procedure TSectionViewer.SetRegion(const aRegionInfo: RRegionInfo);
begin
  FHexViewer.SetRegion(aRegionInfo);
  FDisassembleViewer.SetRegion(aRegionInfo);
end;

end.

