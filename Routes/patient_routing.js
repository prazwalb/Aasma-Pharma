const express=require('express')
const rout=express.Router()
const {userLogin,userRegister}=require('../Controller/patient')

rout.route('/Login')
    .post(userLogin)

rout.route('/Register')
    .post(userRegister)

module.exports=rout