global.traduccion=""

class Instruccion{
    constructor(instrucciones){
        this.instrucciones= instrucciones
    
    }

    getInst(){
        return this.instrucciones
    }

    putInst(body){
        this.instrucciones.push(body)
    }

    existeOtro(objeto){
        if (objeto["identificador"]!=null){
            return true
        }else{
            return false
        }
    }

    /*prueba(){
        console.log("estoy en instrucciones")
        var aux= this.instrucciones["identificador"]
        
        for (var valor1 of aux) {
            console.log("VALOR 1")
            console.log(valor1)
            
              //console.log(valor2);
              //console.log("estoy aca")
              
                //console.log("estoy aca2")
                var guarda= valor1["identificador"]
                for (var valor2 of guarda) {
                    if(valor2["identificador"]!=null){
                        console.log("VALOR 2")
                        console.log(valor2);
                        console.log("guardaaa")
                        guarda=valor2["identificador"]
                        console.log(guarda)
                        var valor2
                        
                        /*if(guarda["identificador"]!= null){
                            valor2=guarda["identificador"]
                            console.log("actual val2")
                            console.log(guarda)
                        }//
                       
                    }
                    //console.log(valor2["identificador"])
                }
              
              
            

        }
        
    }*/

    prueba(obj) {
        //console.log("jejeje")
        //console.log(obj)
        var aux=""
        for (let key in obj) {
            
          if (obj.hasOwnProperty(key)) {
            //console.log("estoy1")
            const element = obj[key];
            //console.log(element)
            if (typeof element === "object") {
                //console.log("estoy2")   
                //console.log(element)
                /*if(element["name"]=="imprimir"){
                    global.traduccion+="impimir("
                }*/
                
                //console.log(element)
              // Si el elemento es un objeto, llama a la función de nuevo
                this.prueba(element);
            } else {
                //console.log("estoy3")
                //global.traduccion+=")"
              // Si el elemento no es un objeto, simplemente imprime su valor
              //global.traduccion+=element
              //console.log(element);
              var idenaux=0;
              if(key=="tradu"){
                console.log(key+':'+obj[key])
                if(obj["name"]=="param"){
                  console.log("--------entreeeeeeeeee")
                }else{
                  global.traduccion+=obj[key]
                }
                
                
              }else if(key=="name"){
                console.log(key+':'+obj[key])
                if(obj["name"]=="Condicion If"){
                  idenaux+=1
                  console.log("------------------"+idenaux)
                }
              }else if(key=="iden"){
                console.log(key+':'+obj[key])
              }
            }
          }
        }
        //console.log("estoy4")
        //console.log(global.traduccion)
      }

      generarIden(identa){
        var ident=""
        for (let i = 0; i < identa; i++) {
            ident+="\t";

            
        }
        return ident
    }

    
}


module.exports = Instruccion;