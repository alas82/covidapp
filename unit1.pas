unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  fphttpclient, jsonparser, fpjson, Classes;
var
  s: string;
  g: TJSONArray;
  cases,death,recovered :real;
  gitem: TJSONObject;
  j:TJSONData;
  parser: TJSONParser;



type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.Button1Click(Sender: TObject);
begin
   With TFPHttpClient.Create(Nil) do
    try
        S:=Get('https://coronavirus-19-api.herokuapp.com/countries/' + ComboBox1.text);
    finally
      Free;
    end;
    J:= getjson(S);
    if Not (j.FindPath('cases').IsNull) then
       Label1.Caption:=formatfloat(',#',j.FindPath('cases').AsFloat);
    if Not (j.FindPath('recovered').IsNull) then
    Label2.Caption:=formatfloat(',#',j.FindPath('recovered').AsFloat);
    if Not (j.FindPath('deaths').IsNull) then
    Label3.Caption:=formatfloat(',#',j.FindPath('deaths').AsFloat);
    end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  Button1Click(self.ComboBox1);
end;





procedure TForm1.FormCreate(Sender: TObject);
var
  i1: Integer;
  object_name: String;
begin
      With TFPHttpClient.Create(Nil) do
        try
           ComboBox1.Items.BeginUpdate;
           try
              ComboBox1.Items.Clear;
               s:=Get('https://coronavirus-19-api.herokuapp.com/countries');
                g:= TJSONArray(GetJSON(s));
                for i1:=0  to g.Count-1 do
                begin

                gitem:=g.Objects[i1];
                 object_name:= gitem['country'].AsString;
                ComboBox1.Items.add(object_name);

                end;

           finally;
             ComboBox1.Items.EndUpdate;
           end;

      finally
      j.Free;
   end;
     ComboBox1.ItemIndex:=0;
    Button1Click(Self.ComboBox1);
end;

end.

