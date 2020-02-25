function DateParser(data,field) {
    if (data && field)
           data.forEach(data=>{
            field.forEach(field=>{
                if(data[field.name] && typeof data[field.name].getMonth==='function') {
                    /*Month 1-12 if <10, add '0' in front */
                    const month = data[field.name].getMonth() + 1 <10 ? 
                    '0'+ (data[field.name].getMonth() + 1) : data[field.name].getMonth() + 1; 
                    /*if <10,add '0' in front */
                    const day = data[field.name].getDate() < 10? 
                    '0' + data[field.name].getDate() : data[field.name].getDate();
                    const year = data[field.name].getFullYear();
                    data[field.name]=year+'-'+month+'-'+day;
                }       
            })
        })
}

module.exports=DateParser;