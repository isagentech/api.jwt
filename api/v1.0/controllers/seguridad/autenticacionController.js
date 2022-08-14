const autenticacionModel = require('../../models/seguridad/autenticacionModel');
const jwt = require('jsonwebtoken');
const appKeySecret = require('../../../../utils/security/config');
const utils = require('../../../../utils/global/utils');
 

class AutenticacionController{


    AutenticarUsuario(request){
        return new Promise((resolve,reject)=>{
            let autenticar = autenticacionModel.AutenticarUsuario(request.Usuario);        
            autenticar.then ((data)=>{
                 if(data.length > 0){                    
                    if(data[0][0]['CodigoError'] === '0000'){
                        let datosUsuario = data[1][0]; 
                                       
                        if(datosUsuario !== null){
                            let Estado = datosUsuario.Estado 
                             
                            if(Estado === 'I'){
                                resolve({'CodigoError':'0001','MensajeError':'El usuario se encuentra inactivo'}); 
                            }
                            if(Estado === 'E'){
                                resolve({'CodigoError':'0001','MensajeError':'El usuario y/o clave incorrectos'}); 
                            }
                            if(Estado === 'X'){
                                resolve({'CodigoError':'0001','MensajeError':'Revise su correo para que pueda ingresar con su clave temporal'}); 
                            }
                            if(Estado === 'R'){
                                let clave = datosUsuario.ClaveTemp;
                                if(clave === request.Clave){
                                    const payload = {checked:true};
                                        let token = jwt.sign(payload, appKeySecret, {
                                            expiresIn: 14400
                                        });                                       
                                        
                                        delete datosUsuario.Clave;
                                        delete datosUsuario.ClaveTemp;

                                        datosUsuario.Token = token;

                                        datosUsuario.CodigoError = "0000";
                                                                                                                         
                                        resolve(datosUsuario);
                                }
                                else{
                                    resolve({'CodigoError':'0001','MensajeError':'Clave y/o Usuario no válidos'});   
                                }
                            }

                            if(Estado === 'A'){                        
                                let clave = datosUsuario.Clave;
                                let verificarClave = utils.validatePassword(request.Clave,clave);
                                verificarClave.then(()=>{
                                    const payload = {checked:true};
                                        let token = jwt.sign(payload, appKeySecret, {
                                            expiresIn: 14400
                                        });

                                        delete datosUsuario.Clave;
                                        delete datosUsuario.ClaveTemp;
                                        datosUsuario.Token = token;
                                        datosUsuario.CodigoError = "0000";
                                                                                                                                                                                  
                                        resolve(datosUsuario);
                                })
                                .catch(()=>{
                                     reject({'CodigoError':'0001','MensajeError':'Clave y/o Usuario no válidos'});   
                                });
                            }


                        }else{
                            resolve({'CodigoError':'0001','MensajeError':'Clave y/o Usuario no válidos'});
                         }
                    }else{
                        resolve({'CodigoError':'9999','MensajeError':data[0][0]['MensajeError'] + ' ; contactar con administrador'});
                   }
                 }else{
                    resolve({'CodigoError':'9999','MensajeError':'Error inesperado, contactar con administrador!!'});
                 }
            }).catch((data)=>{
                reject({'CodigoError':'9999','MensajeError':'Error inesperado, contactar con administrador!!!'});
            })
        });
    }   
     
}

module.exports = new AutenticacionController();