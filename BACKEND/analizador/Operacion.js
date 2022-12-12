class Operacion{
    constructor(){
        this.resultt= []
    }

    getResult(){
        return this.resultt
    }

    putResult(body){
        this.resultt.push(body)
    }

}

module.exports = Operacion;