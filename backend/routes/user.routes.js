const express = require('express');
const userRoutes = express.Router();

// Student model
let UserModel = require('../models/user.model.js');

userRoutes.route('/').get((req, res) => {
    UserModel.find((error, data) => {
     if (error) {
       return next(error)
     } else {
       res.json(data)
     }
   })
 })

 userRoutes.route('/create-student').post((req, res, next) => {
    UserModel.create(req.body, (error, data) => {
    if (error) {
      return next(error)
    } else {
      res.json(data)
    }
  })
});



module.exports = userRoutes;