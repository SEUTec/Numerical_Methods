program PRACTICA(input, output);
type  Fitxa=record                              {Estructura per guardar les dades}
                                                {corresponents a cada kil•metre  }
                                                {del recorregut}
	altura: integer;                        {Un enter per l'altura}
	etiqueta: array[1..15] of char;         {Un array de 15 caracters per la etiqueta}
	Inici,Final,Perill,Bar,Benzina,Aigua: boolean;
                                                {Un boolea per cada una de les incidencies}
end;
type  ArrayFitx=array[1..99] of Fitxa;
                             {Array per enmagatzemar les dades de tot el recorregut}
var
	opcio,res: char;        {Variable de selecci¢ del menu principal}
              {Variable auxiliar utilitzada per vuidar el bauffer de teclat}
	Dades: ArrayFitx;       {Dades del recorregut}



procedure LLEGIRTEXT;           {Procediment per lectura de fitxers de text}
var
	fitxer:TEXT;
        Nomfitxer:string[10];   {Turbo Pascal}
{	Nomfitxer:packed array[1..10] of char;}
	car: char;
	kmant,km: integer;         {Kil•metre anterior}
	dif: integer;           {diferŠncia entre kil•metres}
	inc: real;
	Incidencia: array[1..8] of char;
	i,j: integer;
	FiLlegir: boolean;      {Variable per controla la finalitzaci¢ de la lectura del fitxer}

begin
	FiLlegir:=FALSE;

	writeln(' ');
	writeln('Introdueix nom del fitxer:');

        read(res);
	readln(Nomfitxer);
	writeln('Obrint fitxer: ', Nomfitxer);

        {Obrir fitxer per lectura}
        assign(fitxer,Nomfitxer);  {Turbo Pascal}
        reset(fitxer);
{	reset(fitxer, Nomfitxer);  {Pascal Standard}

	while not eof(fitxer) AND not FiLlegir do begin
		kmant:=km;
		km:=0;
		if not eoln(fitxer) then begin
			i:=0;
			read(fitxer,car);       {Llegeix un caracter del fitxer}
			repeat

{Llegeix els primers}          	if(car>='0') AND (car<='9') then begin
{caracters del fitxer}			km:=km * 10;
{corresponents al km}			km:=km + ORD(car) - ORD('0');
{i els converteix a enter}	end

{Si llegeix un caracter que}	else begin
{no ‚s un digit indica error}		writeln('');
{de lectura i activa la}		writeln(' *  ERROR EN LECTURA DE KILOMETRES * ');
{variable FiLlegir per}					writeln('');
{aturar la lectura del fitxer}	FiLlegir:=TRUE;
				end;

				i:=i+1;
				read(fitxer, car);
			until (car='*') OR eoln(fitxer) OR eof(fitxer) OR FiLlegir;
			write(Km);      {Treu per pantalla el valor llegit}
			write(' ');
			read(fitxer, car);

{Si el valor llegit}	if (km>99) OR (car='*') AND not FiLlegir then begin
{per km ‚s superior}	writeln(' ');
{al valor m…xim (99)}	writeln(' * ERROR EN LA LECTURA DE KILOMETRES *');
{indica error i fi-}	writeln(' Aquest programa esta limitat a 99 km.');
{nalitza la lectura}	writeln(' ');
				FiLlegir:=TRUE;
			end
			else begin
				Dades[km].altura:=0;
				repeat
{Llegeix els caracters}			if(car>='0') AND (car<='9') then begin
{corresponents a la altura}             	Dades[km].altura:=Dades[km].altura*10;
{i els converteix a enter}			Dades[km].altura:=Dades[km].altura + ORD(car) - ORD('0');
					end
{Si llegeix un caracter que}		else begin
{no ‚s digit indica error i}			writeln('');
{finalitza la lectura}	  	                writeln(' * ERROR EN LA LECTURA DE LA ALTURA * ');
						writeln('');
						FiLlegir:=TRUE;
					end;
					read(fitxer,car);
				until (car='*') OR eoln(fitxer) OR eof(fitxer) OR (i=4);
				write(' ');

{Si el valir llegit ‚s}		if(Dades[km].altura > 9999) then begin
{m‚s gran que el m…xim}			writeln(' ');
{indica error i finalitza}		writeln(' * ERROR EN LA LECTURA DE LA ALTURA * ');
{la lectura}				writeln(' La altura maxima es de 9999');
					writeln(' ');
					FiLlegir:=TRUE;
				end

{Si no hi ha error}	else if (not eoln(fitxer)) then begin
{continua llegint}	       read(fitxer, car);

{Si despr‚s de l'altura no es}	       if (car<>'*') then begin
{troba un altre * llegeix}         	        Dades[km].etiqueta[1]:=car;
{etiquera caracter a caracter}		        i:=1;
						repeat
							i:=i+1;
							read(fitxer,car);
							Dades[km].etiqueta[i]:=car;
						until (car='*') OR eof(fitxer) OR eoln(fitxer) OR (i=15);
						if(Dades[km].etiqueta[i]='*') then Dades[km].etiqueta[i]:=' ';
{Treu per pantalla l'etiqueta}		        for i:=1 to 15 do write(Dades[km].etiqueta[i]);
{llegida caracter a caracter}		end;
				end;
				if not eoln(fitxer) and not eof(fitxer) then begin
					i:=1;

{Inici del bucle per llegir incidŠncies}repeat
{inicialitza l'array incidŠncia}                for j:=1 to 8 do incidencia[j]:=' ';
                                                j:=1;

{Lectura dels caracter corresponents}		repeat
{a una incidŠncia}                              	read(fitxer,car);
							incidencia[j]:=car;
							j:=j+1;
						until (car='*') OR eoln(fitxer) OR eof(fitxer) OR (j=8);

						if (incidencia[j-1]='*') then incidencia[j-1]:=' ';

{Si els caracters llegits}			if (incidencia[1]='I') AND (incidencia[2]='N')
{corresponen amb I,N,I,C,I}			AND (incidencia[3]='I') AND (incidencia[4]='C')
{activa el boolea que indica}			AND (incidencia[5]='I') AND (incidencia[6]=' ') then begin
{que el km actual ‚s INICI}                     	Dades[km].Inici:=TRUE;
							write(' Inici');
						end

{Si els caracters llegits}			else if(incidencia[1]='F') AND (incidencia[2]='I')
{corresponen amb F,I,N,A,L}			AND (incidencia[3]='N') AND (incidencia[4]='A')
{activa el boolea que indica}			AND (incidencia[5]='L') AND (incidencia[6]=' ') then begin
{que el km actual ‚s FINAL}			Dades[km].final:=TRUE;
							write(' Final');
						end

{Si els caracters llegits}			else if (incidencia[1]='P') AND (incidencia[2]='E')
{corresponen amb P,E,R,I,L,L}			AND (incidencia[3]='R') AND (incidencia[4]='I')
{activa el boolea que indica}			AND (incidencia[5]='L') AND (incidencia[6]='L')
{que al km actual hi ha PERILL}			AND (incidencia[7]=' ') then begin
							Dades[km].perill:=TRUE;
							write(' Perill');
						end

{Si els caracters llegits}			else if (incidencia[1]='B') AND (incidencia[2]='A')
{corresponen amb B,A,R}				AND(incidencia[3]='R') AND (incidencia[4]=' ') then begin
{activa el boolea que indica}                   	Dades[km].bar:=TRUE;
{que al km actual hi ha BAR}				write(' Bar');
						end

{Si els caracters llegits}			else if (incidencia[1]='B') AND (incidencia[2]='E')
{corresponen amb B,E,N,Z,I,N,A}			AND (incidencia[3]='N') AND (incidencia[4]='Z')
{activa el boolea que indica}			AND (incidencia[5]='I') AND (incidencia[6]='N')
{que al km actual hi ha BENZINA}		AND (incidencia[7]='A') AND (incidencia[8]=' ') then begin
							Dades[km].benzina:=TRUE;
							write(' Benzina');
						end

{Si els caracters llegits}			else if (incidencia[1]='A') AND (incidencia[2]='I')
{corresponen amb A,I,G,U,A}			AND (incidencia[3]='G') AND (incidencia[4]='U')
{activa el boolea que indica}			AND (incidencia[5]='A') AND (incidencia[6]=' ') then begin
{que al km actual hi ha AIGUA}			Dades[km].aigua:=TRUE;
							write(' Aigua');
						end

{Si la incidŠncia llegida}			else begin
{no correspon amb cap de}				writeln('');
{les reconegudes treu per}				writeln(' * ERROR EN LES DADES DEL FITXER *');
{pantalla el missatge d'error}				writeln(' * INICIDENCIA NO DEFINIDA *');
{i finalitza la lectura}				writeln('');
							FiLlegir:=TRUE;
						end;

{Acaba de llegir incidŠncies si}						i:=i+1;
{s'han llegir les 8 si s'acaba}			until eoln(fitxer) OR eof(fitxer) OR (i=7);
{el fitxer o la lines}			readln(fitxer);
					writeln(' ');
				end
				else begin
					readln(fitxer);
					writeln(' ');
				end;


{Si el km llegit anterior-}	if (kmant<>(km-1)) AND (km>1) then begin
{ment no ‚s l'inmediatament}    	dif:=km - kmant;
{enterior al km actual, hi}	        inc:=(Dades[km].altura - Dades[kmant].altura) / dif;
{ha que calcular la altura}			for i:=1 to dif-1 do begin
{del km intermitjos}						Dades[kmant+i].altura:=trunc(Dades[kmant].altura + (inc * i));
						for j:=1 to 15 do Dades[kmant+i].etiqueta[j]:=' ';
					end;
				end;


			end;
		end;
	end;
	if eof(fitxer) then Dades[1].final:=FALSE; {Si hi ha dades la fitxer desactiva}
	close(fitxer);                             {l'indicador de final de recorregut}
end;                                               {del km 1}



procedure SALVAR;                   {Procediment encarregar de guardar}
                                    {la variable Dades, en un fitxer binari}
var
	fitxer: file of Fitxa;
	i: integer;
        Nomfitxer:string[10];   {Turbo Pascal}
{	Nomfitxer:packed array[1..10] of char; {Pascal Standard}

begin
	writeln('');
	writeln('*GUARDAR FITXER BINARI*');
	write('Introdueix nom del fitxer a guardar: ');
	readln(Nomfitxer);
	writeln('Guardant dades al fitxer ', Nomfitxer);
	writeln('');

        assign(fitxer, Nomfitxer);       {Turbo Pascal}
        rewrite(fitxer);
{	rewrite(fitxer, Nomfitxer); {Pascal Standard}

	for i:=1 to 99 do write(fitxer, Dades[i]); {Escriu les dades de cada km al fitxer}
	close(fitxer);
	writeln('Fitxer guardat');
	writeln('');
end;



procedure  LLEGIREG;            {Procediment encarregar de llegir fitxers}
                                {binaris colúlocant les dades a la mem•ria}
var
	fitxer:file of Fitxa;
	i: integer;
        Nomfitxer:string[10];   {Turbo Pascal}
{	Nomfitxer:packed array[1..10] of char;  {Pascal Standard}

begin
	writeln('');
	writeln('* LLEGIR FITXER BINARI *');
	write('Introdueix nom del fitxer a llegir: ');
        read(res);
	readln(Nomfitxer);
	write('Llegint dades del fitxer ', Nomfitxer);
	writeln('');

        assign(fitxer,Nomfitxer);       {Turbo Pascal}
        reset(fitxer);
{	reset(fitxer, Nomfitxer); {Pascal Standard}

	i:=1;
	while not eof(fitxer) AND (i<100) do begin      {Llegix fins que finalitza}
		read(fitxer, Dades[i]);                 {el fitxer a fins que s'han}
		i:=i+1;                                 {llegit 99 registres}
	end;
	close(fitxer);
	writeln('');
end;


procedure ESTADIS;      {Procediment de calcul i presentaci¢ de dades estad¡stiques}
var
	altmax, altmin, de
        snivell, km: integer;
begin
	altmax:=0;
	desnivell:=0;
	altmin:=9999;
	km:=0;


	repeat  {bucle que recorre l'array Dades buscant l'altura
                m…xima, m¡nima i calculant el desnivell}
		km:=km+1;
		if(altmin > Dades[km].altura) then altmin:=Dades[km].altura;
		if(altmax < Dades[km].altura) then altmax:=Dades[km].altura;
		if (km<98) then
			if(Dades[km].altura < Dades[km+1].altura) AND (km<99) then
				desnivell:=desnivell - Dades[km].altura + Dades[km+1].altura;
	until (km=99) OR Dades[km].final;

	writeln('');
	writeln('Altura maxima:', altmax:5);
	writeln('Altura minima:', altmin:5);
	writeln('Desnivell:', desnivell:5);
	writeln('kilometres:', km:5);
	writeln('');
end;


procedure TREULLISTA(pagina:integer);   {Aquest procediment treu per patalla
                                        una llista amb les dades corresponents
                                        als 15 kil•metres de la p…gina indicada
                                        o fins que troba l'£ltim kil•metre del
                                        recorregut}
var
	nsimbols, valsimbol: real;      {nombre simbols i valor del simbol}
    	i,j, altmax, altmin, primer, ultim: integer;

begin
	primer:=15*pagina;
	altmax:=0;
	altmin:=9999;
	i:=primer;

	repeat          {bucle que recorre la llista buscant l'altura
                        m…xima, m¡nima}
		i:=i+1;
		if(altmin > Dades[i].altura) then altmin:=Dades[i].altura;
		if(altmax < Dades[i].altura) then altmax:=Dades[i].altura;
	until (i=primer+15) OR Dades[i].final;

	ultim:=i;      {£ltim km a presentar en pantalla}
	valsimbol:=0;
	if(altmin<>altmax) then valsimbol:=46/(altmax-altmin);
	i:=primer;
	repeat
		i:=i+1;
		write(i:3);
		write(' ');

		for j:=1 to 15 do write(Dades[i].etiqueta[j]); {Treu per pantalla l'etiqueta
                                                               corresponent al km i caracter a caracter}
		nsimbols:=(Dades[i].altura - altmin) * valsimbol;  {Calcul del nombre * a escriure en pantalla}
		for j:=0 to round(nsimbols) do write('*');         {Escriu en patalla el simbols *}
		for j:=j to 46 do write(' ');                      {La resta l'espais els escriu en blanc}

		if(Dades[i].inici) then write('INICI');            {Escriu les incidencies corresponents}
		if(Dades[i].final) then write('FINAL');
		if(Dades[i].perill) then write('!!!');
		if(Dades[i].bar) then write(':-)');
		if(Dades[i].benzina) then write('$');
		if(Dades[i].aigua) then write('%');
		writeln('');

	until (i=primer+15) OR (i=ultim);

	writeln('');                     {Treu per pantalla el rang de la p…gina actual}
	write('Escala de ', altmin:5);
	write(' a ', altmax:5);
	writeln(' metres.');

	write('Cada * representa ', valsimbol:5:1);  {Indica el valor de cada * amb 5 xifres i un decimal}
	writeln(' metres.');
	writeln('');
end;


procedure RECORRE;      {Procediment que presenta el recorregut per pantalla}
var
	opcio: char;
	pagina,pagines,ultim:integer;

begin
	ultim:=0;
	repeat          {Buqueda de l'ultim km i calcul de les pragines
                        necessaries per representar tot el recorregut}
		ultim:=ultim+1;
	until Dades[ultim].final OR (ultim=99);
	pagines:=ultim DIV 15;
	if ((ultim MOD 15)=0) then pagines:=pagines - 1;


	writeln('');
	writeln('*INICI SORTIDA*');
	writeln('');
	writeln('KM  POBLACIO        ALTITUD                                        INCIDENCIA');
	writeln('_______________________________________________________________________________ '); {80 caracters _}
	pagina:=0;
	opcio:='X';
	TREULLISTA(pagina);
	writeln('Q.-Sortir      S.-Pag.Seguent      A.-Pag.Anterior');
	repeat
		read(opcio);
		if(opcio='A') OR (opcio='a') AND (pagina > 0) then begin {Si la p…gina actual>0 hi ha p…gina anterior, sino no}
			pagina:=pagina-1;
			writeln('');
			if (pagina=0) then writeln('*INICI SORTIDA*');
			writeln('');
			writeln('KM  POBLACIO       ALTITUD                                        INCIDENCIA');
			writeln('______________________________________________________________________________');
			TREULLISTA(pagina);
			writeln('Q-Sortir       S.-Pag.Seguent     A.-Pag.Anterior.');
		end;
		if(opcio='S') OR (opcio='s') AND (pagina < pagines) then begin
			pagina:=pagina+1;
			writeln('');
			writeln('');
			writeln('KM  POBLACIO       ALTITUD                                         INCIDENCIA');
			writeln('_______________________________________________________________________________');
			TREULLISTA(pagina);
			if (pagina=pagines) then writeln('*FINAL RECORREGUT*'); {Si la p…gina actual ‚s la £ltima indica FINAL de RECORREGUT}
			writeln('Q.-Sortir      S.-Pag.Seguent     A.-Pag.Anterior.');
		end;
	until (opcio='Q') OR (opcio='q'); {Amb Q o q podem sortir del bucle de presentaci¢ de dades}
	read(opcio);                      {Llegeix el final de l¡nea}
end;


procedure TMPPAS;
var
	velocitat:integer;

        speed:string[3];                        {Turbo Pascal}
{	speed:packed array[1..3] of char;       {Pascal Standard}

	factor: real;
	transport: char;
	temps, tmpteo,hores, minuts, segons: real;
	i,j: integer;
	res: char;
	pendent:real;
	finalitza: boolean;

begin
	speed:='   ';
	transport:='0';
	temps:=0;
	pendent:=0;

        {Bucle d'introducci¢ de dades que ‚s repeteix fins que aquestes s¢n correctes
        per velocitat s'accepta qualsevol valor entre 0 i 300 km/h,
        i per transport qualsevol valor entre 1 i 3}
	while (velocitat<1) OR (velocitat>300) OR (transport<'1') OR (transport>'3') do begin
		velocitat:=0;
		writeln('');
		write('Introdueix velocitat estimada en km/h:');
                read(res);
		read(speed);      {Lectura de la variable velocitat amb una cadena}

		while not eoln(input) do read(res);
                read(res);            {Buidar el buffer de teclar}

		i:=1;
		repeat
			velocitat:=velocitat * 10;
			velocitat:=velocitat + ORD(speed[i]) - ORD('0');
			i:=i+1;
		until (i=4) OR (speed[i]=' ');
                write(velocitat);
		writeln('');
		writeln('Escolleix mitja de transport: ');
		writeln('1.- Cotxe.');
		writeln('2.- Bici.');
		writeln('3.- a Peu.');
		writeln('');
                read(res);
		read(transport);
                write(transport);
		read(res);

                {Detecta d'error en les dades i n'¡nforma a l'usuari}
		if (velocitat<1) OR (velocitat>300) OR (transport < '1') OR (transport>'3') then begin
			writeln('La velocitat ha de ser un enter positiu inferior a 300.');
			writeln('El tipus de transport ha destar entre 1 i 3.');
			writeln('');
		end;
	end;

	if(transport='1') then factor:=0.1;
	if(transport='2') then factor:=50;
	if(transport='3') then factor:=100;

	writeln('TEMPS DE PAS');
	writeln('------------');
	writeln('km    0 -  0h  0min  0seg');
	i:=1;
	temps:=0;
	while (i<=99) AND (Dades[i].final=FALSE) do begin
              {Recorre tots els registres fins que s'acaben o fins que troba l'£ltim km}
		j:=0;
		tmpteo:=1/velocitat;    {Calcul del temps teoric del km i}
		repeat
{Calcul del pendent}	if (i>1) then pendent:=(Dades[i].altura - Dades[i-1].altura)/1000;
{Calcul temps corregit}	temps:=temps + tmpteo + (pendent * factor * 15);

{Conversi¢ del temps}	hores:=trunc(temps);
{a hores, minuts, i}	minuts:=(temps-hores) * 60;
{segons}		segons:=(minuts-trunc(minuts)) * 60;
			minuts:=trunc(minuts);
			segons:=trunc(segons);

{presentaci¢ de les}	write('km ', i:4);
{dades per pantalla}	write(' -');
			write(hores:3:0,'h');
			write(minuts:3:0,'min');
			writeln(segons:3:0, 'seg');
			j:=j+1;
			i:=i+1;
		until (Dades[i].final=TRUE) OR (j=22);
		write('Polsa RETURN per continuar.');

                while not eoln(input) do read(res); {Espera que es polsi RETURN}
		read(res);                          {per continuar treient dades per pantalla}
	end;
end;


procedure INICIALITZA;  {Precediment encarregat de la inicialitzaci¢ de variables}
var
	i,j:integer;

begin
	for i:=1 to 99 do begin
		Dades[i].altura:=0;
		for j:=1 to 15 do Dades[i].etiqueta[j]:=' ';
		Dades[i].inici:=FALSE;
		Dades[i].final:=FALSE;
		Dades[i].perill:=FALSE;
		Dades[i].bar:=FALSE;
		Dades[i].benzina:=FALSE;
		Dades[i].aigua:=FALSE;
	end;
	Dades[1].final:=TRUE;
end;

begin                   {Programa principal, presenta al menu i accedeix a la funcio adient}
	opcio:='A';
	INICIALITZA;

	while opcio<>'0' do
	begin
		writeln('MENU PRINCIPAL');
		writeln(' ');
		writeln('1.- Llegir fitxer de text.');
		writeln('2.- Salvar dades.');
		writeln('3.- Llegir fitxer de registres.');
		writeln('4.- Veure estadistiques');
		writeln('5.- Generar recorregut');
		writeln('6.- Calcular temps de pas');
		writeln('0.- Sortir del programa');
		writeln(' ');
		writeln('Introdieix opcio i pulsa REUTRN: ');
		writeln('Opcio ha de ser un nombre enter entre 0 i 6');
		read(opcio);

{		while not eoln(input) do read(res);     {Buida buffer de teclat}
                read(res);

                {Bucle per petici¢ d'opci¢ que es repeteix fins que s'introdueix
                un opci¢ correcta}
		while (opcio<'0') or (opcio>'6') do begin
			write('Opcio ha de ser un nombre enter entre 0 i 6.');
			read(opcio);
                        read(res);
		end;

		case opcio of
			'0': writeln('Has finalitzat el programa.');
			'1': begin
				INICIALITZA;
				LLEGIRTEXT;
				end;
			'2': SALVAR;
			'3': begin
				INICIALITZA;
				LLEGIREG;
				end;
			'4': ESTADIS;
			'5': RECORRE;
			'6': TMPPAS;
		end;
	end;
end.
