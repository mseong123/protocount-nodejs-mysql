function deleteRoute(req,res,next,pool) {
    if (req.body)
    switch (req.body.item) {
        case 'stock':
        pool.query('CALL DELETE_STOCK(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'debtor':
        pool.query('CALL DELETE_DEBTOR(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'creditor':
        pool.query('CALL DELETE_CREDITOR(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'delivery_order':
        pool.query('CALL DELETE_DELIVERY_ORDER(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'delivery_return':
        pool.query('CALL DELETE_DELIVERY_RETURN(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'sales_invoice':
        pool.query('CALL DELETE_SALES_INVOICE(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'debit_note':
        pool.query('CALL DELETE_DEBIT_NOTE(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'credit_note':
        pool.query('CALL DELETE_CREDIT_NOTE(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'goods_received_note':
        pool.query('CALL DELETE_GOODS_RECEIVED_NOTE(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'purchase_return':
        pool.query('CALL DELETE_PURCHASE_RETURN(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'purchase_invoice':
        pool.query('CALL DELETE_PURCHASE_INVOICE(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'purchase_debit_note':
        pool.query('CALL DELETE_PURCHASE_DEBIT_NOTE(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'purchase_credit_note':
        pool.query('CALL DELETE_PURCHASE_CREDIT_NOTE(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'bank':
        pool.query('CALL DELETE_BANK(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'bank_receipt':
        pool.query('CALL DELETE_BANK_RECEIPT(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'bank_payment':
        pool.query('CALL DELETE_BANK_PAYMENT(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'cash_receipt':
        pool.query('CALL DELETE_CASH_RECEIPT(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'cash_payment':
        pool.query('CALL DELETE_CASH_PAYMENT(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
        })
        break; 

        case 'journal':
        pool.query('CALL DELETE_JOURNAL(?)',[req.body.id.map(item=>JSON.stringify(item)).join()],(error,data,field)=>{
            res.send({error,data,field});
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