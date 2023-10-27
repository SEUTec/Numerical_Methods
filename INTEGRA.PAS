program INTEGRA(input,output);
const a=0;              {[a,b] interval d'integraci¢}
      b=0.5;
      NMAX=600;         {Nombre m xim de subintervala}
      Per=0.5;          {Periode T=1/2}
var
   t,y:array[1..NMAX+1] of real;
   h:real;
   x,i,k:integer;
   int,intex,Irms,Irmsex: real;     {Valor de la integral, valor exacte (amb primitiva)}
   c:char;

function I2(t:real):real;
begin
     I2:=100*exp(-2*t)*sin(2*pi*t)*sin(2*pi*t);         {(1)}{Calcul i^2(t)}
end;

function Primitiva(t:real):real;                        {(2)}
begin
        Primitiva:=-25*exp(-2*t)+100/(4+16*pi*pi)*exp(-2*t)*cos(4*pi*t)-200*pi/(4*16*pi*pi)*exp(-2*t)*sin(4*pi*t);
end;



function trapz(N:integer):real;  {Calcul de la integral per la regla composta}
begin                                       {dels Trapezis amb N subintervals}
h:=(b-a)/N;                                 {Amplada de cada subinterval}

t[1]:=a;
for i:=1 to N do t[i+1]:=t[i]+h;            {Calcul de les abcises}

Int:=0;                                     {Calcul de la integral}
for k:=1 to N do Int:=Int+(I2(t[k])+I2(t[k+1]))*h/2;      {(3)}
trapz:=Int;
end;




function Simpson(N:integer):real;  {Calcul de la integral per la regla }
var suma1,suma2:real;              {composta de Simpson amb N subintervals}
begin                              {Amb la formula de Newton-Cotes tindr¡em}
h:=(b-a)/N;                        {un algorisme identic}

t[1]:=a;
for i:=1 to N do t[i+1]:=t[i]+h;       {Calcul de les abcises}

suma1:=0;
for k:=1 to (N div 2) do suma1:=suma1+I2(t[2*(k-1)+2]);         {(4)}

suma2:=0;
for k:=1 to (N DIV 2)-1 do suma2:=suma2+I2(t[2*(k-1)+3]);       {(5)}

simpson:=(I2(t[1])+4*suma1+2*suma2+I2(t[N+1]))*h/3;             {(6)}
end;



function REGLA38(N:integer):real;  {Calcul de la integral per la Regla 3/8}
var suma1,suma2:real;              {de les fomules de Newton-Cotes}

begin
h:=(b-a)/N;

t[1]:=a;
for i:=1 to N do t[i+1]:=t[i]+h; {Calcul de les abcises}

suma1:=0;
for k:=1 to (N div 3) do suma1:=suma1+I2(t[3*(k-1)+2])+I2(t[3*(k-1)+3]); {(7)}

suma2:=0;
for k:=1 to (N div 3)-1 do suma2:=suma2+I2(t[3*(k-1)+4]);                {(8)}

REGLA38:=(I2(t[1])+3*suma1+2*suma2+I2(t[N+1]))*3*h/8;                    {(9)}
end;



function MILNE(N:integer):real;         {Calcul de la integral per Milne}
var suma1,suma2,suma3:real;             {de les formules de Nenton-Cotes}
begin
h:=(b-a)/N;

t[1]:=a;
for i:=1 to N do t[i+1]:=t[i]+h;

suma1:=0;
for k:=1 to (N div 2) do suma1:=suma1+I2(t[2*(k-1)+2]);         {(10)}

suma2:=0;
for k:=1 to (N div 4) do suma2:=suma2+I2(t[4*(k-1)+3]);         {(11)}

suma3:=0;
for k:=1 to (N div 4)-1 do suma3:=suma3+I2(t[4*(k-1)+5]);       {(12)}

MILNE:=(7*I2(t[1])+7*I2(t[N+1])+32*suma1+12*suma2+14*suma3)*h*4/90;   {(13)}
end;



function WEDDLE(N:integer):real;
var suma1,suma2,suma3,suma4:real;
begin
h:=(b-a)/N;

t[1]:=a;
for i:=1 to N do t[i+1]:=t[i]+h;

suma1:=0;
for k:=1 to (N div 6) do suma1:=suma1+I2(t[6*(k-1)+2])+I2(t[6*(k-1)+6]);  {(14)}

suma2:=0;
for k:=1 to (N div 6) do suma2:=suma2+I2(t[6*(k-1)+3])+I2(t[6*(k-1)+5]);  {(15)}

suma3:=0;
for k:=1 to (N div 6) do suma3:=suma3+I2(t[6*(k-1)+4]);                   {(16)}

suma4:=0;
for k:=1 to (N div 6)-1 do suma4:=suma4+I2(t[6*(k-1)+7]);                 {(17)}

WEDDLE:=(41*I2(t[1])+41*I2(t[N+1])+216*suma1+27*suma2+272*suma3+82*suma4)*h*6/840; {(18)}
end;


{Programa principal}

begin
{Calcul del valor exacte de la integral amb la primitiva}
intex:=primitiva(0.5)-primitiva(0);
Irmsex:=1/Per*sqrt(intex);

writeln('');
writeln('El valor de la integral utilizant una primitiva =',intex);
writeln('El valor de Irms exacte =',Irmsex);
read(c);
read(c);

{Calcul de la integral per a diferent nombre de subintervals per Trapezis}
writeln('Regla composta del Trapezis');
writeln('N      Int(I^2)           E(Int)     Irms            E(Irms)');
for x:=1 to 25 do begin
    Int:=trapz(x*10);
    Irms:=1/Per*sqrt(Int);
    writeln(x*10,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
end;

writeln('');    {Calcul de la integral amb 17 subintervals}
Int:=trapz(17);
Irms:=1/Per*sqrt(Int);
writeln(17,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

Int:=trapz(29);        {Calcul de la integral amb 29 subintervals}
Irms:=1/Per*sqrt(Int);
writeln(29,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

Int:=trapz(NMAX);       {Calcul de la integral amb NMAX subintervals}
Irms:=1/Per*sqrt(Int);
writeln(NMAX,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

writeln('Regla composta dels Trapezis.');
x:=1;
while (x>0) do begin          {Calcul de la integral per a un nombre de subintervals}
      writeln('Introdueix nombre de intervals [1-500] (0 per continuar):');{especificat per l'usuari}
      read(x);
      if (x>0) and (x<=NMAX) then begin
         Int:=trapz(x);
         Irms:=1/Per*sqrt(Int);
         writeln(x,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
      end;
end;

writeln('');
writeln('Simpson');
writeln('N      Int(I^2)           E(Int)     Irms            E(Irms)');
for x:=1 to 30 do begin
    Int:=simpson(x*10);
    Irms:=1/Per*sqrt(Int);
    writeln(x*10,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
end;

Int:=simpson(82);        {Calcul de la integral amb 82 subintervals}
Irms:=1/Per*sqrt(Int);
writeln('');
writeln(82,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

Int:=simpson(NMAX);        {Calcul de la integral amb 500 subintervals}
Irms:=1/Per*sqrt(Int);
writeln(NMAX,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

writeln('');
writeln('Regla composta de Simpson.');
x:=1;
while (x<>0) do begin  {Calcul de la integral per a un nombre de subintervals}
{especificat per l'usuari, sempre que el nombre introduit sigue multiple de 2}
      writeln('Introdueix nombre de intervals (multiple de 2) [1-500] (0 per continuar):');
      read(x);
      if (x>0) and (x<=NMAX) and (x mod 2=0) then begin
         Int:=simpson(x);
         Irms:=1/Per*sqrt(Int);
         writeln(x,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
      end;
end;


{Calcul de la integral amb les fomules de Newton-Cotes}

{REGLA 3/8}

writeln('');
writeln('Regla 3/8');
writeln('N      Int(I^2)           E(Int)     Irms            E(Irms)');
for x:=1 to 34 do begin
    Int:=REGLA38(x*12);
    Irms:=1/Per*sqrt(Int);
    writeln(x*12,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
end;

writeln('');
Int:=REGLA38(78);        {Calcul de la integral amb 78 subintervals}
Irms:=1/Per*sqrt(Int);
writeln(78,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

Int:=REGLA38(NMAX);        {Calcul de la integral amb 500 subintervals}
Irms:=1/Per*sqrt(Int);
writeln(NMAX,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

writeln('');
writeln('Regla 3/8 de les formules de Newton-Cotes.');
x:=1;
while (x<>0) do begin  {Calcul de la integral per a un nombre de subintervals}
{especificat per l'usuari, sempre que el nombre introduit sigue multiple de 3}
      writeln('Introdueix nombre de intervals (multiple de 3) [1-500] (0 per continuar):');
      read(x);
      if (x>0) and (x<=NMAX) and (x mod 3=0) then begin
         Int:=regla38(x);
         Irms:=1/Per*sqrt(Int);
         writeln(x,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
      end;
end;
read(c);
read(c);

writeln('');
writeln('Milne');
writeln('N      Int(I^2)           E(Int)     Irms            E(Irms)');
for x:=1 to 25 do begin
    Int:=MILNE(x*6);
    Irms:=1/Per*sqrt(Int);
    writeln(x*6,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
end;

writeln('');
Int:=MILNE(24);        {Calcul de la integral amb 73 subintervals}
Irms:=1/Per*sqrt(Int);
writeln(24,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

Int:=MILNE(NMAX);        {Calcul de la integral amb 500 subintervals}
Irms:=1/Per*sqrt(Int);
writeln(NMAX,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

writeln('');
writeln('Metode de Milne de les formules de Newton-Cotes.');
x:=1;
while (x<>0) do begin  {Calcul de la integral per a un nombre de subintervals}
{especificat per l'usuari, sempre que el nombre introduit sigue multiple de 4}
      writeln('Introdueix nombre de intervals (multiple de 4) [1-600] (0 per continuar):');
      read(x);
      if (x>0) and (x<=NMAX) and (x mod 4=0) then begin
         Int:=milne(x);
         Irms:=1/Per*sqrt(Int);
         writeln(x,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
      end;
end;
read(c);
read(c);

writeln('Weddle');
writeln('N      Int(I^2)           E(Int)     Irms            E(Irms)');
for x:=1 to 17 do begin
    Int:=WEDDLE(x*6);
    Irms:=1/Per*sqrt(Int);
    writeln(x*6,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
end;

writeln('');
Int:=WEDDLE(24);        {Calcul de la integral amb 73 subintervals}
Irms:=1/Per*sqrt(Int);
writeln(24,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

Int:=WEDDLE(NMAX);        {Calcul de la integral amb 500 subintervals}
Irms:=1/Per*sqrt(Int);
writeln(NMAX,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);

writeln('');
writeln('Metode Weddle de les formules de Newton-Cotes.');
x:=1;
while (x<>0) do begin  {Calcul de la integral per a un nombre de subintervals}
{especificat per l'usuari, sempre que el nombre introduit sigue multiple de 6}
      writeln('Introdueix nombre de intervals (multiple de 6) [1-500] (0 per acabar):');
      read(x);
      if (x>0) and (x<=NMAX) and (x mod 6=0) then begin
         Int:=milne(x);
         Irms:=1/Per*sqrt(Int);
         writeln(x,'  ',Int,'  ',Intex-Int:1,'  ',Irms,'  ',Irmsex-Irms:1);
      end;
end;
read(c);
read(c);

end.