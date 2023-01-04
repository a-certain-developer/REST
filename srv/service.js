const cds = require("@sap/cds");

class RESTService extends cds.ApplicationService {
  async init() {

    this.on("getBills" , async (req) => {
  
      const billsSrv = await cds.connect.to("Bills");
      const billData = await billsSrv.send("bills"
   
      
      
      
      );
      
      

      return {
        id :billData.bills.id,
        documentNumber: billData.documentNumber,
        billingType: billData.billingType
  
      };
    });

    await super.init();
  }
}


module.exports = RESTService;