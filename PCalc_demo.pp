  PCalc_Demos: array [0..4] of string =
    (
      'begin'+#13#10+
      '  msg(''hello'');'+#13#10+
      '  msg(''hello'', ''world'');'+#13#10+
      '  msg(''hello'', ''world'', 1);'+#13#10+
      '  msg(12 + 3 * 4 / 5);'+#13#10+
      '  $a := input(''input a'', ''any'');'+#13#10+
      '  $b := input(''input b'', ''default'', 5);'+#13#10+
      '  print(''You input: '' + $a + '', '' + $b);'+#13#10+
      'end',

      'begin'+#13#10+
      '  clear;'+#13#10+
      ''+#13#10+
      '  for $i:=1; $i < 5; $i++ do'+#13#10+
      '    print($i);'+#13#10+
      '  next;'+#13#10+
      ''+#13#10+
      '  $a := 0;'+#13#10+
      '  while $a < 5 do'+#13#10+
      '    sleep(1000);'+#13#10+
      '    print(''> ''+ $a);'+#13#10+
      '    $a := $a + 1;'+#13#10+
      '  wend;'+#13#10+
      '  beep;'+#13#10+
      'end',

      'begin'+#13#10+
      '  $x := 2;'+#13#10+
      '  $y := 3;'+#13#10+
      '  print(''x | y = '');'+#13#10+
      '  puts($x | $y);'+#13#10+
      '  print(''x & y = '');'+#13#10+
      '  puts($x & $y);'+#13#10+
      '  print(''x || y = '');'+#13#10+
      '  puts($x || $y);'+#13#10+
      '  print(''x && y = '');'+#13#10+
      '  puts($x && $y);'+#13#10+
      'end',

      'begin'+#13#10+
      '  print(''sin(30*PI/180) = '');'+#13#10+
      '  puts(sin(30*PI/180));'+#13#10+
      '  print(''asin(0.5) = '');'+#13#10+
      '  puts(asin(0.5));'+#13#10+
      '  print(''tan(45*PI/180) = '');'+#13#10+
      '  puts(tan(45*PI/180));'+#13#10+
      '  print(''sqrt(12.3) = '');'+#13#10+
      '  puts(sqrt(12.3));'+#13#10+
      '  print(''log(2) = '');'+#13#10+
      '  puts(log(2));'+#13#10+
      '  print(''2 ^ 32 = '');'+#13#10+
      '  puts(2 ^ 32);'+#13#10+
      'end',

      'begin'+#13#10+
      '  $in := input(''Prime test'',''Input positive number'',20);'+#13#10+
      '  if not isnumber($in) or ($in < 1) then'+#13#10+
      '    msg(''Bad number'',''Error'',$10)'+#13#10+
      '  else'+#13#10+
      '    $n := 1;'+#13#10+
      '    for $a := 2; $a <= $in; $a++ do'+#13#10+
      '      $b := true;'+#13#10+
      '      for $j := 1; $j < $n; $j++ do'+#13#10+
      '        if ($a mod $p[$j]) = 0 then'+#13#10+
      '          $b := false;'+#13#10+
      '  	      $j := $n+1;'+#13#10+
      '        endif;'+#13#10+
      '      next;'+#13#10+
      '      if $b then'+#13#10+
      '        $p[$n] := $a;'+#13#10+
      '        $n++;'+#13#10+
      '      endif;'+#13#10+
      '    next;'+#13#10+
      '    print(''Prime numbers in [2..''+$in+''] are:'');'+#13#10+
      '    for $j:=1; $j<$n; $j++; print(''   ''@$p[$j]) end;'+#13#10+
      '    print(''Found ''+($n-1)+'' primes'');'+#13#10+
      '  endd;'+#13#10+
      'end'

    );

