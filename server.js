const app=require('./app')
const dotenv=require('dotenv')
dotenv.config({path:'./config.env'})
const mongoose=require('mongoose')

mongoose.connect(process.env.LOCAL_CONN_STR,{
    useNewUrlParser:true
}).then((conn=>{
    console.log("Connection Successful")
})).catch((err)=>{
    console.log(err)
})

const port=process.env.PORT || 5000
app.listen(port,()=>{
    console.log("Server has been started")
})