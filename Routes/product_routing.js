const express=require('express')
const prod_route=express.Router()
const {addNewProduct,addProduct,updateProductDetails,deleteProduct}=require('../Controller/product')
const {searchProductByName}=require('../Controller/search')

prod_route.route('/Product/New').post(addNewProduct)
prod_route.route('/Product/:productId')
                            .post(addProduct)
                            .put(updateProductDetails)
                            .delete(deleteProduct)

prod_route.route('/Product/:name').get(searchProductByName)                        


module.exports=prod_route