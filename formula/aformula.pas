{ Этот файл был автоматически создан Lazarus. Н�
  � редактировать!
  �сходный код используется только для комп�
    �ляции и установки пакета.
 }

unit aformula; 

interface

uses
  formula, formulaf, formulan, formulanf, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('formula', @formula.Register); 
  RegisterUnit('formulan', @formulan.Register); 
end; 

initialization
  RegisterPackage('aformula', @Register); 
end.
