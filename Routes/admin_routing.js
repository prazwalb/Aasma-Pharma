const express=require('express')
const router=express.Router()
const {adminLogin,adminRegister}=require('../Controller/admin')

router.route('/Login')
    .post(adminLogin)

router.route('/Register')
    .post(adminRegister)

module.exports=router