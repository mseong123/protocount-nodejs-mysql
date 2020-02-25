function getIDList (req,res,next,pool) {
    if (req.body) 
        pool.query('SELECT '+pool.escapeId(req.body.item+'_NUM')+' AS ID FROM '+ pool.escapeId(req.body.item),(error,data,field)=>
            res.send({error,data,field})
            
        )
    else next('Error happened during /getIDList request route.')
}

function getEligibleGLAccount (req,res,next,pool) {
    if (req.body) 
        switch(req.body.item) {
            case 'sales_invoice':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_CATEGORY="SALES" OR GL_CATEGORY="SALES ADJUSTMENTS"',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'debit_note':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_CATEGORY="SALES" OR GL_CATEGORY="SALES ADJUSTMENTS"',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'credit_note':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_CATEGORY="SALES" OR GL_CATEGORY="SALES ADJUSTMENTS"',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'purchase_invoice':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_CATEGORY="COST OF GOODS SOLD" OR GL_CATEGORY="EXPENSES"',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'purchase_debit_note':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_CATEGORY="COST OF GOODS SOLD" OR GL_CATEGORY="EXPENSES"',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'purchase_credit_note':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_CATEGORY="COST OF GOODS SOLD" OR GL_CATEGORY="EXPENSES"',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'bank_receipt':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_STATUS != "SPECIAL" ',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'bank_payment':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_STATUS != "SPECIAL" ',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'cash_receipt':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_DESC != "CASH IN HAND" AND GL_STATUS !="SPECIAL"',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'cash_payment':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_DESC != "CASH IN HAND" AND GL_STATUS !="SPECIAL"',(error,data,field)=>
                res.send({error,data,field})
            )
            break;

            case 'journal':
            pool.query('SELECT GL_ACC_NUM,GL_DESC FROM gl WHERE GL_STATUS != "SPECIAL" ',(error,data,field)=>
                res.send({error,data,field})
            )
            break;
        }
        
        
     else next('Error happened during /getEligibleGLAccount request route.')

        
}

module.exports.getIDList=getIDList;
module.exports.getEligibleGLAccount=getEligibleGLAccount;