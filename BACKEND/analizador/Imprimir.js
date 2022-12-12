const Symbol = require('./simbolo');
const Type = require('./tipo');


class Imprimir{
    constructor(valor, fila, conlumna, tipo_dato){
        this.valor= valor
        this.tipo_dato=tipo_dato
        this.fila= fila
        this.conlumna=conlumna
    }

    operar(tabla_simbolos,reportes){
        tabla_simbolos.addSymbolDirect(new Symbol(this.valor, this.tipo_dato,this.fila,this.columna));
        reportes.putSimbolo(new Symbol(this.valor, this.tipo_dato,this.fila,this.columna));
        return true;
    }
    trad(){
        var aux= this.valor
        var cont=0;
        for (var valor of aux) {
            cont+=1
            console.log(cont)
            console.log(valor["identificador"]);
        }
        
        var val= "imprimir( "+ aux+")"
        return val
    }
}
module.exports = Imprimir;