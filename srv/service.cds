using { Bank_Read } from './external/Bank_Read.cds';

using { REST as my } from '../db/schema';

using REST from '../db/schema';

@path : 'service/REST'
service RESTService
{
  type Bill : {
   id   : String;
   documentNumber : Integer64;
   billingType : String 
  }


    function getBills() returns many Bill;
  


    entity A_BankDetail as
        projection on Bank_Read.A_BankDetail
        {
            BankInternalID,
            BankName,
            BankNumber
        };
}

annotate RESTService with @requires :
[
    'authenticated-user'
];
