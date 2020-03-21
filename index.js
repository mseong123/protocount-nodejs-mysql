require('dotenv').config();
const path=require('path');
const express=require('express');
const app=express();
const mysql=require('mysql');
const {cookieAuth,userAuth}=require('./utilities/authentication')
const selectRoute=require('./route/selectRoute')
const insertRoute=require('./route/insertRoute')
const updateRoute=require('./route/updateRoute')
const deleteRoute=require('./route/deleteRoute')
const reportRoute=require('./route/reportRoute')
const {getIDList,getEligibleGLAccount,getDebtorOutstanding,getCreditorOutstanding}=require('./route/otherRoute')


app.use(express.urlencoded({extended:false}));
app.use(express.json());

app.use(express.static(path.join(__dirname,'public')))

/*sanitise any req.body.param array element(including nested array elements which are also array itself) which contain input value of '' to null value
to be inserted as value null into DB instead of ''*/
app.use((req,res,next)=>{
    
    if (req.body && req.body.param) {
        req.body.param=req.body.param.map(data=>{
            if (typeof data.forEach==='function'){
                
                return data.map(data2=>
                    data2.map(item=>
                        item===''?null:item))
                    }
            else return data===''?null:data
            })
        
        next()
    }
    else next();
})

app.post('/SelectItem',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    selectRoute(req,res,next,pool)
})

app.post('/InsertItem',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    insertRoute(req,res,next,pool)
})

app.post('/UpdateItem',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    updateRoute(req,res,next,pool)
})

app.post('/DeleteItem',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    deleteRoute(req,res,next,pool)
})

app.post('/ReportItem',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    reportRoute(req,res,next,pool)
})


app.post('/getIDList',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    getIDList(req,res,next,pool)
});

app.post('/getEligibleGLAccount',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    getEligibleGLAccount(req,res,next,pool)
});

app.post('/getDebtorOutstanding',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    getDebtorOutstanding(req,res,next,pool)
});

app.post('/getCreditorOutstanding',(req,res,next)=>cookieAuth(req,res,next),(req,res,next)=>{
    getCreditorOutstanding(req,res,next,pool)
});

app.post('/userAuth',(req,res,next)=>{
    userAuth(req,res,next,pool);
})

app.use((req,res,next)=>{
    res.redirect('/')
    //res.send('did not match any request. Please try again')
})

//Error handler
app.use(function(error,req,res,next){
    res.status(500).send({error:error});
})

const pool=mysql.createPool(process.env.JAWSDB_URL || {
    host:process.env.DB_HOST,
    user:process.env.DB_USER,
    password:process.env.DB_PASS,
    database:process.env.DB_DATABASE,
})

app.listen(process.env.PORT||4000,()=>{
    console.log('SERVER connected')
})







