const express = require('express');
const rutasProtegidas = express.Router(); 
const jwt = require('jsonwebtoken');
const appKeySecret = require('./config');

rutasProtegidas.use((req, res, next) => {
    req.decoded = decoded;    
    next();    
 });
 

 module.exports = rutasProtegidas;