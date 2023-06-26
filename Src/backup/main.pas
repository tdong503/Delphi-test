unit Main;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TJOIEnergyForm }

  TJOIEnergyForm = class(TForm)
    BtnGoToReadings: TButton;
    BtnRecomand: TButton;
    BtnCompareAll: TButton;
    TxtRecomandCount: TEdit;
    MemoReadingsInfo: TMemo;
    procedure BtnCompareAllClick(Sender: TObject);
    procedure BtnRecomandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnGoToReadingsClick(Sender: TObject);
  private

  public

  end;

var
  JOIEnergyForm: TJOIEnergyForm;

implementation
uses
  ReadingsOperations, PricePlan;

{$R *.lfm}

{ TJOIEnergyForm }

procedure TJOIEnergyForm.FormCreate(Sender: TObject);
begin
  ReadingsOperations.InitData();
  PricePlan.InitMapping();
end;

procedure TJOIEnergyForm.BtnCompareAllClick(Sender: TObject);
begin

end;

procedure TJOIEnergyForm.BtnRecomandClick(Sender: TObject);
begin

end;

procedure TJOIEnergyForm.BtnGoToReadingsClick(Sender: TObject);
begin
  Application.CreateForm(TFormReadingsOperations, FormReadingsOperations);
  FormReadingsOperations.Show;
  JOIEnergyForm.Destroy;
end;

end.

