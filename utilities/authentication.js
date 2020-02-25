/*
Combine cookieAuth and userAuth functions into one module (validation module) so local scope keys and count variable
can be used by both functions for cookie getting and setting.
*/
require('dotenv').config();
const Cookies=require('cookies');
//TODO to store keys in external file. 
const keys=[process.env.COOKIEKEY_0,process.env.COOKIEKEY_1,process.env.COOKIEKEY_2]
let count=0;

function cookieAuth (req,res,next) {
    const cookies=new Cookies(req,res,{keys:keys});
    const result=cookies.get('user',{signed:true});
    
    /* FROM COOKIES MODULE DOCUMENTATION
    1) If the signature cookie hash matches the first key, the original cookie value is returned.
    2) If the signature cookie hash matches any other key, the original cookie value is returned AND 
    an outbound header is set to update the signature cookie's value to the hash of the first key. 
    This enables automatic freshening of signature cookies that have become stale due to key rotation.
    3) If the signature cookie hash does not match any key, nothing is returned, and an outbound header 
    with an expired date is used to delete the cookie.
    *Fully tested
    */
   
    if (result) {
        next();
    }
    else {
        res.send({
            auth:false,
        })
    }
}

function userAuth(req,res,next,pool) {
    const cookies=new Cookies(req,res,{keys:keys});
    count=count+1;
    //rotate keys every 10x time userAuth function is invoked
    if (count>=10) {
        keys.unshift(keys[keys.length-1]);
        keys.pop(); 
        count=0;
    }
    if (req.body)
    //send only 1 query to mysql for both username and password to minimise I/O
    pool.query('SELECT USER_USERNAME,USER_PASSWORD FROM user WHERE USER_USERNAME=?',[req.body.username],(error,result,field)=>{
        //handle all db auth queries here and don't pass them on to Client App side
        
        if (error) 
            res.send({
                auth:false,
                message:error.code+' '+error.errno+ ' '+error.sqlMessage
                })
        else if (!result[0])
            res.send({
                auth:false,
                message:'Username does not exist, try again'
            });
        else if (result[0].USER_PASSWORD===req.body.password) {
                //set session cookie which will be deleted once browser closes. TODO to consider time limit for extra security?
                cookies.set('user',req.body.username,{signed:true})
                res.send({
                    auth:true,
                });
            }
        else res.send({
                auth:false,
                message:'Incorrect password, try again'
            });
            
        })
        else next('Error happened during /userAuth request route.')
}


module.exports.cookieAuth=cookieAuth;
module.exports.userAuth=userAuth;