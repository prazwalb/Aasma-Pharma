const express=require('express')
let app=express()
const adminRouter=require('./Routes/admin_routing')
const patientRouting=require('./Routes/patient_routing')
const productRouting=require('./Routes/product_routing')
app.use(express.json())

app.use('/',patientRouting)
app.use('/api/admin',adminRouter)
app.use('/api/admin',productRouting)
module.exports=app