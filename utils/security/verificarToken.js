const express = require('express');
const rutasProtegidas = express.Router(); 
const jwt = require('jsonwebtoken');
const appKeySecret = require('./config');

rutasProtegidas.use((req, res, next) => {
    const token = req.headers['authorization'];    
    if (token) {
      jwt.verify(token, appKeySecret, (err, decoded) => {      
        if (err) {
          return res.status(401).send({'CodigoError' :'0001','MensajeError':'Token inválida' });    
        } else {
          req.decoded = decoded;    
          next();
        }
      }); 
    } else {
        return res.status(401).send({'CodigoError' :'0001','MensajeError':'Token no proveída'}); 
    }
 });
 

 module.exports = rutasProtegidas;