unit PricePlan;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ReadingsOperations, DateUtils;

type
  TSupplier = (DrEvilsDarkEnergy, TheGreenEco, PowerForEveryone);

  TSmartMeterToPricePlanAccounts = record
    smartMeterId: String;
    supplier: TSupplier;
  end;

  TCostPerPricePlan = Array of TSmartMeterToPricePlanAccounts;

  TPricePlan = record
    energySupplier: TSupplier;
    unitRate: Double;
  end;

var
   pricePlanInfo: TPricePlan;

procedure InitMapping();

implementation
uses
  ConstData;

procedure InitMapping;
begin

end;

function GetConsumptionCostOfElectricityReadingsForEachPricePlan(smartMeterId: String): TCostPerPricePlan;
begin

end;

function RecommendCheapestPricePlans(smartMeterId: String; limit: Integer): TCostPerPricePlan;
begin

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
   result:= averageReading*timeElapsed*pricePlan.pricePlan;
end;

end.

