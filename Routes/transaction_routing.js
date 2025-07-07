const express=require('express')
const tran_route=express.Router()
const {Transactions}=require('../Controller/transaction')

tran_route.route('/Buy').post(Transactions)

module.exports=tran_route