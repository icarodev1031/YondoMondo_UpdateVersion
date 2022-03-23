const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let userSchema = new Schema({
  name: {
    type: String
  },
  description:{
    type:String
  }
})

module.exports = mongoose.model('User', userSchema)