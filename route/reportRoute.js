const dateParser=require('../utilities/dateParser')

function reportRoute(req,res,next,pool) {
    if (req.body)
    switch (req.body.item) {
        case 'debtor_aging':
            pool.query('CALL SELECT_DEBTOR_AGING()',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error,data:data?data[0]:null,field:field?field[0]:null});
            })
        break;
    }
}

module.exports=reportRoute