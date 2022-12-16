/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%
"Evaluar"			return 'REVALUAR';
"Console"			return 'T_CONSOLE';
"while"				return 'T_WHILE'
"for"				return 'T_FOR';
"Write"				return 'T_WRITE';
"int"           	return 'T_INT';
"double"           	return 'T_DOUBLE';
"char"           	return 'T_CHAR';
"bool"           	return 'T_BOOL';
"string"           	return 'T_STRING';
"if"				return 'T_IF';
"do"				return 'T_DO';
"void"				return 'T_VOID'
"."					return 'T_PUNTO';
","					return 'T_COMA';
";"                 return 'PTCOMA';
"("                 return 'PARIZQ';
")"                 return 'PARDER';
"["                 return 'CORIZQ';
"]"                 return 'CORDER';
"{"					return 'LLAVEA';
"}"					return 'LLAVEC';					

"+"                 return 'MAS';
"-"                 return 'MENOS';
"*"                 return 'POR';
"/"                 return 'DIVIDIDO';
"="                 return 'T_IGUAL';
"<"					return 'T_MENORQ';
">"					return 'T_MAYORQ';
"!"					return 'T_DIFERENTE';

"&&"				return 'T_AND';
"||"				return 'T_OR';

"true"				return 'T_TRUE'
"false"				return 'T_FALSE'

/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}


\"[^\"]*\"                  { yytext=yytext.substr(1,yyleng-2); return 'CADENA'; }
[0-9]+\b                	return 'ENTERO';
[0-9]+("."[0-9]+)?\b    	return 'DECIMAL';
[A-Za-z]+["_"0-9A-Za-z]*    return 'IDENTIFICADOR';
(\'[^\']\')|(\'\'\'\')|("#"{ENTERO}) return 'CHAR';

<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

%{
	const Instruccion = require('./Instruccion.js');
	const Reportes = require('./reportes.js');
	const Declaracion = require('./Declaracion.js');
	const SymbolTable = require('./tabla_simbolos.js');
	const Type = require('./tipo.js');
	const Print = require('./Imprimir.js');
	const If = require('./If.js');
	const Iden=require('./Identacion.js')
	const Param= require('./Parametro.js')
	const Logi = require('./Logicos.js')
	const Conca = require('./Concatenar.js')
	const For = require('./For.js')
	const While= require('./While.js')
	const DoWhile= require('./DoWhile.js')
	var cont=0;
	var reportes = new Reportes();
	var tabla_simbolo = new SymbolTable(null);
	var identacion=new Iden(cont);
	
	
	tabla_simbolo.reportes = reportes;
	var trad="";
	

%}

/* Asociación de operadores y precedencia */

%left 'MAS' 'MENOS'
%left 'POR' 'DIVIDIDO'
%left UMENOS

%start ini

%% /* Definición de la gramática */

ini
	: instrucciones EOF {
			
		  for(var i = 0; i< $1.length; i++){
            if($1[i])
				console.log("hola")
				console.log($1[i])
				var instru= new Instruccion($1[i]);
				instru.prueba($1[i])
		        $1[i].operar(tabla_simbolo, reportes)
        }
		//console.log("------Tabla de simbolos------")
		//console.log(tabla_simbolo)
		
		

		return reportes;
	}
;

instrucciones
	: instrucciones  instruccion  {console.log("Estoy en instrucciones--- ");$$ = $1; $$.push($2);}
	| instruccion  {identacion.menosIden();console.log("Estoy en instruccion");$$ = []; $$.push($1)}
	| error instruccion { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); 
			  reportes.putError_sintactico({lexema:yytext, fila: this._$.first_line, columna:this._$.first_column })
			}
;

instruccion
	: declaracion PTCOMA  { /*identacion.masIden();*/  console.log("Paso a aqui 1", $1); if($1 != null){$$ = $1}}
	| imprimir PTCOMA { /*identacion.masIden();*/  console.log("Paso a aqui 2", $1); if($1 != null){$$ = $1}}
	| if {  /*identacion.menosIden();*/ console.log("Paso a aqui 3", $1); if($1 != null){$$ = $1}}
	| for  {  /*identacion.menosIden();*/ console.log("Paso a aqui 3", $1); if($1 != null){$$ = $1}}
	| while {  /*identacion.menosIden();*/ console.log("Paso a aqui 3", $1); if($1 != null){$$ = $1}}
	| do_while {  /*identacion.menosIden();*/ console.log("Paso a aqui 3", $1); if($1 != null){$$ = $1}}
	| void {  /*identacion.menosIden();*/ console.log("Paso a aqui 3", $1); if($1 != null){$$ = $1}}
	| funciones {  /*identacion.menosIden();*/ console.log("Paso a aqui 3", $1); if($1 != null){$$ = $1}}
	// | REVALUAR CORIZQ expresion CORDER PTCOMA {
	// 	console.log('El valor de la expresión es: ' + $3);
	// }
;

concatenars
	: concatenars concatenar {$$ = $1; $$.push($2);}
	| concatenar{$$ = []; $$.push($1);}

;

concatenar
	: MAS IDENTIFICADOR {$$= new Conca(" , "+$2,"param");}
	| MAS CADENA {$$= new Conca(" , \""+$2+"\"","param");}
	| IDENTIFICADOR {$$= new Conca($1,"param");}
	| CADENA {$$= new Conca("\""+$1+"\"","param");}
;

imprimir 
	:T_CONSOLE T_PUNTO T_WRITE PARIZQ expresion PARDER { console.log("Paso a aqui PRINT", $1); $$ = new Print($5,this._$.first_line,this._$.first_column,"EXPRESION","imprimir","print("+$5+")\n");}
	|T_CONSOLE T_PUNTO T_WRITE PARIZQ concatenars PARDER { console.log("Paso a aqui PRINT", $1); var auxprint= new Print($5,this._$.first_line,this._$.first_column,"IDEN","imprimir",$5,identacion.getIden()/*+1*/);$$ = new Print($5,this._$.first_line,this._$.first_column,"IDEN","imprimir",identacion.generarIden()+"print("+auxprint.trad2()+")\n",identacion.getIden()/*+1*/);}
	|T_CONSOLE T_PUNTO T_WRITE PARIZQ expresion concatenars PARDER { console.log("Paso a aqui PRINT", $1); var auxprint= new Print($5,this._$.first_line,this._$.first_column,"IDEN","imprimir",$6,identacion.getIden()/*+1*/);$$ = new Print($5,this._$.first_line,this._$.first_column,"IDEN","imprimir",identacion.generarIden()+"print(" +$5+auxprint.trad2()+")\n",identacion.getIden()/*+1*/);}
;


declaracion
     : T_INT IDENTIFICADOR T_IGUAL expresion {console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n",identacion.generarIden()+identacion.getIden()/*+1*/);trad+= $2+"="+$4}
	 | T_BOOL IDENTIFICADOR T_IGUAL  T_TRUE{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n");trad+= $2+"="+$4}
	 | T_BOOL IDENTIFICADOR T_IGUAL  T_FALSE{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n");trad+= $2+"="+$4}
	 | T_STRING IDENTIFICADOR T_IGUAL  CADENA{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"=\""+$4+"\"\n");trad+= $2+"="+$4}
	 | T_CHAR IDENTIFICADOR T_IGUAL  CHAR{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n");trad+= $2+"="+$4}
	 | T_DOUBLE IDENTIFICADOR T_IGUAL  DECIMAL{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n");trad+= $2+"="+$4}
	 | T_INT IDENTIFICADOR  {console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION100' ,this._$.first_line,this._$.first_column,"declaracion",$2,identacion.generarIden()+identacion.getIden()/*+1*/);trad+= $2}
;

expresion
	: MENOS expresion %prec UMENOS  { $$ = $2 *-1; }
	| expresion MAS expresion       { $$ = $1 + $3; }
	| expresion MENOS expresion     { $$ = $1 - $3; }
	| expresion POR expresion       { $$ = $1 * $3; }
	| expresion DIVIDIDO expresion  { $$ = $1 / $3; }
	| ENTERO                        { $$ = Number($1); }
	//| DECIMAL                       { $$ = Number($1); }
	| PARIZQ expresion PARDER       { $$ = $2; }
;

logicos
	: logicos logico {$$ = $1; $$.push($2);}
	| logico {$$ = []; $$.push($1);}
;

logico 
	: T_OR relacionales{$$= new Logi(" or "+$2["tradu"],"param");}
	| T_AND relacionales {$$= new Logi(" and "+$2["tradu"],"param");}
	| relacionales {$$= new Logi($1["tradu"],"param");}
;

parametros 
	: parametros parametro{$$ = $1; $$.push($2);}
	| parametro {$$ = []; $$.push($1);}
;

parametro
	:declaracion { $$ = new Param($1["tradu"],"param");}
	| T_COMA declaracion { $$ = new Param(","+$2["tradu"],"param"); }
;

relacionales
	: IDENTIFICADOR T_MAYORQ expresion 		{$$= new Logi($1 +">"+$3,"param");}		/* > */
	| IDENTIFICADOR T_MAYORQ IDENTIFICADOR  {$$= new Logi($1 +">"+$3,"param");}
	| IDENTIFICADOR T_MENORQ expresion 		{$$= new Logi($1 +"<"+$3,"param");}		/* < */
	| IDENTIFICADOR T_MENORQ IDENTIFICADOR  {$$= new Logi($1 +"<"+$3,"param");}
	| IDENTIFICADOR T_MAYORQ T_IGUAL expresion 	{$$= new Logi($1 +">="+$4,"param");}	    /* >= */
	| IDENTIFICADOR T_MAYORQ T_IGUAL IDENTIFICADOR {$$= new Logi($1 +">="+$4,"param");}
	| IDENTIFICADOR T_MENORQ T_IGUAL expresion	{$$= new Logi($1 +"<="+$4,"param");}	/* <= */
	| IDENTIFICADOR T_MENORQ T_IGUAL IDENTIFICADOR {$$= new Logi($1 +"<="+$4,"param");}
	| IDENTIFICADOR T_IGUAL T_IGUAL expresion		/* == */
	| IDENTIFICADOR T_IGUAL T_IGUAL IDENTIFICADOR
	| IDENTIFICADOR T_IGUAL T_IGUAL T_TRUE
	| IDENTIFICADOR T_IGUAL T_IGUAL T_FALSE
	| IDENTIFICADOR T_IGUAL T_IGUAL CADENA
	| IDENTIFICADOR T_IGUAL T_IGUAL CHAR
	| IDENTIFICADOR T_DIFERENTE T_IGUAL expresion		/* != */
	| IDENTIFICADOR T_DIFERENTE T_IGUAL IDENTIFICADOR
	| IDENTIFICADOR T_DIFERENTE T_IGUAL T_TRUE
	| IDENTIFICADOR T_DIFERENTE T_IGUAL T_FALSE
	| IDENTIFICADOR T_DIFERENTE T_IGUAL CADENA
	| IDENTIFICADOR T_DIFERENTE T_IGUAL CHAR
	
;



if
	: T_IF PARIZQ logicos PARDER LLAVEA instrucciones LLAVEC {identacion.masIden();console.log("Paso por If");var auxif= new If($3,"Condicion If", $6,identacion.getIden()); $$= new If($3,"Condicion If", "if "+auxif.trad2()+" :\n"+auxif.trad()+"\n",identacion.getIden());}
;

for
	: T_FOR PARIZQ declaracion PTCOMA relacionales PTCOMA IDENTIFICADOR MAS MAS PARDER LLAVEA instrucciones LLAVEC{identacion.masIden();console.log("Paso por for");var auxfor= new For($3,$5, $7+$8+$9,"Ciclo For",$12,identacion.getIden()); $$= new For(auxfor.obtenerDatoDecla2(),auxfor.obtenerCondicion(), $7+$8+$9,"Ciclo For","for "+auxfor.obtenerDatoDecla2()+" in range("+auxfor.obtenerDatoDecla()+","+auxfor.obtenerCondicion()+"):\n"+auxfor.trad(),identacion.getIden());}
	| T_FOR PARIZQ declaracion PTCOMA relacionales PTCOMA IDENTIFICADOR MENOS MENOS PARDER LLAVEA instrucciones LLAVEC {identacion.masIden();console.log("Paso por for");var auxfor= new For($3,$5, $7+$8+$9,"Ciclo For",$12,identacion.getIden()); $$= new For(auxfor.obtenerDatoDecla2(),auxfor.obtenerCondicion(), $7+$8+$9,"Ciclo For","for "+auxfor.obtenerDatoDecla2()+" in range("+auxfor.obtenerDatoDecla()+","+auxfor.obtenerCondicion()+"):\n"+auxfor.trad(),identacion.getIden());}
;

while
	: T_WHILE PARIZQ logicos PARDER LLAVEA instrucciones LLAVEC {identacion.masIden();console.log("Paso por While");var auxwhile= new While($3,"Ciclo While", $6,identacion.getIden()); $$= new While($3,"Ciclo While", "while "+auxwhile.trad2()+" :\n"+auxwhile.trad()+"\n",identacion.getIden());}
;

do_while
	:  T_DO LLAVEA instrucciones LLAVEC  T_WHILE PARIZQ logicos PARDER PTCOMA {identacion.masIden();console.log("Paso por While");var auxdowhile= new DoWhile($7,"Ciclo Do While", $3,identacion.getIden()); $$= new DoWhile($3,"Ciclo Do While", "while True :\n"+auxdowhile.trad()+"\n"+auxdowhile.generarIden(identacion.getIden())+"if "+auxdowhile.trad2()+":\n"+auxdowhile.generarIden(identacion.getIden()+1)+"break\n",identacion.getIden());}
;

void 
	: T_VOID IDENTIFICADOR PARIZQ parametros PARDER LLAVEA instrucciones LLAVEC
;

funciones
	: T_INT IDENTIFICADOR PARIZQ parametros PARDER LLAVEA instrucciones LLAVEC
	| T_STRING IDENTIFICADOR PARIZQ parametros PARDER LLAVEA instrucciones LLAVEC
	| T_CHAR IDENTIFICADOR PARIZQ parametros PARDER LLAVEA instrucciones LLAVEC
	| T_BOOL IDENTIFICADOR PARIZQ parametros PARDER LLAVEA instrucciones LLAVEC
	| T_DOUBLE IDENTIFICADOR PARIZQ parametros PARDER LLAVEA instrucciones LLAVEC
;

type
     : T_INT {$$ = Type.ENTERO}
	 | T_DOUBLE {$$ = Type.DOUBLE}
     | T_BOOL {$$ = Type.BOOLEANO}
     | T_STRING {$$ = Type.STRING}
	 | T_CHAR {$$ = Type.CHAR}
     
;