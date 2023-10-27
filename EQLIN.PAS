{ Lineal Equations }

program EQ_LINEALS (input,output);
const n=9;
var
   A,U,L: array[1..n,1..n] of real;
   B,X,Y: array[1..n] of real;
   k,r,i,j: integer;
   suma1, suma2: real;
   c: char;

begin
                        { Introdueix la matriu A}
for i:=1 to n do        {Matriu A amb tots els elementes =1}
    for j:=1 to n do
        A[i,j]:=1;
for i:=1 to n do begin
    A[i,i]:=10;         {Diagonal de la matriu A}
    B[i]:=1;            {Terme independent B}
end;

writeln('A[i,j]');      {Treu per pantalla la matriu A}
for i:=1 to n do begin
    for j:=1 to n do begin
        write(A[i,j]:3:3,'  ');
    end;
    writeln('');
end;
read(c);                {Espera que es premi RETURN}

for k:=1 to n do begin  {Calcul de la columna k de la matriu L}
    for i:=k to n do begin
        suma1:=0;
        for r:=1 to k-1 do suma1:=suma1+L[i,r]*U[r,k];         {(1)}
        L[i,k]:=A[i,k]-suma1;                                  {(2)}
    end;
    U[k,k]:=1;          {Calcul de la fila k de la matriu U}
    for j:=k+1 to n do begin
        suma2:=0;
        for r:=1 to k-1 do suma2:=suma2+L[k,r]*U[r,j];         {(3)}
        U[k,j]:=(A[k,j]-suma2)/L[k,k];                         {(4)}
    end;
end;

writeln('L[i,j]');      {Treu per pantalla la matriu L}
for i:=1 to n do begin
    for j:=1 to n do begin
            write(L[i,j]:3:3,'  ');
    end;
    writeln('');
end;

writeln('U[i,j]');      {Treu per pantalla la matriu U}
for i:=1 to n do begin
    for j:=1 to n do write(U[i,j]:3:3,'  ');
    writeln('');
end;
read(c);
read(c);


Y[1]:=B[1]/L[1,1];      {Calcul de les Y[i]}                    {(5)}
for i:=2 to n do begin
    suma1:=0;
    for j:=1 to i-1 do suma1:=suma1+L[i,j]*Y[j];                {(6)}
    Y[i]:=(B[i]-suma1)/L[i,i];                                  {(7)}
end;

X[n]:=Y[n]/U[n,n];      {Calcul de les incognites X[i]}         {(8)}
for i:=n-1 downto 1 do begin
    suma1:=0;
    for j:=i+1 to n do suma1:=suma1+U[i,j]*X[j];                {(9)}
        X[i]:=(Y[i]-suma1)*U[i,i];                              {(10)}
    writeln('X[',i,']= ',X[i]);     {Treu per pantalla la incognita i}
end;
read(c);
read(c);

{Algorisme de comprovaci� i calcul del residu
per comprobaci� de la calitat de la soluci�}
for i:=1 to n do begin
    suma2:=0;
    for j:=1 to n do suma2:=suma2+A[i,j]*X[j];                  {(11)}
    write('B[',i,']= ',B[i]:1:0);          {Treu per pantalla el B(i)}
    write(' ~ ',suma2);                    {Treu per pantalla el A�x*}
    writeln('    Residu= ',suma2-B[i]);  {Treu per pantalla el residu}
end;
read(c);
read(c);

end.