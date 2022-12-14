/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%
"Evaluar"			return 'REVALUAR';
"Console"			return 'T_CONSOLE';
"Write"				return 'T_WRITE'
"int"           	return 'T_INT';
"double"           	return 'T_DOUBLE';
"char"           	return 'T_CHAR';
"bool"           	return 'T_BOOL';
"string"           	return 'T_STRING';
"if"				return 'T_IF';
"."					return 'T_PUNTO'
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
	| instruccion  {console.log("Estoy en instruccion");$$ = []; $$.push($1)}
	| error instruccion { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); 
			  reportes.putError_sintactico({lexema:yytext, fila: this._$.first_line, columna:this._$.first_column })
			}
;

instruccion
	: declaracion PTCOMA  { /*identacion.masIden();*/  console.log("Paso a aqui 1", $1); if($1 != null){$$ = $1}}
	| imprimir PTCOMA { /*identacion.masIden();*/  console.log("Paso a aqui 2", $1); if($1 != null){$$ = $1}}
	| if {  /*identacion.menosIden();*/ console.log("Paso a aqui 3", $1); if($1 != null){$$ = $1}}
	// | REVALUAR CORIZQ expresion CORDER PTCOMA {
	// 	console.log('El valor de la expresión es: ' + $3);
	// }
;

imprimir 
	:T_CONSOLE T_PUNTO T_WRITE PARIZQ expresion PARDER { console.log("Paso a aqui PRINT", $1); $$ = new Print($5,this._$.first_line,this._$.first_column,"EXPRESION","imprimir","print("+$5+")\n");}
	|T_CONSOLE T_PUNTO T_WRITE PARIZQ IDENTIFICADOR PARDER { console.log("Paso a aqui PRINT", $1); $$ = new Print($5,this._$.first_line,this._$.first_column,"IDEN","imprimir",identacion.generarIden()+"print("+$5+")\n",identacion.getIden()/*+1*/);}
	|T_CONSOLE T_PUNTO T_WRITE PARIZQ CADENA PARDER { console.log("Paso a aqui PRINT", $1); $$ = new Print($5,this._$.first_line,this._$.first_column,"CADENA","imprimir","print(\""+$5+"\")\n");}
;


declaracion
     : T_INT IDENTIFICADOR T_IGUAL expresion {console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n",identacion.generarIden()+identacion.getIden()/*+1*/);trad+= $2+"="+$4}
	 | T_BOOL IDENTIFICADOR T_IGUAL  T_TRUE{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n");trad+= $2+"="+$4}
	 | T_BOOL IDENTIFICADOR T_IGUAL  T_FALSE{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n");trad+= $2+"="+$4}
	 | T_STRING IDENTIFICADOR T_IGUAL  CADENA{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"=\""+$4+"\"\n");trad+= $2+"="+$4}
	 | T_CHAR IDENTIFICADOR T_IGUAL  CHAR{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n");trad+= $2+"="+$4}
	 | T_DOUBLE IDENTIFICADOR T_IGUAL  DECIMAL{ console.log("Paso a aqui DECLA", $1);  $$ = new Declaracion($2+"="+$4,$1,Type.VARIABLE,Type.VARIABLE, 'RESOLVER EXPRESION' ,this._$.first_line,this._$.first_column,"declaracion",$2+"="+$4+"\n");trad+= $2+"="+$4}
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

if
	: T_IF PARIZQ IDENTIFICADOR PARDER LLAVEA instrucciones LLAVEC {identacion.masIden();console.log("Paso por If");var auxif= new If($3,"Condicion If", $6,identacion.getIden()); $$= new If($3,"Condicion If", "if "+$3+" :\n"+auxif.trad()+"\n",identacion.getIden());}
;

type
     : T_INT {$$ = Type.ENTERO}
	 | T_DOUBLE {$$ = Type.DOUBLE}
     | T_BOOL {$$ = Type.BOOLEANO}
     | T_STRING {$$ = Type.STRING}
	 | T_CHAR {$$ = Type.CHAR}
     
;