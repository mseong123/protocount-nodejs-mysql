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

        case 'debtor_collection':
            pool.query('CALL SELECT_DEBTOR_COLLECTION(?,?,?)',[JSON.stringify(req.body.param[0])
            ,JSON.stringify(req.body.param[1]),req.body.param[2].map(item=>JSON.stringify(item)).join()]
            ,(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                res.send({error,data:data?data:null,field:field?field:null});
            })
        break;

        case 'creditor_aging':
        pool.query('CALL SELECT_CREDITOR_AGING(?,?)',[req.body.param[0].map(item=>JSON.stringify(item)).join(),
        JSON.stringify(req.body.param[1])],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error,data:data?data[0]:null,field:field?field[0]:null});
            })
        break;

        case 'creditor_statement':
            pool.query('CALL SELECT_CREDITOR_STATEMENT(?,?,?)',[...req.body.param],(error,data,field)=>{
                dateParser(data?data[1]:null,field?field[1]:null)
                res.send({error,data:data?data:null,field:field?field:null});
            })
        break;

        case 'stock_card':
            pool.query('CALL SELECT_STOCK_CARD(?,?,?)',[JSON.stringify(req.body.param[0])
            ,JSON.stringify(req.body.param[1]),req.body.param[2].map(item=>JSON.stringify(item)).join()]
            ,(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                res.send({error,data:data?data:null,field:field?field:null});
            })
        break;

        case 'sales_analysis_debtor_stock':
            pool.query('CALL SELECT_SALES_ANALYSIS_DEBTOR_STOCK(?,?,?,?)',[JSON.stringify(req.body.param[0])
            ,JSON.stringify(req.body.param[1]),req.body.param[2].map(item=>JSON.stringify(item)).join(),
            req.body.param[3].length>0? req.body.param[3].map(item=>JSON.stringify(item)).join():JSON.stringify('')
            ]
            ,(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                res.send({error,data:data?data:null,field:field?field:null});
            })
        break;

        case 'sales_analysis_stock_debtor':
            pool.query('CALL SELECT_SALES_ANALYSIS_STOCK_DEBTOR(?,?,?,?)',[JSON.stringify(req.body.param[0])
            ,JSON.stringify(req.body.param[1]),req.body.param[2].map(item=>JSON.stringify(item)).join(),
            req.body.param[3].length>0? req.body.param[3].map(item=>JSON.stringify(item)).join():JSON.stringify('')
            ]
            ,(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                res.send({error,data:data?data:null,field:field?field:null});
            })
        break;

        case 'purchase_analysis_creditor_stock':
            pool.query('CALL SELECT_PURCHASE_ANALYSIS_CREDITOR_STOCK(?,?,?,?)',[JSON.stringify(req.body.param[0])
            ,JSON.stringify(req.body.param[1]),req.body.param[2].map(item=>JSON.stringify(item)).join(),
            req.body.param[3].length>0? req.body.param[3].map(item=>JSON.stringify(item)).join():JSON.stringify('')
            ]
            ,(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                res.send({error,data:data?data:null,field:field?field:null});
            })
        break;

        case 'purchase_analysis_stock_creditor':
            pool.query('CALL SELECT_PURCHASE_ANALYSIS_STOCK_CREDITOR(?,?,?,?)',[JSON.stringify(req.body.param[0])
            ,JSON.stringify(req.body.param[1]),req.body.param[2].map(item=>JSON.stringify(item)).join(),
            req.body.param[3].length>0? req.body.param[3].map(item=>JSON.stringify(item)).join():JSON.stringify('')
            ]
            ,(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                res.send({error,data:data?data:null,field:field?field:null});
            })
        break;

        default:
        next('Error happened during /ReportItem request route.')
    }
    else next('Error happened during /ReportItem request route.')
}

module.exports=reportRoute