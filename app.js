const express=require('express')
let app=express()
const adminRouter=require('./Routes/routing')
app.use(express.json())

app.use('/api/admin',adminRouter)
module.exports=app