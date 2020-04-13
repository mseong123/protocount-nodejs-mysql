const dateParser=require('../utilities/dateParser')

function selectRoute (req,res,next,pool) {
    if (req.body) 
    switch (req.body.item) {
        case 'stock':  
        if (req.body.id) 
            pool.query('CALL SELECT_STOCK(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else pool.query('CALL SELECT_STOCKLIST()',(error,data,field)=>{
            /*data and field object are diff when returned from select statements in STORED PROCEDURE compared to normal select queries. 
            Both objects are stored in SETS based on number of STORED PROCEDURE select statements and arranged in another outer layer array 
            by MYSQL Node hence have to handle them*/
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break;

        case 'debtor':
        if (req.body.id) 
            pool.query('CALL SELECT_DEBTOR(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else pool.query('CALL SELECT_DEBTORLIST()',(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'creditor':
        if (req.body.id) 
            pool.query('CALL SELECT_CREDITOR(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else pool.query('CALL SELECT_CREDITORLIST()',(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'delivery_order':
            if (req.body.id) 
                pool.query('CALL SELECT_DELIVERY_ORDER(?)',[req.body.id],(error,data,field)=>{
                    /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                    dateParser(data?data[0]:null,field?field[0]:null)
                    dateParser(data?data[1]:null,field?field[1]:null)
                    
                    let parsedLineData1=[];
                    if (data && data[1] && data[0][0] && field[0] && field[1]) {
                        data[1].forEach(lineData=>
                            parsedLineData1.push(field[1].map(field=>
                                lineData[field.name]
                            ))
                        )
                        data[0][0]['deliveryorderlineList1']=parsedLineData1;
                        field[0].push({name:'deliveryorderlineList1'})
                    }
                    res.send({error,data:data?data[0]:null,field:field?field[0]:null})
                }
            )
            else pool.query('CALL SELECT_DELIVERY_ORDERLIST()',(error,data,field)=>{
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
                
                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['salesinvoicelineList1']=parsedLineData1;
                    field[0].push({name:'salesinvoicelineList1'})
                }
                
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_SALES_INVOICELIST()',(error,data,field)=>{
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
                
                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['debitnotelineList1']=parsedLineData1;
                    field[0].push({name:'debitnotelineList1'})
                }
                
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
                dateParser(data?data[2]:null,field?field[2]:null)
                dateParser(data?data[3]:null,field?field[3]:null)
                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['creditnotelineList1']=parsedLineData1;
                    field[0].push({name:'creditnotelineList1'})
                }

                let parsedLineData2=[];
                if (data && data[2] && data[0][0] && field[0] && field[2]) {
                    data[2].forEach(lineData=>
                        parsedLineData2.push(field[2].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['creditnotelineList2']=parsedLineData2;
                    field[0].push({name:'creditnotelineList2'})
                }

                let parsedLineData3=[];
                if (data && data[3] && data[0][0] && field[0] && field[3]) {
                    data[3].forEach(lineData=>
                        parsedLineData3.push(field[3].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['creditnotelineList3']=parsedLineData3;
                    field[0].push({name:'creditnotelineList3'})
                }

                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_CREDIT_NOTELIST()',(error,data,field)=>{
                
            
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'purchase_return':
        if (req.body.id) 
            pool.query('CALL SELECT_PURCHASE_RETURN(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                    
                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['purchasereturnlineList1']=parsedLineData1;
                    field[0].push({name:'purchasereturnlineList1'})
                }
                res.send({error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        else pool.query('CALL SELECT_PURCHASE_RETURNLIST()',(error,data,field)=>{
                /*data and field object are diff when returned from select statements in STORED PROCEDURE compared to normal select queries. 
                Both objects are stored in SETS based on number of STORED PROCEDURE select statements and arranged in another outer layer array 
                by MYSQL Node hence have to handle them*/
                
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
                
                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['purchaseinvoicelineList1']=parsedLineData1;
                    field[0].push({name:'purchaseinvoicelineList1'})
                }
                
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
                
                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['purchasedebitnotelineList1']=parsedLineData1;
                    field[0].push({name:'purchasedebitnotelineList1'})
                }
                
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
                dateParser(data?data[2]:null,field?field[2]:null)
                dateParser(data?data[3]:null,field?field[3]:null)

                
                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['purchasecreditnotelineList1']=parsedLineData1;
                    field[0].push({name:'purchasecreditnotelineList1'})
                }

                let parsedLineData2=[];
                if (data && data[2] && data[0][0] && field[0] && field[2]) {
                    data[2].forEach(lineData=>
                        parsedLineData2.push(field[2].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['purchasecreditnotelineList2']=parsedLineData2;
                    field[0].push({name:'purchasecreditnotelineList2'})
                }

                let parsedLineData3=[];
                if (data && data[3] && data[0][0] && field[0] && field[3]) {
                    data[3].forEach(lineData=>
                        parsedLineData3.push(field[3].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['purchasecreditnotelineList3']=parsedLineData3;
                    field[0].push({name:'purchasecreditnotelineList3'})
                }
                
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
        else pool.query('CALL SELECT_BANKLIST()',(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            }
        )
        break; 

        case 'bank_receipt':
        if (req.body.id) 
            pool.query('CALL SELECT_BANK_RECEIPT(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                dateParser(data?data[2]:null,field?field[2]:null)

                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['bankreceiptlineList1']=parsedLineData1;
                    field[0].push({name:'bankreceiptlineList1'})
                }

                let parsedLineData2=[];
                if (data && data[2] && data[0][0] && field[0] && field[2]) {
                    data[2].forEach(lineData=>
                        parsedLineData2.push(field[2].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['bankreceiptlineList2']=parsedLineData2;
                    field[0].push({name:'bankreceiptlineList2'})
                }

                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else pool.query('CALL SELECT_BANK_RECEIPTLIST()',(error,data,field)=>{

                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        break; 

        case 'bank_payment':
        if (req.body.id) 
            pool.query('CALL SELECT_BANK_PAYMENT(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                dateParser(data?data[2]:null,field?field[2]:null)

                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['bankpaymentlineList1']=parsedLineData1;
                    field[0].push({name:'bankpaymentlineList1'})
                }

                let parsedLineData2=[];
                if (data && data[2] && data[0][0] && field[0] && field[2]) {
                    data[2].forEach(lineData=>
                        parsedLineData2.push(field[2].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['bankpaymentlineList2']=parsedLineData2;
                    field[0].push({name:'bankpaymentlineList2'})
                }

                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else pool.query('CALL SELECT_BANK_PAYMENTLIST()',(error,data,field)=>{

                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        break; 

        case 'cash_receipt':
        if (req.body.id) 
            pool.query('CALL SELECT_CASH_RECEIPT(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                dateParser(data?data[2]:null,field?field[2]:null)

                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['cashreceiptlineList1']=parsedLineData1;
                    field[0].push({name:'cashreceiptlineList1'})
                }

                let parsedLineData2=[];
                if (data && data[2] && data[0][0] && field[0] && field[2]) {
                    data[2].forEach(lineData=>
                        parsedLineData2.push(field[2].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['cashreceiptlineList2']=parsedLineData2;
                    field[0].push({name:'cashreceiptlineList2'})
                }
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else pool.query('CALL SELECT_CASH_RECEIPTLIST()',(error,data,field)=>{

                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        break; 
        break; 

        case 'cash_payment':
        if (req.body.id) 
            pool.query('CALL SELECT_CASH_PAYMENT(?)',[req.body.id],(error,data,field)=>{
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                dateParser(data?data[2]:null,field?field[2]:null)

                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['cashpaymentlineList1']=parsedLineData1;
                    field[0].push({name:'cashpaymentlineList1'})
                }

                let parsedLineData2=[];
                if (data && data[2] && data[0][0] && field[0] && field[2]) {
                    data[2].forEach(lineData=>
                        parsedLineData2.push(field[2].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['cashpaymentlineList2']=parsedLineData2;
                    field[0].push({name:'cashpaymentlineList2'})
                }
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        else pool.query('CALL SELECT_CASH_PAYMENTLIST()',(error,data,field)=>{

                dateParser(data?data[0]:null,field?field[0]:null)
                res.send({error:error,data:data?data[0]:null,field:field?field[0]:null})
            })
        break; 

        case 'journal':
        if (req.body.id) 
            pool.query('CALL SELECT_JOURNAL(?)',[req.body.id],(error,data,field)=>{
                /*consolidate result from 2 select statements inside stored procedures to be remitted to App*/
                dateParser(data?data[0]:null,field?field[0]:null)
                dateParser(data?data[1]:null,field?field[1]:null)
                    
                let parsedLineData1=[];
                if (data && data[1] && data[0][0] && field[0] && field[1]) {
                    data[1].forEach(lineData=>
                        parsedLineData1.push(field[1].map(field=>
                            lineData[field.name]
                        ))
                    )
                    data[0][0]['journallineList1']=parsedLineData1;
                    field[0].push({name:'journallineList1'})
                }
                    
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