{ Newton Method }

program NEWTON(input,output);
const n=6;
var
   t,y:array[1..7] of real;
   k:integer;
   x:real;
   FKK1:array[1..6] of real;
   FKK2:array[1..5] of real;
   FKK3:array[1..4] of real;
   FKK4:array[1..3] of real;
   FKK5:array[1..2] of real;
   FKK6:real;
   c: char;

function Poly6(x:real):real;
begin
     Poly6:=y[1]+FKK1[1]*(x-t[1])+FKK2[1]*(x-t[1])*(x-t[2])+
     +FKK3[1]*(x-t[1])*(x-t[2])*(x-t[3])+
     +FKK4[1]*(x-t[1])*(x-t[2])*(x-t[3])*(x-t[4])+
     +FKK5[1]*(x-t[1])*(x-t[2])*(x-t[3])*(x-t[4])*(x-t[5])+
     +FKK6*(x-t[1])*(x-t[2])*(x-t[3])*(x-t[4])*(x-t[5])*(x-t[5]);
end;


begin

t[1]:=-1;          t[2]:=-0.96;         t[3]:=-0.86;
t[4]:=-0.79;        t[5]:=0.22;          t[6]:=0.5;
t[7]:=0.930;

y[1]:=-1;          y[2]:=-0.151;        y[3]:=0.894;
y[4]:=0.986;       y[5]:=0.895;         y[6]:=0.5;
y[7]:=-0.306;

{CALCUL de la f(Xk,Xk+1)}
for k:=1 to 6 do begin
    FKK1[k]:=(y[k+1]-y[k])/(t[k+1]-t[k]);
    writeln('FKK1[',k,']= ',FKK1[k]);
end;
read(c);
read(c);

{CALCUL de les f(Xk,Xk+1,Xk+2)}
for k:=1 to 5 do begin
    FKK2[k]:=(FKK1[k+1]-FKK1[k])/(t[k+2]-t[k]);
    writeln('FKK2[',k,']= ',FKK2[k]);
end;
read(c);
read(c);

{CALCUL de les f(Xk,Xk+1,Xk+2,Xk+3)}
for k:=1 to 4 do begin
    FKK3[k]:=(FKK2[k+1]-FKK2[k])/(t[k+3]-t[k]);
    writeln('FKK3[',k,']= ',FKK3[k]);
end;
read(c);
read(c);

{CALCUL de les f(Xk,Xk+1,Xk+2,Xk+3,Xk+4)}
for k:=1 to 3 do begin
    FKK4[k]:=(FKK3[k+1]-FKK3[k])/(t[k+4]-t[k]);
    writeln('FKK4[',k,']= ',FKK4[k]);
end;
read(c);
read(c);

{CALCUL de les f(Xk,Xk+1,Xk+2,Xk+3,Xk+4,Xk+5)}
for k:=1 to 2 do begin
    FKK5[k]:=(FKK4[k+1]-FKK4[k])/(t[k+5]-t[k]);
    writeln('FKK5[',k,']= ',FKK5[k]);
end;
read(c);
read(c);

{CALCUL de f(Xk,Xk+1,Xk+2,Xk+3,Xk+4,Xk+5,Kk+6)}
FKK6:=(FKK5[2]-FKK5[1])/(t[7]-t[1]);
writeln('FKK6= ',FKK6);

read(c);
read(c);

{Comprobaci�}
writeln('  t    Mesura        Calculat amb polinomi');
for k:=1 to 7 do begin
    if t[k]>0 then write(' ');
    write(t[k]:1:2,'  ');
    if y[k]>0 then write(' ');
    writeln(y[k]:1:3,'   ', Poly6(t[k]));
end;
read(c);
read(c);

writeln('  t   P6(t)');
for k:=-10 to 10 do writeln(k*1E-1:1:1, Poly6(k*1E-1));
read(c);
read(c);

x:=0;
while (x<=1) and (x>=-1) do begin
      writeln('Introdueix un valor de t [-1,1] per calcular P6(t) (t<-1 o t>1 acabar)');
      read(x);
      if (x<=1) and (x>=-1) then writeln('P6(',x:1:3,')= ',Poly6(x));
end;
end.