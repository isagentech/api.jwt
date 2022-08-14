const usuarioModel = require('../../models/seguridad/usuarioModel');
const utils = require('../../../../utils/global/utils');

class UsuarioController{
    ListarPersonas(request){
        let consulta = usuarioModel.ListarPersonas(request.IdPersona,request.Identificacion,request.Nombres,request.Apellidos);
        return consulta;
    }

}


module.exports = new UsuarioController();