const mysqlQuery = require('../../../../utils/global/database');
const utils = require('../../../../utils/global/utils');

class AutenticacionModel 
{
    AutenticarUsuario(Usuario){
        return new Promise((resolve,reject)=>{
           mysqlQuery.query('call sp_autenticacion_crud(?,?,?,?,?)',[1,null,Usuario,null,null],(error,result)=>{
               if(error){
                   let mensajeErrorSql = error.sqlMessage;
                   let numErrorSql = error.errno;
                   utils.escribirLog("Error en autenticacion model; Metodo Autenticar Usuario; ;NumError Sql"+ numErrorSql +"; Mensaje Error = " + mensajeErrorSql);
                   reject({CodigoError:'9999',MensajeError:'Se produjo un error inesperado, revisar con sistemas'});
               }
               else{
                   resolve(result);
               }
           });
        });
   } 

}


module.exports = new AutenticacionModel();