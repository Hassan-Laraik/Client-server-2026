unit uPrincipale;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBCtrls, DBGrids, DBExtCtrls, ZConnection, ZDataset, DBDateTimePicker;

type

  { TFrmPrinciale }

  TFrmPrinciale = class(TForm)
    BtnNouveau: TButton;
    BtnModifier: TButton;
    BtnSuprimer: TButton;
    BtnAnnuler: TButton;
    BtnValider: TButton;
    BtnRechercher: TButton;
    DBCMBXVile: TDBComboBox;
    DbDateInscrit: TDBDateEdit;
    DbedtID: TDBEdit;
    DbedtNom: TDBEdit;
    DbedtPrenom: TDBEdit;
    DbedtAdresse: TDBEdit;
    DBGrid1: TDBGrid;
    EdtRechercher: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnNouveauClick(Sender: TObject);
    procedure BtnRechercherClick(Sender: TObject);
    procedure BtnSuprimerClick(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
    procedure EdtRechercherChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
      procedure ValiderBottonsClients;
  public

  end;

var
  FrmPrinciale: TFrmPrinciale;

implementation
uses
  uDM;

{$R *.lfm}

{ TFrmPrinciale }



procedure TFrmPrinciale.BtnNouveauClick(Sender: TObject);
begin
  if  DM.Ajouter_Client() then
  begin
    DbedtNom.SetFocus;
  end else
  begin
   ShowMessage('Operation non effectuée');
  end;

  self.ValiderBottonsClients;

  //DM.ZtblClient.Append;
  //ZtblClient.Insert;
end;

procedure TFrmPrinciale.BtnRechercherClick(Sender: TObject);
begin
  DM.ZtblClient.Filtered:=false;
  DM.ZtblClient.Filter:= 'concat(nom,prenom,ville) like ' +
                          QuotedStr('*'+EdtRechercher.text+'*');
  DM.ZtblClient.Filtered:=true;
end;

procedure TFrmPrinciale.BtnSuprimerClick(Sender: TObject);
begin
  if DM.Supprimer_Client() then
  begin
     ShowMessage('Operation Effectuée');
  end else
  begin
    ShowMessage('Operation Non Effectuée');
  end
  //DM.ZtblClient.Delete;
end;

procedure TFrmPrinciale.BtnValiderClick(Sender: TObject);
begin
  if DM.Valider_Client() then
  begin
     ShowMessage('Client Ajouté/Modifié Avec Succée');
  end else
  begin
   ShowMessage('Operation Ajour / Modification Non Effectuée !!!') ;
  end;
  //DM.ZtblClient.Post;
  self.ValiderBottonsClients;
end;

procedure TFrmPrinciale.EdtRechercherChange(Sender: TObject);
begin
   DM.ZtblClient.Filtered:=false;
  DM.ZtblClient.Filter:= 'concat(nom,prenom,ville) like ' + QuotedStr('*'+EdtRechercher.text+'*');
 DM.ZtblClient.Filtered:=true;
end;

procedure TFrmPrinciale.FormCreate(Sender: TObject);
begin
  self.ValiderBottonsClients;
end;

Procedure TFrmPrinciale.ValiderBottonsClients();
begin
 BtnNouveau.Enabled  := (DM.ZtblClient.State = dsBrowse);
 BtnModifier.Enabled := (DM.ZtblClient.State = dsBrowse);
 BtnAnnuler.Enabled  := (DM.ZtblClient.State in [dsEdit,dsInsert]);
 BtnValider.Enabled  := (DM.ZtblClient.State in [dsEdit,dsInsert]);
end;

procedure TFrmPrinciale.BtnModifierClick(Sender: TObject);
begin
 if DM.Modifier_Client() then
 begin
   DbedtNom.SetFocus;
 end else
 begin
   ShowMessage('Opération Non Effectuée !');

 end;
 //DM.ZtblClient.Edit;
  self.ValiderBottonsClients;
end;

procedure TFrmPrinciale.BtnAnnulerClick(Sender: TObject);
begin
 if DM.Annuler_Client() then
 begin
    ShowMessage('Opération Annulée');
 end else
 begin
   ShowMessage('Operation Non Effectuée !!!');
 end;
  //DM.ZtblClient.Cancel;
  self.ValiderBottonsClients;
end;

end.

