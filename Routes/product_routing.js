const express=require('express')
const prod_route=express.Router()
const {addNewProduct,addProduct,updateProductDetails,deleteProduct}=require('../Controller/product')

prod_route.route('/Product/New').post(addNewProduct)
prod_route.route('/Product/:productId')
                            .post(addProduct)
                            .put(updateProductDetails)
                            .delete(deleteProduct)


module.exports=prod_route