const { json } = require('body-parser');
const Symbol = require('./simbolo');
const Type = require('./tipo');


class Imprimir{
    constructor(identificador, fila, conlumna, tipo_dato,name,tradu,iden){
        this.identificador= identificador
        this.tipo_dato=tipo_dato
        this.fila= fila
        this.conlumna=conlumna
        this.name=name
        this.tradu=tradu
        this.iden=iden
    }

    operar(tabla_simbolos,reportes){
        tabla_simbolos.addSymbolDirect(new Symbol(this.identificador, this.tipo_dato,this.fila,this.columna));
        reportes.putSimbolo(new Symbol(this.identificador, this.tipo_dato,this.fila,this.columna));
        return true;
    }
    trad(){
        /*var aux= this.identificador
        var cont=0;
        for (var valor of aux) {
            cont+=1
            console.log(cont)
            console.log(valor["identificador"]);
        }
        
        var val= "imprimir( "+ aux+")"
        return val*/
        var aux= this.identificador
        console.log("--------------------------------------")
        var datos=""
        //console.log(aux.tradu)
        var cont=0;
        for (var valor of aux) {
            datos+=valor["tradu"]
            cont+=1
            console.log(cont)
            console.log(valor["tradu"]);
            
        }
        console.log(datos)
        return datos
        

    }
}
module.exports = Imprimir;