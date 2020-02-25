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
        let initialDeliveryOrderInput=[];
        let combinedDeliveryOrderlineString;
        req.body.param.forEach(input=>{
            if (input) /*to ensure null values not parsed and cause error*/
                if(typeof input.forEach==='function')
                /*stringify all stock inputs and combine them */
                combinedDeliveryOrderlineString=(combinedDeliveryOrderlineString? combinedDeliveryOrderlineString+'=':'') + input.map(input=>
                    JSON.stringify(input)).join(); 
                else initialDeliveryOrderInput.push(input)
            else initialDeliveryOrderInput.push(input)
            
        })        
        pool.query('CALL INSERT_DELIVERY_ORDER(?,?,?,?,?,?,?,?)',[...initialDeliveryOrderInput,combinedDeliveryOrderlineString],(error,data,field)=>{
            res.send({error,data,field});
        });
        
        break;

        case 'sales_invoice':
        let initialSalesInvoiceInput=[];
        let combinedSalesInvoicelineString;
        req.body.param.forEach(input=>{
            if (input) /*to ensure null values not parsed and cause error*/
                if(typeof input.forEach==='function')
                /*stringify all stock inputs and combine them */
                combinedSalesInvoicelineString=(combinedSalesInvoicelineString? combinedSalesInvoicelineString+'=':'') + input.map(input=>
                    JSON.stringify(input)).join(); 
                else initialSalesInvoiceInput.push(input)
            else initialSalesInvoiceInput.push(input)
            
        })        
        pool.query('CALL INSERT_SALES_INVOICE(?,?,?,?,?,?,?,?,?)',[...initialSalesInvoiceInput,combinedSalesInvoicelineString],(error,data,field)=>{
            res.send({error,data,field});
        });
        
        break;

        case 'debit_note':
        let initialDebitNoteInput=[];
        let combinedDebitNotelineString;
        req.body.param.forEach(input=>{
            if (input) /*to ensure null values not parsed and cause error*/
                if(typeof input.forEach==='function')
                /*stringify all stock inputs and combine them */
                combinedDebitNotelineString=(combinedDebitNotelineString? combinedDebitNotelineString+'=':'') + input.map(input=>
                    JSON.stringify(input)).join(); 
                else initialDebitNoteInput.push(input)
            else initialDebitNoteInput.push(input)
            
        })        
        pool.query('CALL INSERT_DEBIT_NOTE(?,?,?,?,?,?,?,?,?)',[...initialDebitNoteInput,combinedDebitNotelineString],(error,data,field)=>{
            res.send({error,data,field});
        });
        
        break;

        case 'credit_note':
        let initialCreditNoteInput=[];
        let combinedCreditNotelineString;
        req.body.param.forEach(input=>{
            if (input) /*to ensure null values not parsed and cause error*/
                if(typeof input.forEach==='function')
                /*stringify all stock inputs and combine them */
                combinedCreditNotelineString=(combinedCreditNotelineString? combinedCreditNotelineString+'=':'') + input.map(input=>
                    JSON.stringify(input)).join(); 
                else initialCreditNoteInput.push(input)
            else initialCreditNoteInput.push(input)
            
        })        
        pool.query('CALL INSERT_CREDIT_NOTE(?,?,?,?,?,?,?,?,?)',[...initialCreditNoteInput,combinedCreditNotelineString],(error,data,field)=>{
            res.send({error,data,field});
        });
        
        break;

        case 'purchase_invoice':
        let initialPurchaseInvoiceInput=[];
        let combinedPurchaseInvoicelineString;
        
        req.body.param.forEach(input=>{
            if (input) /*to ensure null values not parsed and cause error*/
                if(typeof input.forEach==='function')
                /*stringify all stock inputs and combine them */
                combinedPurchaseInvoicelineString=(combinedPurchaseInvoicelineString? combinedPurchaseInvoicelineString+'=':'') + input.map(input=>
                    JSON.stringify(input)).join(); 
                else initialPurchaseInvoiceInput.push(input)
            else initialPurchaseInvoiceInput.push(input)
            
        })     
        pool.query('CALL INSERT_PURCHASE_INVOICE(?,?,?,?,?,?,?,?,?)',[...initialPurchaseInvoiceInput,combinedPurchaseInvoicelineString],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'purchase_debit_note':
        let initialPurchaseDebitNoteInput=[];
        let combinedPurchaseDebitNotelineString;
        
        req.body.param.forEach(input=>{
            if (input) /*to ensure null values not parsed and cause error*/
                if(typeof input.forEach==='function')
                /*stringify all stock inputs and combine them */
                combinedPurchaseDebitNotelineString=(combinedPurchaseDebitNotelineString? combinedPurchaseDebitNotelineString+'=':'') + input.map(input=>
                    JSON.stringify(input)).join(); 
                else initialPurchaseDebitNoteInput.push(input)
            else initialPurchaseDebitNoteInput.push(input)
            
        })     
        pool.query('CALL INSERT_PURCHASE_DEBIT_NOTE(?,?,?,?,?,?,?,?,?)',[...initialPurchaseDebitNoteInput,combinedPurchaseDebitNotelineString],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'purchase_credit_note':
        let initialPurchaseCreditNoteInput=[];
        let combinedPurchaseCreditNotelineString;
        
        req.body.param.forEach(input=>{
            if (input) /*to ensure null values not parsed and cause error*/
                if(typeof input.forEach==='function')
                /*stringify all stock inputs and combine them */
                combinedPurchaseCreditNotelineString=(combinedPurchaseCreditNotelineString? combinedPurchaseCreditNotelineString+'=':'') + input.map(input=>
                    JSON.stringify(input)).join(); 
                else initialPurchaseCreditNoteInput.push(input)
            else initialPurchaseCreditNoteInput.push(input)
            
        })     
        pool.query('CALL INSERT_PURCHASE_CREDIT_NOTE(?,?,?,?,?,?,?,?,?)',[...initialPurchaseCreditNoteInput,combinedPurchaseCreditNotelineString],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'bank':
        pool.query('CALL INSERT_BANK(?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'bank_receipt':
        pool.query('CALL INSERT_BANK_RECEIPT(?,?,?,?,?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'bank_payment':
        pool.query('CALL INSERT_BANK_PAYMENT(?,?,?,?,?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'cash_receipt':
        pool.query('CALL INSERT_CASH_RECEIPT(?,?,?,?,?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'cash_payment':
        pool.query('CALL INSERT_CASH_PAYMENT(?,?,?,?,?,?,?,?,?,?)',[...req.body.param],(error,data,field)=>{
            res.send({error,data,field});
        })
        break;

        case 'journal':
        let initialJournalInput=[];
        let combinedJournallineString;
        req.body.param.forEach(input=>{
            if (input) /*to ensure null values not parsed and cause error*/
                if(typeof input.forEach==='function')
                /*stringify all stock inputs and combine them */
                combinedJournallineString=(combinedJournallineString? combinedJournallineString+'=':'') + input.map(input=>
                    JSON.stringify(input)).join(); 
                else initialJournalInput.push(input)
            else initialJournalInput.push(input)
            
        })     
        pool.query('CALL INSERT_JOURNAL(?,?,?,?,?)',[...initialJournalInput,combinedJournallineString],(error,data,field)=>{
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