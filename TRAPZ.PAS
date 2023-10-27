program LAGRANGE(input,output);
const a=0;              {[a,b] interval d'integraci¢}
      b=0.5;
      NMAX=500;             {Nombre de subintervals N>270 resultats iguals}
      Per=0.5;          {Periode T=1/2}
var
   t,y:array[1..NMAX+1] of real;
   h:real;
   x,i,k:integer;
   int: real;
   c:char;

function I2(t:real):real;
begin
        I2:=100*exp(-t)*exp(-t)*sin(2*pi*t)*sin(2*pi*t);             {Calcul i^2(t)}
end;

function Integra(N:integer):real;
begin
h:=(b-a)/N;         {Amplada de cada subinterval}

t[1]:=a;
for i:=1 to N+1 do
    t[i+1]:=t[1]+i*h;       {Calcul de les abcises}
for i:=1 to N+1 do
    y[i]:=I2(t[i]);

{Calcul de la integral}
Int:=0;
for k:=1 to N do begin
    Int:=Int+(I2(t[k])+I2(t[k+1]))*h/2;
end;
Integra:=Int;
end;

begin
writeln('N      Int(I^2)           Irms');
for x:=1 to 20 do begin
    Int:=Integra(x*20);
    writeln(x*20,'  ',Int,'  ',1/Per*sqrt(Int));
end;
Integra(30);
Int:=Integra(30);
writeln('');
writeln(30,'  ',Int,'  ',1/Per*sqrt(Int));
Integra(500);
Int:=Integra(500);
writeln('');
writeln(500,'  ',Int,'  ',1/Per*sqrt(Int));
read(c);
read(c);
end.