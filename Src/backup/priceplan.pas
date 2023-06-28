unit PricePlan;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ReadingsOperations, DateUtils, TypInfo;

type
  TSupplier = (DrEvilsDarkEnergy, TheGreenEco, PowerForEveryone);

  TSmartMeterToPricePlanAccounts = record
    smartMeterId: String;
    supplier: string;
  end;

  TSupplierToCost = record
    supplier: string;
    cost: Double;
  end;

  TCostPerPricePlan = Array of TSmartMeterToPricePlanAccounts;

  TPricePlan = class
    energySupplier: string;
    unitRate: Double;
  end;

  TPricePlanArray = Array[0..2] of TPricePlan;

var
   pricePlanArrayInfo: TPricePlanArray;

procedure InitMapping();

implementation
uses
  ConstData;

procedure InitMapping;
var
   i: Integer;
begin
  for i:= 0 to SizeOf(pricePlanArrayInfo) do
  begin
     pricePlanArrayInfo[i]:= TPricePlan.Create();
     pricePlanArrayInfo[i].energySupplier:=GetEnumName(TypeInfo(TSupplier), i);
     pricePlanArrayInfo[i].unitRate:=(i+1)*(i+2);
  end;
end;

function GetConsumptionCostOfElectricityReadingsForEachPricePlan(smartMeterId: String): TSupplierToCost;
var
   pricePlanArrayInfo1: TPricePlanArray;
begin
   // get readings by smartMeterId
   pricePlanArrayInfo1:=pricePlanArrayInfo;
   // cycle price plan

   // return
end;

function RecommendCheapestPricePlans(smartMeterId: String; limit: Integer): TSupplierToCost;
begin
   // get readings by smartMeterId

   // cycle price plan

   // return limit
end;

function CalculateAverageReading(electricityReadingsArray: TElectricityReadingsArray): Double;
var
  sum: Double;
  i: Integer;
begin
   sum:= 0;
   for i:=0 to Length(electricityReadingsArray) do
   begin
     sum:= sum + electricityReadingsArray[i].reading;
   end;

   result:=sum / Length(electricityReadingsArray);
end;

function CalculateTimeElapsed(electricityReadingsArray: TElectricityReadingsArray): Double;
var
   nh,oh: Tdatetime;
   arrayLength: Integer;
begin
   arrayLength:= Length(electricityReadingsArray);
   oh:=strtodatetime(electricityReadingsArray[arrayLength-1].time);
   nh:=strtodatetime(electricityReadingsArray[0].time);

   result:= hourspan(nh,oh);
end;

function CalculateCost(electricityReadingsArray: TElectricityReadingsArray; pricePlan: TPricePlan): Double;
var
   averageReading, timeElapsed: Double;
begin
   averageReading:=CalculateAverageReading(electricityReadingsArray);
   timeElapsed:=CalculateTimeElapsed(electricityReadingsArray);
   result:= averageReading*timeElapsed*pricePlan.unitRate;
end;

end.

