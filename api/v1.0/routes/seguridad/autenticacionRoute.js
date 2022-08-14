const autenticacionController = require('../../controllers/seguridad/autenticacionController');
const express = require('express');
const autenticacionRouter = express.Router();
const utils = require("../../../../utils/global/utils");

autenticacionRouter.post('/verificar',(req,res)=>{
    let autenticar = autenticacionController.AutenticarUsuario(req.body);
    autenticar.then((data)=>{
        res.status(200).send(data);
    })
    .catch((data)=>{
        utils.escribirLog(data.MensajeError);
        res.status(200).send(data);
    });
});



module.exports = autenticacionRouter;