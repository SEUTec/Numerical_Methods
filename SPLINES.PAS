program SPLINES (input,output);
const n=6;      {n es el nombre de subintervals}
var
   Ai,Bi:array[1..n] of real;
   A,U,L:array[1..n-1,1..n-1] of real;
   B,Y:array[1..n-1] of real;
   h:array[1..n] of real;
   M:array[1..n+1] of real;
   t,fx:array[1..7] of real;
   k,r,i,j: integer;
   suma1, suma2, x: real;
   c: char;

function Poly(x:real):real;
begin
     if (t[1]<=x) and (x<t[2]) then i:=1;
     if (t[2]<=x) and (x<t[3]) then i:=2;
     if (t[3]<=x) and (x<t[4]) then i:=3;
     if (t[4]<=x) and (x<t[5]) then i:=4;
     if (t[5]<=x) and (x<t[6]) then i:=5;
     if (t[6]<=x) and (x<=t[7]) then i:=6;
     Poly:=(M[i]/6*((t[i+1]-x)*(t[i+1]-x)*(t[i+1]-x))/h[i])+(M[i+1]/6*((x-t[i])*(x-t[i])*(x-t[i])/h[i]))+Ai[i]*(x-t[i])+Bi[i];
end;

begin
{Introducci¢ de les dades}
t[1]:=-1;          t[2]:=-0.96;         t[3]:=-0.86;
t[4]:=-0.79;        t[5]:=0.22;          t[6]:=0.5;
t[7]:=0.930;

fx[1]:=-1;          fx[2]:=-0.151;        fx[3]:=0.894;
fx[4]:=0.986;       fx[5]:=0.895;         fx[6]:=0.5;
fx[7]:=-0.306;

{Calcul de les h}
for i:=1 to n do begin
    h[i]:=t[i+1]-t[i];
    writeln('h[',i,']= ',h[i]:1:3);
end;
writeln('');

{ Introdueix la matriu A}
for i:=1 to n-1 do
    for j:=1 to n-1 do
        A[i,j]:=0;
for i:=2 to n-1 do A[i-1,i]:=h[i]/(h[i-1]+h[i]);
for i:=2 to n-1 do A[i,i-1]:=h[i]/(h[i]+h[i+1]);
for i:=1 to n-1 do A[i,i]:=2;     {Diagonal de la matriu A}

writeln('A[i,j]');      {Treu per pantalla la matriu A}
for i:=1 to n-1 do begin
    for j:=1 to n-1 do begin
        write(A[i,j]:3:5,'  ');
    end;
    writeln('');
end;
read(c);                {Espera que es premi RETURN}

{Introdueix el terme indepentent B}
for i:=1 to n-1 do begin
    B[i]:=6/(h[i]+h[i+1])*((fx[i+2]-fx[i+1])/h[i+1]-(fx[i+1]-fx[i])/h[i]);
    writeln('B[',i,']= ',B[i]);
end;
read(c);
read(c);

for k:=1 to n-1 do begin  {Calcul de la columna k de la matriu L}
    for i:=k to n-1 do begin
        suma1:=0;
        for r:=1 to k-1 do suma1:=suma1+L[i,r]*U[r,k];         {(1)}
        L[i,k]:=A[i,k]-suma1;                                  {(2)}
    end;
    U[k,k]:=1;          {Calcul de la fila k de la matriu U}
    for j:=k+1 to n-1 do begin
        suma2:=0;
        for r:=1 to k-1 do suma2:=suma2+L[k,r]*U[r,j];         {(3)}
        U[k,j]:=(A[k,j]-suma2)/L[k,k];                         {(4)}
    end;
end;

writeln('L[i,j]');      {Treu per pantalla la matriu L}
for i:=1 to n-1 do begin
    for j:=1 to n-1 do begin
            write(L[i,j]:3:3,'  ');
    end;
    writeln('');
end;

writeln('U[i,j]');      {Treu per pantalla la matriu U}
for i:=1 to n-1 do begin
    for j:=1 to n-1 do write(U[i,j]:3:3,'  ');
    writeln('');
end;
read(c);
read(c);


Y[1]:=B[1]/L[1,1];      {Calcul de les Y[i]}                    {(5)}
for i:=2 to n-1 do begin
    suma1:=0;
    for j:=1 to i-1 do suma1:=suma1+L[i,j]*Y[j];                {(6)}
    Y[i]:=(B[i]-suma1)/L[i,i];                                  {(7)}
end;

M[n+1]:=0;
writeln('M[',n+1,']= ',M[n+1]);
M[n]:=Y[n-1]/U[n-1,n-1];      {Calcul de les incognites M[i]}         {(8)}
writeln('M[',n,']=',M[n]);
for i:=n-2 downto 1 do begin
    suma1:=0;
    for j:=i+1 to n-1 do suma1:=suma1+U[i,j]*M[j+1];                {(9)}
        M[i+1]:=(Y[i]-suma1)*U[i,i];                              {(10)}
    writeln('M[',i+1,']= ',M[i+1]);     {Treu per pantalla la incognita i}
end;
M[1]:=0;
writeln('M[',1,']= ',M[1]);

read(c);
read(c);

{Algorisme de comprovaci¢ i calcul del residu
per comprobaci¢ de la calitat de la soluci¢}
for i:=1 to n-1 do begin
    suma2:=0;
    for j:=1 to n-1 do suma2:=suma2+A[i,j]*M[j+1];                  {(11)}
    write('B[',i,']= ',B[i]:1:5);          {Treu per pantalla el B(i)}
    write(' ~ ',suma2:1:5);                 {Treu per pantalla el Aúx*}
    writeln('    Residu= ',suma2-B[i]);  {Treu per pantalla el residu}
end;
read(c);
read(c);

{Calcul del Bi}
for i:=1 to n do begin
    Bi[i]:=fx[i]-M[i]*h[i]*h[i]/6;
    writeln('Bi[',i,']=',Bi[i]);
end;
read(c);
read(c);

{Calcul del Ai}
for i:=1 to n do begin
    Ai[i]:=((fx[i+1]-fx[i])/h[i])-(h[i]/6*(M[i+1]-M[i]));
    writeln('Ai[',i,']=',Ai[i]);
end;
read(c);
read(c);

{Comprovaci¢}
writeln('  t   Mesura    Calculat amb polinomi');
for k:=1 to 7 do begin
    if t[k]>0 then write(' ');
    write(t[k]:1:2,' ');
    if fx[k]>0 then write(' ');
    writeln(fx[k]:1:3,'   ',Poly(t[k]));
end;
read(c);
read(c);

writeln(' t   Spline(t)');
for k:=-10 to 10 do writeln(k*1E-1:1:1,'  ', Poly(k*1E-1));
read(c);
read(c);

x:=0;
while (x<=1) and (x>=-1) do begin
      writeln('Introdueix un valor de t [-1,1] per calcular Spline(t) (t<-1 o t>1 acabar)');
      read(x);
      if (x<=1) and (x>=-1) then writeln('Spline(',x:1:3,')=',Poly(x));
end;

end.