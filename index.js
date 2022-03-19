//require express
const express = require("express");
const path = require('path')
require("dotenv").config();
const PORT = process.env.PORT || 5000
//initialize express
const app = express();

//listen to port
app.listen(PORT,()=>console.log(`process started at port:${PORT}`))

//routes
app.get('/',async (req,res)=>{
res.sendFile(path.join(__dirname +""))
})