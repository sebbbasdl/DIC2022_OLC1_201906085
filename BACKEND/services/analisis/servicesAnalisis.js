const { Router, json } = require('express');


const router = Router();
const parser = require('../../analizador/gramatica');   
const Instruccion = require('../../analizador/Instruccion');
require('../../analizador/Instruccion')   


router.post("/Analizador", async (req, res) => {
    
    console.log("prueba");

    console.log(req.body);

    let resultado = parser.parse(req.body.text);
    console.log();

    if(!resultado){
        console.log("Error en el analisis");
    }else{
        console.log("Analisis exitoso");
    }
    res.send({errores_sintacticos:resultado.getErrores_sintacticos(),errores_lexicos:resultado.getErrores_lexicos(), tabla_simbolos: resultado.getSimbolos(), traduccion: global.traduccion});
    // console.log(id_user.id_usuario_logueado)
    console.log(global.traduccion)
    global.traduccion=""
    
  })
  

module.exports = router;