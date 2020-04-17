const

  NewFileTemplate_PascalScript: string = (
  'program newfile;' + #13#10 +
  'var' + #13#10 +
  '  i: integer;' + #13#10#13#10 +
  '  procedure f1;' + #13#10 +
  '  begin' + #13#10#13#10 +
  '  end;' + #13#10#13#10 +
  'begin' + #13#10 +
  '  print([''a '', 1+2 * 3.4 / 5, '' Hello''#13#10])' + #13#10 +
  'end.'
    );

  NewFileTemplate_MPY: string = (
  'import time' + #13#10 +
  'for i in range(10):' + #13#10 +
  '    print(i)' + #13#10 +
  '    time.sleep_ms(100)'
    );

  NewFileTemplate_Calc: string = (
  'function f1(x:double):double;' + #13#10 +
  'begin' + #13#10 +
  '  result := x * x + 1;' + #13#10 +
  'end;' + #13#10#13#10
    );

  NewFileTemplate_Lua: string = (
  'print("Hello word.")' + #13#10#13#10 +
  'for i = 1, 5 do' + #13#10 +
  '    print(i)' + #13#10 +
  'end'  
    );
