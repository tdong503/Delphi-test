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
    CboxSmartMetersList: TComboBox;
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
  ReadingsOperations, PricePlan, ConstData;

{$R *.lfm}

{ TJOIEnergyForm }

procedure TJOIEnergyForm.FormCreate(Sender: TObject);
var
i:Integer;
begin
  ReadingsOperations.InitData();
  PricePlan.InitMapping();

  for i:=0 to Length(ConstData.SmartMeterIds)-1 do
  begin
     CboxSmartMetersList.Items.AddObject(ConstData.SmartMeterIds[i], TObject(ConstData.SmartMeterIds[i]));
  end;
end;

procedure TJOIEnergyForm.BtnCompareAllClick(Sender: TObject);
var
  supplierToCost : TSupplierToCost;
begin
  supplierToCost:= PricePlan.GetConsumptionCostOfElectricityReadingsForEachPricePlan(CboxSmartMetersList.Text);

  // display in memo
end;

procedure TJOIEnergyForm.BtnRecomandClick(Sender: TObject);
var
  supplierToCost : TSupplierToCost;
begin
  supplierToCost:= PricePlan.RecommendCheapestPricePlans(CboxSmartMetersList.Text, StrToInt(TxtRecomandCount.Text));

  // display in memo
end;

procedure TJOIEnergyForm.BtnGoToReadingsClick(Sender: TObject);
begin
  Application.CreateForm(TFormReadingsOperations, FormReadingsOperations);
  FormReadingsOperations.Show;
  JOIEnergyForm.Destroy;
end;

end.

