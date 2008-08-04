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
unit uXboxLibraryPatches;

{$INCLUDE ..\Dxbx.inc}

interface

uses
  // Dxbx
  uXboxLibraryUtils,
  uEmuXapi;

// This method returns the actual patch function address for each patched method.
function XboxLibraryPatchToPatch(const aValue: TXboxLibraryPatch): TCodePointer;

implementation

const
  PatchFunctions: array [TXboxLibraryPatch] of TCodePointer = (
    {xlp_Unknown=}nil,
    {xlp_XapiInitProcess=}@XTL_EmuXapiInitProcess,
    {xlp_RtlCreateHeap=}@XTL_EmuRtlCreateHeap,
    {xlp_XapiApplyKernelPatches=}@XTL_EmuXapiApplyKernelPatches
  );

function XboxLibraryPatchToPatch(const aValue: TXboxLibraryPatch): TCodePointer;
begin
  Result := PatchFunctions[aValue];
end;

end.

