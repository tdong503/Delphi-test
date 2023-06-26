unit ReadingsOperations;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DateUtils, DateTimePicker;

type

  { TFormReadingsOperations }

  ElectricityReading = class
    time: String;
    reading: Double;
  end;

  TElectricityReadingsArray = Array of ElectricityReading;

  MeterReadings = class
    smartMeterId: string;
    ElectricityReadings: TElectricityReadingsArray;
  end;

  TMeterReadingsArray = Array of MeterReadings;

  TFormReadingsOperations = class(TForm)
    BtnGoToMain: TButton;
    BtnShowReadings: TButton;
    BtnSaveReadings: TButton;
    CboxSmartMetersList: TComboBox;
    dtkReadingDate: TDateTimePicker;
    TxtReading: TEdit;
    SmartMeterId: TLabel;
    Reading: TLabel;
    Date: TLabel;
    MemoReadingsDetails: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure BtnGoToMainClick(Sender: TObject);
    procedure BtnSaveReadingsClick(Sender: TObject);
    procedure BtnShowReadingsClick(Sender: TObject);
    procedure BindDataToComboBox(mReadings: TMeterReadingsArray);
  private

  public

  end;
var
  FormReadingsOperations: TFormReadingsOperations;
  MeterReadingsArray: TMeterReadingsArray;

const
  REC_FILE_NAME = 'Readings.dat';

procedure InitData();
implementation
uses
  Main;

{$R *.lfm}

{ TFormReadingsOperations }

procedure TFormReadingsOperations.BtnGoToMainClick(Sender: TObject);
begin
  Application.CreateForm(TJOIEnergyForm, JOIEnergyForm);
  JOIEnergyForm.Show;
  FormReadingsOperations.Destroy;
end;

procedure WriteData(mReadings: TMeterReadingsArray);
var
  fs: TFileStream;
begin
  fs:= TFileStream.Create('Readings1.dat', fmCreate);
  try
    fs.WriteBuffer(mReadings, SizeOf(mReadings));
  finally
    fs.Free;
  end;
end;

procedure ReadData(var mReadings: TMeterReadingsArray);
var
  fs: TFileStream;
begin
  fs:= TFileStream.Create('Readings1.dat', fmOpenRead or fmShareDenyWrite);
  try
    fs.ReadBuffer(mReadings, SizeOf(mReadings));
  finally
    fs.Free;
  end;
end;

function GenerateReadings(Count: Integer): TElectricityReadingsArray;
var
  ElectricityReadingsArray: TElectricityReadingsArray;
  i: Integer;
begin
  Randomize;
  SetLength(ElectricityReadingsArray, Count);
  for i:= 0 to Count-1 do
  begin
    ElectricityReadingsArray[i]:= ElectricityReading.Create;
    ElectricityReadingsArray[i].reading:= Random(100);
    ElectricityReadingsArray[i].time:= DateToStr(IncDay(Now, -i * 10));
  end;

  result:= ElectricityReadingsArray;
end;

function GenerateMeterReadings(): TMeterReadingsArray;
var
  MeterReadingArray: TMeterReadingsArray;
  i: Integer;
begin
  MeterReadingArray:= TMeterReadingsArray.Create;
  SetLength(MeterReadingArray, 5);
  for i:= 0 to 4 do
  begin
    MeterReadingArray[i]:= MeterReadings.Create();
    MeterReadingArray[i].smartMeterId:='SmertMeterId' + IntToStr(i+1);
    MeterReadingArray[i].ElectricityReadings:=GenerateReadings(20);
  end;

  result:= MeterReadingArray;
end;

procedure TFormReadingsOperations.BindDataToComboBox(mReadings: TMeterReadingsArray);
var
  i:Integer;
begin
  for i:=0 to Length(MeterReadingsArray)-1 do
  begin
     CboxSmartMetersList.Items.AddObject(mReadings[i].smartMeterId, TObject(mReadings[i].smartMeterId));
  end;
end;

procedure InitData();
begin
  MeterReadingsArray:= GenerateMeterReadings();
  WriteData(MeterReadingsArray);
end;

procedure TFormReadingsOperations.FormCreate(Sender: TObject);
begin
  BindDataToComboBox(MeterReadingsArray);
end;

procedure TFormReadingsOperations.BtnSaveReadingsClick(Sender: TObject);
var
  i,
  arrayLength: integer;
begin
  for i:=0 to Length(MeterReadingsArray)-1 do
  begin
    if MeterReadingsArray[i].smartMeterId = CboxSmartMetersList.Text then
    begin
       arrayLength:=Length(MeterReadingsArray[i].ElectricityReadings);
       SetLength(MeterReadingsArray[i].ElectricityReadings, arrayLength+1);
       MeterReadingsArray[i].ElectricityReadings[arrayLength]:= ElectricityReading.Create;
       MeterReadingsArray[i].ElectricityReadings[arrayLength].reading:=StrToFloat(TxtReading.Text);
       MeterReadingsArray[i].ElectricityReadings[arrayLength].time:=DateToStr(dtkReadingDate.DateTime);
    end;
  end;
end;

procedure TFormReadingsOperations.BtnShowReadingsClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  MemoReadingsDetails.Clear;
  ReadData(MeterReadingsArray);
  for i:= Low(MeterReadingsArray) to High(MeterReadingsArray) do
  begin
    for j:= Low(MeterReadingsArray[i].ElectricityReadings) to High(MeterReadingsArray[i].ElectricityReadings) do
    begin
      if j = 0 then
      begin
         MemoReadingsDetails.Append('----------------------');
      end;
      MemoReadingsDetails.Append('SmartMeterId: ' + MeterReadingsArray[i].smartMeterId +
      ' --- Reading: ' + FloatToStr(MeterReadingsArray[i].ElectricityReadings[j].reading) + ' ' + MeterReadingsArray[i].ElectricityReadings[j].time);
    end;
  end;
end;

end.

