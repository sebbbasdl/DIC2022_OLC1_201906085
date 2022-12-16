const Symbol = require('./simbolo');
class For{
    constructor(decla, relacional, aum_dec,name,tradu,iden){
        this.decla=decla
        this.relacional= relacional
        this.aum_dec=aum_dec
        this.name=name
        this.tradu= tradu
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
        var aux2=this.decla


        
        console.log("--------------------------------------if")
        console.log(aux2)
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
        var aux= this.condicion
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

    obtenerDatoDecla(){
        console.log("DATO DECLA----------")
        var auxdecla=this.decla
        var val="";
        var i=0;
        for (let index = 0; index < auxdecla["tradu"].length; index++) {
            var d = auxdecla["tradu"][index];
            if(d=="="){
                i=index  
            }
        }

        for (let index = i+1; index < auxdecla["tradu"].length; index++) {
            var d = auxdecla["tradu"][index];
            if(d!="\n"){
                val +=d.toString()
            }
            
        }
        console.log("VALLL")
        console.log(val)
        return val
    }


    obtenerDatoDecla2(){
        console.log("DATO DECLA22222----------")
        var auxdecla=this.decla
        var val="";
        var i=0;
        for (let index = 0; index < auxdecla["tradu"].length; index++) {
            var d = auxdecla["tradu"][index];
            if(d=="="){
                i=index  
                break
            }else{
                val +=d.toString()
            }
        }

        
        console.log("VALLL")
        console.log(val)
        return val
    }

    obtenerCondicion(){
        console.log("DATO CONDICION----------")
        var auxdecla=this.relacional

        var auxdeaux= auxdecla["tradu"].split('').reverse().join('')
        console.log(auxdeaux)

        var val="";
        var i=0;
        for (let index = 0; index < auxdeaux.length; index++) {
            var d = auxdeaux[index];
            if(d=="=" || d=="<" || d==">" ){
                i=index  
            }
        }

        for (let index = i+1; index < auxdecla["tradu"].length; index++) {
            var d = auxdecla["tradu"][index];
            val +=d.toString()
        }
        console.log("VALLL")
        console.log(val)
        return val
    }

    generarIden(identa){
        var ident=""
        for (let i = 0; i < identa; i++) {
            ident+="\t";

            
        }
        return ident
    }

    operar(tabla_simbolos,reportes){
        tabla_simbolos.addSymbolDirect(new Symbol(this.decla, this.relacional,this.aum_dec,this.tradu));
        reportes.putSimbolo(new Symbol(this.decla, this.relacional,this.aum_dec,this.tradu));
        return true;
    }
}



module.exports =For;