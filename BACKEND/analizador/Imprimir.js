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
    trad2(){
        /*var aux= this.identificador
        var cont=0;
        for (var valor of aux) {
            cont+=1
            console.log(cont)
            console.log(valor["identificador"]);
        }
        
        var val= "imprimir( "+ aux+")"
        return val*/
        var aux= this.tradu
        var aux1=this.iden
        
        console.log("--------------------------------------TRAAAAD2")
        console.log(cont);
        console.log(aux)
        var datos=""
        //console.log(aux.tradu)
       
        var cont=0;
        
        
        console.log("--------IDENTACION---------")
        console.log(aux1)
        /*for (var valor2 of aux2) {
            
            //console.log("--------IDENTACION---------")
            //console.log(valor["iden"])
            
            maxiden=valor2["iden"]
            console.log("-----MAXIDEN------"+maxiden)    
            
        }*/
        
        
        for (var valor of aux) {
            
            
            //console.log(valor["iden"])
            
            
            
            
            //console.log(valor["name"]);
            if(valor["name"]=="Condicion If"){
                cont+=1
                //auxiden+="\t"
            }else{
                
            }
            console.log("---------RESTAAAAA----")
            console.log(valor["iden"])
            console.log(cont)
            datos+=valor["tradu"]
        }
        //console.log("DATOSSSS"+datos)
        return datos
        

    }
}
module.exports = Imprimir;