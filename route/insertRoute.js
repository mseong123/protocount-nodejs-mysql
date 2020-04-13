function transformInput (param) {
    let tempString;
    return param.map(input=>{
        if (input) /*to ensure null values not parsed and cause error*/ {
            if(typeof input.forEach==='function' && input.length!==0) {
            /*stringify all nested array inputs and combine them */
            tempString='';
                input.forEach(item=>
                    tempString+=(tempString?'=':'')+item.map(subitem=>JSON.stringify(subitem)).join()
                    )
                return tempString
            } 
            else if (typeof input.forEach==='function' && input.length===0) return null
            else return input
        }
        else return input
    })
}


function insertRoute(req,res,next,pool) {
    
    if (req.body)
    switch (req.body.item) {
        
        case 'stock':
        pool.query('CALL INSERT_STOCK(?,?,?,?,?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'debtor':
        pool.query('CALL INSERT_DEBTOR(?,?,?,?,?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'creditor':
        pool.query('CALL INSERT_CREDITOR(?,?,?,?,?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'delivery_order':
        pool.query('CALL INSERT_DELIVERY_ORDER(?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        });
        
        break;

        case 'delivery_return':
        pool.query('CALL INSERT_DELIVERY_RETURN(?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        });
        
        break;

        case 'sales_invoice':
        pool.query('CALL INSERT_SALES_INVOICE(?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        });
        
        break;

        case 'debit_note':
        pool.query('CALL INSERT_DEBIT_NOTE(?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        });
        
        break;

        case 'credit_note':
        pool.query('CALL INSERT_CREDIT_NOTE(?,?,?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
           
        });
        
        break;

        case 'goods_received_note':
        pool.query('CALL INSERT_GOODS_RECEIVED_NOTE(?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'purchase_return':
        pool.query('CALL INSERT_PURCHASE_RETURN(?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'purchase_invoice':
        pool.query('CALL INSERT_PURCHASE_INVOICE(?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'purchase_debit_note':
        pool.query('CALL INSERT_PURCHASE_DEBIT_NOTE(?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'purchase_credit_note':
        pool.query('CALL INSERT_PURCHASE_CREDIT_NOTE(?,?,?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'bank':
        pool.query('CALL INSERT_BANK(?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'bank_receipt':
        pool.query('CALL INSERT_BANK_RECEIPT(?,?,?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'bank_payment':
        pool.query('CALL INSERT_BANK_PAYMENT(?,?,?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'cash_receipt':
        pool.query('CALL INSERT_CASH_RECEIPT(?,?,?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'cash_payment':
        pool.query('CALL INSERT_CASH_PAYMENT(?,?,?,?,?,?,?,?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'journal':
        pool.query('CALL INSERT_JOURNAL(?,?,?,?,?)',[...transformInput(req.body.param)],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'account':
        pool.query('CALL INSERT_ACCOUNT(?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;
        
        default: next('No database query executed for item '+req.body.item+'at /InsertItem request route.')
    }
    else next('Error happened during /InsertItem request route.')
}


module.exports=insertRoute