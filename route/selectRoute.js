const dateParser=require('../utilities/dateParser')

function selectAll(req,res,next,pool) {
    pool.query('SELECT * FROM '+ pool.escapeId(req.body.item),(error,data,field)=>{
            //Parse date object retrieved from mysql(if any) to string format used in React controlled input field type 'date';
            dateParser(data,field)
            res.send({error,data,field})
        })
}

function selectRoute (req,res,next,pool) {
    if (req.body) 
    switch (req.body.item) {
        case 'stock':  
        if (req.body.id) 
            pool.query('CALL SELECT_STOCK(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else selectAll(req,res,next,pool);
        break;

        case 'debtor':
        if (req.body.id) 
            pool.query('CALL SELECT_DEBTOR(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else selectAll(req,res,next,pool);
        break; 

        case 'creditor':
        if (req.body.id) 
            pool.query('CALL SELECT_CREDITOR(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else selectAll(req,res,next,pool);
        break; 

        case 'delivery_order':
            if (req.body.id) 
                pool.query('CALL SELECT_DELIVERY_ORDER(?)',[req.body.id],(error,data,field)=>{
                    /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                    dateParser(data?data[0]:null,field?field[0]:null)
                    dateParser(data?data[1]:null,field?field[1]:null)
                    
                    if (data && data[1] && data[0][0] && field[0] && field[1])
                    data[1].forEach((deliveryorderlineData,i)=>{
                        
                        data[0][0]['deliveryorderlineList'+i]=field[1].map(field=>
                            deliveryorderlineData[field.name]
                            )
                        field[0].push({name:'deliveryorderlineList'+i})
                    })
                    
                    res.send({error,data:data?data[0]:null,field:field?field[0]:null})
                }
            )
            else pool.query('CALL SELECT_DELIVERY_ORDERLIST()',(error,data,field)=>{
                    /*data and field object are diff when returned from select statements in STORED PROCEDURE compared to normal select queries. 
                    Both objects are stored in SETS based on number of STORED PROCEDURE select statements and arranged in another outer layer array 
                    by MYSQL Node hence have to handle them*/
                
                    dateParser(data?data[0]:null,field?field[0]:null)
                    res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
                }
            )
            break; 

        case 'sales_invoice':
        if (req.body.id) 
            pool.query('CALL SELECT_SALES_INVOICE(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                
                if (data && data[1] && data[0][0] && field[0] && field[1])
                data[1].forEach((invoicelineData,i)=>{
                    
                    data[0][0]['invoicelineList'+i]=field[1].map(field=>
                            invoicelineData[field.name]
                        )
                    field[0].push({name:'invoicelineList'+i})
                })
                
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_SALES_INVOICELIST()',(error,data,field)=>{
                /*data and field object are diff when returned from select statements in STORED PROCEDURE compared to normal select queries. 
                Both objects are stored in SETS based on number of STORED PROCEDURE select statements and arranged in another outer layer array 
                by MYSQL Node hence have to handle them*/
            
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'debit_note':
        if (req.body.id) 
            pool.query('CALL SELECT_DEBIT_NOTE(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                
                if (data && data[1] && data[0][0] && field[0] && field[1])
                data[1].forEach((debitnotelineData,i)=>{
                    
                    data[0][0]['debitnotelineList'+i]=field[1].map(field=>
                        debitnotelineData[field.name]
                        )
                    field[0].push({name:'debitnotelineList'+i})
                })
                
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_DEBIT_NOTELIST()',(error,data,field)=>{
                
            
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'credit_note':
        if (req.body.id) 
            pool.query('CALL SELECT_CREDIT_NOTE(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                
                if (data && data[1] && data[0][0] && field[0] && field[1])
                data[1].forEach((creditnotelineData,i)=>{
                    
                    data[0][0]['creditnotelineList'+i]=field[1].map(field=>
                        creditnotelineData[field.name]
                        )
                    field[0].push({name:'creditnotelineList'+i})
                })
                
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_CREDIT_NOTELIST()',(error,data,field)=>{
                
            
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'purchase_invoice':
        if (req.body.id) 
            pool.query('CALL SELECT_PURCHASE_INVOICE(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                
                if (data && data[1] && data[0][0] && field[0] && field[1])
                data[1].forEach((invoicelineData,i)=>{
                    
                    data[0][0]['invoicelineList'+i]=field[1].map(field=>
                            invoicelineData[field.name]
                        )
                    field[0].push({name:'invoicelineList'+i})
                })
                
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_PURCHASE_INVOICELIST()',(error,data,field)=>{
    
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'purchase_debit_note':
        if (req.body.id) 
            pool.query('CALL SELECT_PURCHASE_DEBIT_NOTE(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                
                if (data && data[1] && data[0][0] && field[0] && field[1])
                data[1].forEach((purchasedebitnotelineData,i)=>{
                    
                    data[0][0]['purchasedebitnotelineList'+i]=field[1].map(field=>
                        purchasedebitnotelineData[field.name]
                        )
                    field[0].push({name:'purchasedebitnotelineList'+i})
                })
                
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_PURCHASE_DEBIT_NOTELIST()',(error,data,field)=>{
    
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'purchase_credit_note':
        if (req.body.id) 
            pool.query('CALL SELECT_PURCHASE_CREDIT_NOTE(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                
                if (data && data[1] && data[0][0] && field[0] && field[1])
                data[1].forEach((purchasecreditnotelineData,i)=>{
                    
                    data[0][0]['purchasecreditnotelineList'+i]=field[1].map(field=>
                        purchasecreditnotelineData[field.name]
                        )
                    field[0].push({name:'purchasecreditnotelineList'+i})
                })
                
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_PURCHASE_CREDIT_NOTELIST()',(error,data,field)=>{
    
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'bank':
        if (req.body.id) 
            pool.query('CALL SELECT_BANK(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else selectAll(req,res,next,pool);
        break; 

        case 'bank_receipt':
        if (req.body.id) 
            pool.query('CALL SELECT_BANK_RECEIPT(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else selectAll(req,res,next,pool);
        break; 

        case 'bank_payment':
        if (req.body.id) 
            pool.query('CALL SELECT_BANK_PAYMENT(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else selectAll(req,res,next,pool);
        break; 

        case 'cash_receipt':
        if (req.body.id) 
            pool.query('CALL SELECT_CASH_RECEIPT(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else selectAll(req,res,next,pool);
        break; 

        case 'cash_payment':
        if (req.body.id) 
            pool.query('CALL SELECT_CASH_PAYMENT(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else selectAll(req,res,next,pool);
        break; 

        case 'journal':
        if (req.body.id) 
            pool.query('CALL SELECT_JOURNAL(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                    
                if (data && data[1] && data[0][0] && field[0] && field[1])
                    data[1].forEach((journallineData,i)=>{
                        
                        data[0][0]['journallineList'+i]=field[1].map(field=>
                                journallineData[field.name]
                            )
                        field[0].push({name:'journallineList'+i})
                    })
                    
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_JOURNALLIST()',(error,data,field)=>{
        
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'balance_sheet':
        pool.query('CALL SELECT_BALANCE_SHEET()',(error,data,field)=>{
            dateParser(data?data[0]:null,field?field[0]:null)
            dateParser(data?data[1]:null,field?field[1]:null)
            dateParser(data?data[2]:null,field?field[2]:null)
            res.send({error:error,data:data?data:null,field:field?field:null})
            }
        )
        break; 

        case 'profit_and_loss':
        pool.query('CALL SELECT_PROFIT_AND_LOSS()',(error,data,field)=>{
            dateParser(data?data[0]:null,field?field[0]:null)
            dateParser(data?data[1]:null,field?field[1]:null)
            res.send({error:error,data:data?data:null,field:field?field:null})
            }
        )
        break;
        
        case 'account':
        pool.query('CALL SELECT_ACCOUNT()',(error,data,field)=>{
            dateParser(data?data[0]:null,field?field[0]:null)
            res.send({error:error,data:data?data:null,field:field?field:null})
            }
        )
        break;



        default: next('No database query executed for item '+req.body.item+' at /SelectItem request route.')

    }
    
    else next('Error happened during /SelectItem request route.')
}

module.exports=selectRoute;