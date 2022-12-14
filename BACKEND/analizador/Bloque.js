class Bloque{
    constructor(tradu,iden){
        this.tradu=tradu
        this.iden=iden
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
        
        var auxiden="";
        /*for (var valor2 of aux2) {
            
            //console.log("--------IDENTACION---------")
            //console.log(valor["iden"])
            
            maxiden=valor2["iden"]
            console.log("-----MAXIDEN------"+maxiden)    
            
        }*/
        console.log("--------IDENTACION---------")
        console.log(aux1)
        for (var valor of aux) {
            
            
            //console.log(cont)
            console.log(valor["name"]);
            
            datos+=auxiden+valor["tradu"]
        }
        //console.log("DATOSSSS"+datos)
        return datos
        

    }
}
module.exports = Bloque;