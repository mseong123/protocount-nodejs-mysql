const dateParser=require('../utilities/dateParser')

function reportRoute(req,res,next,pool) {
    if (req.body)
    switch (req.body.item) {
        case 'debtor_aging':
        pool.query('CALL SELECT_DEBTOR_AGING(?,?)',[req.body.param[0].map(item=>JSON.stringify(item)).join(),
        JSON.stringify(req.body.param[1])],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error,data:data?data[0]:null,field:field?field[0]:null});
            })
        break;

        case 'debtor_statement':
            pool.query('CALL SELECT_DEBTOR_STATEMENT(?,?,?)',[...req.body.param],(error,data,field)=>{
                dateParser(data?data[1]:null,field?field[1]:null)
                res.send({error,data:data?data:null,field:field?field:null});
            })
        break;
    }
}

module.exports=reportRoute