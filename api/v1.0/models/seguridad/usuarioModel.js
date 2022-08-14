const mysqlQuery = require('../../../../utils/global/database');
const utils = require('../../../../utils/global/utils');

class UsuarioModel{

    ListarPersonas(IdPersona,Identificacion,Nombres,Apellidos){
        return new Promise((resolve,reject)=>{
            mysqlQuery.query('call sp_personas_crud(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',[1,IdPersona,null,Identificacion,Nombres,Apellidos,null,null,null,null,null,null,null,null,null,null,''],
            (error,result)=>{
                if(error){
                    let mensajeErrorSql = error.sqlMessage;
                    let numErrorSql = error.errno;
                    utils.escribirLog("Error en UsuarioModel ; Metodo ListarPersonas; ;NumError Sql"+ numErrorSql +"; Mensaje Error = " + mensajeErrorSql);
                    reject({CodigoError:'9999',MensajeError:'Se produjo un error inesperado, revisar con sistemas'});
                }
                else{
                    resolve(result);
                }
            });
          });
    }      

}

module.exports = new UsuarioModel();
