const express=require('express')
const prod_route=express.Router()
const {addNewProduct,addProduct}=require('../Controller/product')

prod_route.route('/AddNew').post(addNewProduct)
prod_route.route('/AddProduct/:productId').post(addProduct)

module.exports=prod_route