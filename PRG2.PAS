program DESCENDENT(input, output);
var
   n:integer;
   I:array[0..13] of real;
   a:char;

begin
     I[13]:=0.0026455026;
     I[12]:=0.0029889044;
     writeln('Programa 2 Practica 1 Metodes numerics');
     writeln('');
     writeln('n           In');
     writeln('12',I[12]);
     for n:=11 downto 0 do begin
         I[n]:=(1/(n+1) - I[n+2] - 10*I[n+1])/16;
         writeln(n, I[n]);
     end;
     read(a);
end.