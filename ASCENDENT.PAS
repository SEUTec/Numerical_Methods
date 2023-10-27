{ PRG1 Ascendent }

program ASCENDENT(input, output);
var
   n:integer;
   I:array[0..13] of real;
   a:char;

begin
     I[0]:=0.047947;
     I[1]:=0.021889;
     writeln('Programa 1 Practica 1 Metodes numerics');
     writeln('');
     writeln('n           In');
     writeln('0  ',I[0]);
     writeln('1  ',I[1]);
     for n:=2 to 10 do begin
         I[n]:=1/(n-1) - (10*I[n-1]) - (16*I[n-2]);
         write(n,'  ');
         writeln(I[n]);
     end;
     read(a);
end.