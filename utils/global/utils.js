const fs = require('fs');
const bcrypt = require('bcryptjs');

class Utils{


    randomString(length) {
        var result           = '';
        var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_*';
        var charactersLength = characters.length;
        for ( var i = 0; i < length; i++ ) {
           result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
     }

    escribirLog(mensaje){
        
        let f = new Date();
        let mensajeCompleto = "<=====================>\n" + f  + " " + mensaje + "\n" + "<====================>\n";       
        let fechaActual = f.getDate() + "_" + (f.getMonth() +1) + "_" + f.getFullYear();
        let path = './files/logs/LogDiario'+fechaActual+'.txt';
       
        fs.appendFile(path,mensajeCompleto,'utf8',function(error){
            if (error)
              console.log(error);       
                     
        });        
    }

    //metodo para encriptar passwords
    encryptPassword(password){
       
        return new Promise((resolve,reject)=>{
              bcrypt.genSalt(10, function(err, salt) {
                  bcrypt.hash(password, salt, function(err, hash) {
                       if(hash){
                           resolve(hash);
                       }
                       else{
                           reject({'CodigoError' :'9999','MensajeError':'Se presento error al momento de encryptar clave' + err });
                       }
                  });
              }); 
          });        
       }
       
       //metodo para validar si el password es correcto
       validatePassword(passwordSending,password){
           return new Promise((resolve,reject)=>{
               bcrypt.compare(passwordSending,password,(Error,Resul)=>{
                   if(Resul){
                        
                       resolve(Resul);
                   }
                   else{
                       
                       reject(false);
                   }
               });
           })
       }

}

module.exports = new Utils();