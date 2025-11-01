unit uDM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset,dialogs;

type

  { TDM }

  TDM = class(TDataModule)
    DSZClient: TDataSource;
    DSClient: TDataSource;
    ZNX: TZConnection;
    ZqryClient: TZQuery;
    ZtblClient: TZTable;
  private

  public
    function Ajouter_Client():boolean;
    function Modifier_Client():boolean;
    function Supprimer_Client():boolean;
    function Annuler_Client():boolean;
    function Valider_Client():boolean;
  end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }



function TDM.Ajouter_Client(): boolean;
begin
  try
   ZtblClient.Append;
   Result := True;
  except
    Result := False;
  end;

end;

function TDM.Modifier_Client(): boolean;
begin
  try
   ZtblClient.Edit;
   Result := True;
  except
    Result := False;
  end;
end;

function TDM.Supprimer_Client(): boolean;
begin
   try
    if Not ZtblClient.IsEmpty then
    begin
     ZtblClient.Delete;
     Result := True;
    end else
    begin
      Result := False;
    end;
  except
    Result := False;
  end;
end;

function TDM.Annuler_Client(): boolean;
begin
  try
     ZtblClient.Cancel;
     Result := True;
  except
    Result := False;
  end;
end;

function TDM.Valider_Client(): boolean;
begin
   try
     ZtblClient.Post;
     Result := True;
  except on e:Exception do
    begin
      ShowMessage(e.Message);
      Result := False;
    end;

  end;
end;

end.

