const express = require('express');
const bodyParser = require('body-parser'); 
const cors = require('cors'); 
const utils = require('./utils/global/utils');


//ruteadores del API
//<=========================================================================================>
const auteticacionRouter = require('./api/v1.0/routes/seguridad/autenticacionRoute');
const usuarioRouter = require('./api/v1.0/routes/seguridad/usuarioRoute')
 

//<=========================================================================================>


const app = express(); 

//<=========================================================================================>
//para poder usar los bodys en los request
app.use(bodyParser.json());

app.all('*', (req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Credetials', true);
    res.header('Access-Control-Allow-Methods', 'POST, GET, PUT, DELETE, OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
  });
app.use(cors({
    'allowedHeaders': ['sessionId', 'Content-Type'],
    'exposedHeaders': ['sessionId'],
    'origin': '*',
    'methods': 'GET,HEAD,PUT,PATCH,POST,DELETE',
    'preflightContinue': false
  }));
  //<=========================================================================================>

 


//rutas del api
//<=========================================================================================>
 
app.use('/api/v1.0/seguridad/autenticacion',auteticacionRouter);  
app.use('/api/v1.0/seguridad/usuarios',usuarioRouter); 
 

//<=========================================================================================>




/*Seccion para el arranque del Servicio*/
//<===================================================================================>
const  mensajeInicio = {data:[{'CodError':'0000','MensajeError':'Api Rest Manos que Ayuda Started'}]};
app.get('/',(req,res)=>{
   res.status(200).send(mensajeInicio);

});

app.listen(5500,()=>{
    console.log('Escuchando en el puerto 5500');
    utils.escribirLog('Escuchando en el puerto 5500');
});

//<===================================================================================>