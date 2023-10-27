{ Lineal Equations 2 }

program EQ_LINEALS (input,output);
const n=3;
var
   A,A1,A2: array[1..n,1..n,1..n] of real;
   L,U:array[1..n,1..n] of real;
   B: array[1..n,1..n] of real;
   X,Y:array[1..n] of real;
   mat,k,r,i,j: integer;
   suma1, suma2: real;
   c: char;

begin

{Matriu A1}
A[1,1,1]:=2;       A[1,1,2]:=3;      A[1,1,3]:=-1;
A[1,2,1]:=1;       A[1,2,2]:=-1;     A[1,2,3]:=3;
A[1,3,1]:=0;       A[1,3,2]:=1;      A[1,3,3]:=-1;
{Terme independent de A1}
B[1,1]:=4;         B[1,2]:=-4;       B[1,3]:=2;

{Matriu A2}
A[2,1,1]:=2;       A[2,1,2]:=-2;      A[2,1,3]:=5;
A[2,2,1]:=2;       A[2,2,2]:=3;     A[2,2,3]:=4;
A[2,3,1]:=3;       A[2,3,2]:=-1;      A[2,3,3]:=3;
{Terme independent de A2}
B[2,1]:=13;         B[2,2]:=20;       B[2,3]:=10;

{Matriu A3}
A[3,1,1]:=1;       A[3,1,2]:=-1;      A[3,1,3]:=1;
A[3,2,1]:=-1;       A[3,2,2]:=5;     A[3,2,3]:=1;
A[3,3,1]:=1;       A[3,3,2]:=1;      A[3,3,3]:=3;
{Terme independent de A3}
B[3,1]:=1;         B[3,2]:=1;       B[3,3]:=0;

for mat:=1 to 3 do begin
    writeln('A',mat,'[i,j]');   {Treu per pantalla la matriu A(mat)}
    for i:=1 to n do begin
        for j:=1 to n do write(A[mat,i,j]:3:3,'  ');
        writeln('');
    end;
    read(c);                    {Espera que es premi RETURN}

    for k:=1 to n do begin      {Calcul de la columna k de la matriu L}
        for i:=k to n do begin
            suma1:=0;
            for r:=1 to k-1 do suma1:=suma1+L[i,r]*U[r,k];      {(1)}
            L[i,k]:=A[mat,i,k]-suma1;                           {(2)}
        end;
        U[k,k]:=1;      {Calcul de la fila k de la matriu U}
        for j:=k+1 to n do begin
            suma2:=0;
            for r:=1 to k-1 do suma2:=suma2+L[k,r]*U[r,j];      {(3)}
            U[k,j]:=(A[mat,k,j]-suma2)/L[k,k];                  {(4)}
        end;
    end;

    writeln('L[i,j]');  {Treu per pantalla la matriu L}
    for i:=1 to n do begin
        for j:=1 to n do write(L[i,j]:3:3,'  ');
        writeln('');
    end;

    writeln('U[i,j]');  {Treu per panatalla la matriu U}
    for i:=1 to n do begin
        for j:=1 to n do write(U[i,j]:3:3,'  ');
        writeln('');
    end;
    read(c);
    read(c);

    Y[1]:=B[mat,1]/L[1,1];      {Calcul de les Y[i]}            {(5)}
    writeln('Y[',1,']= ',Y[1]);
    for i:=2 to n do begin
        suma1:=0;
        for j:=1 to i-1 do suma1:=suma1+L[i,j]*Y[j];            {(6)}
        Y[i]:=(B[mat,i]-suma1)/L[i,i];                          {(7)}
    end;

    X[n]:=Y[n]/U[n,n];  {Calcul de les incognites X[i]}         {(8)}
    writeln('X[',n,']= ',X[n]);
    for i:=n-1 downto 1 do begin
        suma1:=0;
        for j:=i+1 to n do suma1:=suma1+U[i,j]*X[j];            {(9)}
        X[i]:=(Y[i]-suma1)/U[i,i];                              {(10)}
        writeln('X[',i,']= ',X[i]); {Treu per pantalla la incognita i}
    end;
    read(c);
    read(c);

{Algorisme de comprovaci� i calcul del residu
per comprobaci� de la calitat de la soluci�}
    for i:=1 to n do begin
        suma2:=0;
        for j:=1 to n do suma2:=suma2+A[mat,i,j]*X[j];                 {(11)}
        write('B[',i,']= ',B[mat,i]:1:0);         {Treu per pantalla el B(i)}
        write(' ~ ',suma2);                       {Treu per pantalla el A�x*}
        writeln('    Residu= ',suma2-B[mat,i]); {Treu per pantalla el residu}
    end;
    read(c);
    read(c);
end;
end.