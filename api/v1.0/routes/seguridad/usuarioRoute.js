const usuarioController = require('../../controllers/seguridad/usuarioController');
const express = require('express');
const usuarioRouter = express.Router();
const verificarToken = require('../../../../utils/security/verificarToken');
const utils = require("../../../../utils/global/utils");



usuarioRouter.get('/listar',verificarToken,(req,res)=>{
    let listar = usuarioController.ListarPersonas(req.query);
    listar.then((data)=>{
        res.status(200).send(data[0]);
    })
    .catch((data)=>{
        utils.escribirLog(data.MensajeError);
        res.status(200).send(data);
    });
});





module.exports = usuarioRouter;