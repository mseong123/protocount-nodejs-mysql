function deleteAll(req,res,next,pool) {
    pool.query('DELETE FROM '+pool.escapeId(req.body.item)+' WHERE '+pool.escapeId(req.body.item+'_NUM')+'=?',[req.body.id],(error,data,field)=>{
        res.send({error,data,field});
    })
}


function deleteRoute(req,res,next,pool) {
    if (req.body)
    switch (req.body.item) {
        case 'stock':
        deleteAll(req,res,next,pool);
        break;

        case 'debtor':
        deleteAll(req,res,next,pool);
        break; 

        case 'creditor':
        deleteAll(req,res,next,pool);
        break; 

        case 'delivery_order':
        pool.query('CALL DELETE_DELIVERY_ORDER(?)',[req.body.id],(error,data,field)=>{
            res.send({error,data:data?data[0]:null,field:field?field[0]:null});
        })
        break; 

        case 'sales_invoice':
        pool.query('CALL DELETE_SALES_INVOICE(?)',[req.body.id],(error,data,field)=>{
            res.send({error,data:data?data[0]:null,field:field?field[0]:null});
        })
        break; 

        case 'debit_note':
        pool.query('CALL DELETE_DEBIT_NOTE(?)',[req.body.id],(error,data,field)=>{
            res.send({error,data:data?data[0]:null,field:field?field[0]:null});
        })
        break; 

        case 'credit_note':
        pool.query('CALL DELETE_CREDIT_NOTE(?)',[req.body.id],(error,data,field)=>{
            res.send({error,data:data?data[0]:null,field:field?field[0]:null});
        })
        break; 

        case 'purchase_invoice':
        pool.query('CALL DELETE_PURCHASE_INVOICE(?)',[req.body.id],(error,data,field)=>{
            res.send({error,data:data?data[0]:null,field:field?field[0]:null});
        })
        break; 

        case 'purchase_debit_note':
        pool.query('CALL DELETE_PURCHASE_DEBIT_NOTE(?)',[req.body.id],(error,data,field)=>{
            res.send({error,data:data?data[0]:null,field:field?field[0]:null});
        })
        break; 

        case 'purchase_credit_note':
        pool.query('CALL DELETE_PURCHASE_CREDIT_NOTE(?)',[req.body.id],(error,data,field)=>{
            res.send({error,data:data?data[0]:null,field:field?field[0]:null});
        })
        break; 

        case 'bank':
        deleteAll(req,res,next,pool);
        break; 

        case 'bank_receipt':
        deleteAll(req,res,next,pool);
        break; 

        case 'bank_payment':
        deleteAll(req,res,next,pool);
        break; 

        case 'cash_receipt':
        deleteAll(req,res,next,pool);
        break; 

        case 'cash_payment':
        deleteAll(req,res,next,pool);
        break; 

        case 'journal':
        pool.query('CALL DELETE_JOURNAL(?)',[req.body.id],(error,data,field)=>{
            res.send({error,data:data?data[0]:null,field:field?field[0]:null});
        })
        break; 

        case 'account':
        pool.query('DELETE FROM gl WHERE GL_ACC_NUM=?',[req.body.id],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        default: next('No database query executed for item '+req.body.item+' at /DeleteItem request route.')

    }
        
    else next('Error happened during /DeleteItem request route.')
}


module.exports=deleteRoute