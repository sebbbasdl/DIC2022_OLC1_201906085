class Identacion{
    constructor(iden){
        this.iden=iden
    }
    masIden(){
        this.iden+=1
    }

    menosIden(){
        this.iden-=1
    }

    getIden(){
        return 5 - this.iden
    }
    
    generarIden(){
        var ident=""
        for (let i = 0; i < this.iden; i++) {
            ident+="\t";

            
        }
        return ident
    }
}
module.exports = Identacion;