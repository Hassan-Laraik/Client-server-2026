unit uClient;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls;

type

  { TFrmClient }

  TFrmClient = class(TForm)
    BtnRechercher: TButton;
    BtnModifier: TButton;
    Nouveau: TButton;
    BtnEditer: TButton;
    Valider: TButton;
    Supprimer: TButton;
    DBGrid1: TDBGrid;
    EdtNom: TEdit;
    EdtPrenom: TEdit;
    EdtEmail: TEdit;
    EdtAdresse: TEdit;
    EdtVille: TEdit;
    EdtRecherchr: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure BtnEditerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnRechercherClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NouveauClick(Sender: TObject);
    procedure ValiderClick(Sender: TObject);
  private

  public

  end;

var
  FrmClient: TFrmClient;

implementation

uses uDM;

{$R *.lfm}

{ TFrmClient }

procedure TFrmClient.BtnRechercherClick(Sender: TObject);
begin
  DM.ZqryClient.SQL.Clear;
  DM.ZqryClient.SQL.Add('select  *  from  clients  where concat(nom,prenom,ville) like ');
  DM.ZqryClient.SQL.Add(QuotedStr('%'+EdtRecherchr.text+'%'));
  DM.ZqryClient.Open;
end;

procedure TFrmClient.FormCreate(Sender: TObject);
begin
  DM.ZqryClient.SQL.Clear;
DM.ZqryClient.SQL.add('select *  from clients');
DM.ZqryClient.Open;
end;

procedure TFrmClient.BtnEditerClick(Sender: TObject);
begin
 EdtNom.text:=  Dm.ZqryClient.FieldByName('nom').AsString;
 EdtPrenom.text:=  Dm.ZqryClient.FieldByName('prenom').AsString;
 EdtEmail.text:=  Dm.ZqryClient.FieldByName('email').AsString;
 EdtAdresse.text:=  Dm.ZqryClient.FieldByName('adrese').AsString;
 EdtVille.text:=  Dm.ZqryClient.FieldByName('ville').AsString;
end;

procedure TFrmClient.BtnModifierClick(Sender: TObject);
var
  id: Integer;
begin
  id := DM.ZqryClient.FieldByName('id').AsInteger;

  // Vérifier si l'email existe déjà pour un autre client
  DM.ZqryClient.Close;
  DM.ZqryClient.SQL.Clear;
  DM.ZqryClient.SQL.Add('SELECT id FROM clients WHERE email = :email AND id <> :id');
  DM.ZqryClient.ParamByName('email').AsString := Trim(EdtEmail.Text);
  DM.ZqryClient.ParamByName('id').AsInteger := id;
  DM.ZqryClient.Open;

  if not DM.ZqryClient.IsEmpty then
  begin
    DM.ZqryClient.Close;
  DM.ZqryClient.SQL.Clear;
  DM.ZqryClient.SQL.Add('SELECT * FROM clients ORDER BY id');
  DM.ZqryClient.Open;
  DM.ZqryClient.Locate('id',id,[]);
    ShowMessage('⚠️ Cet email est déjà attribué à un autre client.');
    EdtEmail.SetFocus;
    Exit;
  end;

  // Si tout est bon, procéder à la mise à jour
  DM.ZqryClient.Close;
  DM.ZqryClient.SQL.Clear;
  DM.ZqryClient.SQL.Add(
    'UPDATE clients ' +
    'SET nom = :nom, prenom = :prenom, email = :email, ville = :ville ' +
    'WHERE id = :id'
  );
  DM.ZqryClient.ParamByName('id').AsInteger := id;
  DM.ZqryClient.ParamByName('nom').AsString := Trim(EdtNom.Text);
  DM.ZqryClient.ParamByName('prenom').AsString := Trim(EdtPrenom.Text);
  DM.ZqryClient.ParamByName('email').AsString := Trim(EdtEmail.Text);
  DM.ZqryClient.ParamByName('ville').AsString := Trim(EdtVille.Text);
  DM.ZqryClient.ExecSQL;

  // Recharger la liste des clients
  DM.ZqryClient.Close;
  DM.ZqryClient.SQL.Clear;
  DM.ZqryClient.SQL.Add('SELECT * FROM clients ORDER BY id');
  DM.ZqryClient.Open;
   DM.ZqryClient.Locate('id',id,[]);

  ShowMessage('✅ Informations mises à jour avec succès.');
end;


procedure TFrmClient.NouveauClick(Sender: TObject);
begin
  EdtNom.Clear;
  EdtPrenom.Clear;
  EdtEmail.Clear;
  EdtAdresse.Clear;
  EdtVille.Clear;
  EdtNom.SetFocus;
end;
//select email from  clients where email  like "prenom2@exemple.com"
procedure TFrmClient.ValiderClick(Sender: TObject);
begin
DM.ZqryClient.SQL.Clear;
DM.ZqryClient.SQL.add('select email from  clients where email  like :email') ;
DM.ZqryClient.ParamByName('email').AsString:=TRIM(EdtEmail.Text);
DM.ZqryClient.open;
if DM.ZqryClient.RecordCount = 1  then
begin
 ShowMessage('Email existe deja');
 EdtEmail.SetFocus;
 exit;
end   ;

DM.ZqryClient.SQL.Clear;
DM.ZqryClient.SQL.Add('insert into clients (nom,prenom,email,ville) values(:nom,:prenom,:email,:ville)');
DM.ZqryClient.ParamByName('nom').AsString:=EdtNom.text;
DM.ZqryClient.ParamByName('prenom').AsString:=Edtprenom.text;
DM.ZqryClient.ParamByName('email').AsString:=EdtEmail.text;
DM.ZqryClient.ParamByName('ville').AsString:=Edtville.text;
DM.ZqryClient.ExecSQL ;
DM.ZqryClient.SQL.Clear;
DM.ZqryClient.SQL.add('select *  from clients');
DM.ZqryClient.Open;

end;

end.

