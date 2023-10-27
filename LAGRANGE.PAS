{ Lagrange Method }

program LAGRANGE(input,output);

var
   t,y:array[1..7] of real;
   x:real;
   k:integer;
   c:char;

function PLagrange(x:real):real;
var
   sum,sud:real;
   i,k:integer;

begin
     sum:=0;
     for k:=1 to 7 do begin
         sud:=y[k];
         for i:=1 to 7 do if i<>k then sud:=sud*(x-t[i])/(t[k]-t[i]);
         sum:=sum+sud;
     end;
     PLagrange:=sum;
end;

begin
t[1]:=-1;          t[2]:=-0.96;         t[3]:=-0.86;
t[4]:=-0.79;        t[5]:=0.22;          t[6]:=0.5;
t[7]:=0.930;

y[1]:=-1;          y[2]:=-0.151;        y[3]:=0.894;
y[4]:=0.986;       y[5]:=0.895;         y[6]:=0.5;
y[7]:=-0.306;

{Comprovaci�}
writeln(' t  Mesura   Calcul amb polinomi de Lagrange.');
for k:=1 to 7 do begin
    if t[k]>0 then write(' ');
    write(t[k]:1:2,' ');
    if y[k]>0 then write(' ');
    writeln(y[k]:1:3,'   ',PLagrange(t[k]));
end;
read(c);
read(c);

writeln(' t   PLagrange(t)');
for k:=-10 to 10 do writeln(k*0.1:1:1,'  ',PLagrange(k*0.1));
read(c);
read(c);

x:=0;
while (x<=1) and (x>=-1) do begin
      writeln('Introdueix un valor de t [-1,1] per calcular PLagrange(t) (t<-1 o t>1 acabar)');
      read(x);
      if (x<=1) and (x>=-1) then writeln('PLagrange(',x,')= ',PLagrange(x));
end;
end.