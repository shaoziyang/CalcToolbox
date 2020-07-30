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
  'print("Hello world.")' + #13#10#13#10 +
  'for i = 1, 5 do' + #13#10 +
  '    print(i)' + #13#10 +
  'end'  
    );

  NewFileTemplate_C: string = (
  '#include <stdio.h>' + #13#10#13#10 +
  'int main(){' + #13#10 +
  '    printf("\n\nHello world.\n");' + #13#10#13#10 +
  '    for(int i = 1; i < 10; i++)' + #13#10 +
  '        printf("%d, ", i);' + #13#10 +
  '}'
    );

  NewFileTemplate_Graph: string = (
  'program newGraph;' + #13#10 +
  'var' + #13#10 +
  '  i:integer;' + #13#10 +
  'begin' + #13#10 +
  '  windows(100,100,600,600);' + #13#10 +
  '  map(-400,-400,400,400);' + #13#10 +
  '  Title(''demo'', True);' + #13#10 +
  '  clean($FFFFFF);' + #13#10 +
  '  home;' + #13#10#13#10 +
  '  color(RandomRange(0,$FFFFFF));' + #13#10 +
  '  for i:=1 to 100 do' + #13#10 +
  '  begin' + #13#10 +
  '    FD(i*5);' + #13#10 +
  '    LT(90);' + #13#10 +
  '    sleep(1);' + #13#10 +
  '  end;' + #13#10 +
  'end.'
    );

