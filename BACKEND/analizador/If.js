const { Console } = require('console');
const Symbol = require('./simbolo');
class If{
    constructor(condicion,  name, tradu,iden){
        this.condicion=condicion
        this.name=name
        this.tradu=tradu
        this.iden=iden
    }

    operar(tabla_simbolos,reportes){
        tabla_simbolos.addSymbolDirect(new Symbol(this.condicion));
        reportes.putSimbolo(new Symbol(this.condicion));
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
        var aux= this.tradu
        var aux1=this.iden
        
        console.log("--------------------------------------if")
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
            datos+=this.generarIden(aux1)+valor["tradu"]
        }
        //console.log("DATOSSSS"+datos)
        return datos
        

    }
    generarIden(identa){
        var ident=""
        for (let i = 0; i < identa; i++) {
            ident+="\t";

            
        }
        return ident
    }
}
module.exports = If;