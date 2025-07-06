const express=require('express')
let app=express()
const adminRouter=require('./Routes/admin_routing')
const patientRouting=require('./Routes/patient_routing')
app.use(express.json())

app.use('/',patientRouting)
app.use('/api/admin',adminRouter)
module.exports=app