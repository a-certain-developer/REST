/* checksum : e8600475e9b0beb95e3272f734b110ff */
@Capabilities.BatchSupported : false
@Capabilities.KeyAsSegmentSupported : true
@Core.Description : 'Bills'
@Core.SchemaVersion : '2'
@Core.LongDescription : 'Enables you to retrieve bills, influence their life cycle, and manage the interaction with follow-on processes such as credit card payment settlement and invoicing.'
service Bills {};

@Common.Label : 'Basic Functions for Bills'
@Core.Description : 'Retrieves bills.'
@Core.LongDescription : 'Bills without effective charges (or credits) are automatically excluded from the response. These are bills that only contain charges (or credits) that have been balanced out as a result of changes in the subscription or the rate plan. Examples of such changes are subscription withdrawal, subscription cancellation, and price changes. <br>Charges (or credits) with a monetary value of zero are included in the response. For example, usage-based charges for which no usage was reported yet.'
@openapi.path : '/bills'
function Bills.bills(
) returns Bills_types.bills;

@Common.Label : 'Bill Life Cycle'
@Core.Description : 'Submits a mass closing request.'
@Core.LongDescription : 'Submits a mass closing request that will be processed asynchronously. You can fetch the processing result with the GET endpoint. <br>Once closed, a bill cannot be reopened. Any usage data that is relevant for the bill and received after the bill is closed does **not** update the closed bill. Neither is an additional bill created for this usage. This is the case even if usage records are created successfully.'
@openapi.path : '/bills/closing'
action Bills.bills_closing_post(
  @openapi.in : 'body'
  body : Bills_types.massClosingRequestPost
);

@Common.Label : 'Bill Life Cycle'
@Core.Description : 'Retrieves mass closing requests.'
@Core.LongDescription : 'Retrieves all mass closing requests of the last 90 days. Note that requests are only kept for 90 days after the mass closing request was completed.'
@openapi.path : '/bills/closing'
function Bills.bills_closing(
  @description : 'The page number to be retrieved, where the size of the pages must be specified by the `pageSize` parameter.<br>The number of the first page is 1.'
  @openapi.in : 'query'
  pageNumber : String,
  @description : 'The number of processed bills retrieved on each page. The page size must be greater or equal to 1. Maximum page size is 100. If not specified a default page size of 40 is applied'
  @openapi.in : 'query'
  pageSize : Integer,
  @description : 'If `false`, the response headers `x-count` and `x-pagecount` will not be returned. The recommended setting is `false` if not otherwise required by a special use case, as this results in a significantly faster response time.'
  @openapi.in : 'query'
  @openapi.name : '$count'
  _count : Boolean
) returns many Bills_types.massClosingRequestList;

@Common.Label : 'Bill Life Cycle'
@Core.Description : 'Retrieves a mass closing request.'
@Core.LongDescription : 'Retrieves a single mass closing request with a specific identifier. Note that requests are only kept for 90 days after the mass closing request was completed.'
@openapi.path : '/bills/closing/{massClosingRequestId}'
function Bills.bills_closing_(
  @description : 'The mass closing request ID'
  @openapi.in : 'path'
  massClosingRequestId : String
) returns Bills_types.massClosingRequestDetail;

@Common.Label : 'Bill Life Cycle'
@Core.Description : 'Retrieves bills processed by a mass closing request.'
@Core.LongDescription : 'Retrieves a paginated list of bills processed by a mass closing request. This enables you to retrieve all processed bills if more than 40 bills are included in the mass closing request. '
@openapi.path : '/bills/closing/{massClosingRequestId}/processedBills'
function Bills.bills_closing__processedBills(
  @description : 'The identifier of the mass closing request.'
  @openapi.in : 'path'
  massClosingRequestId : String,
  @description : 'The page number to be retrieved, where the size of the pages must be specified by the `pageSize` parameter.<br>The number of the first page is 1.'
  @openapi.in : 'query'
  pageNumber : String,
  @description : 'The number of processed bills retrieved on each page. The page size must be greater or equal to 1. Maximum page size is 100. If not specified a default page size of 40 is applied'
  @openapi.in : 'query'
  pageSize : Integer,
  @description : 'If `false`, the response headers `link`, `x-count` and `x-pagecount` will not be returned. The recommended setting is `false` if not otherwise required by a special use case, as this results in a significantly faster response time.'
  @openapi.in : 'query'
  @openapi.name : '$count'
  _count : Boolean
) returns many Bills_types.massClosingRequestProcessedBill;

@Common.Label : 'Basic Functions for Bills'
@Core.Description : 'Retrieves a bill.'
@Core.LongDescription : 'Optional information, for example credit card data, can be added using dedicated keywords. <br>If the requested bill has no effective charges (or credits), it is automatically excluded from the response. A bill can have no effective charges (or credits) if it only contains charges (or credits) that have been balanced out as a result of changes in the subscription or the rate plan. Examples of such changes are subscription withdrawal, subscription cancellation, and price changes.<br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/841f5b6a4cab45aeb5dccd9704177fd4.html) for important information.'
@openapi.path : '/bills/{identifier}'
function Bills.bills_(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String,
  @description : 'Include certain additional properties within the bill by providing a comma-separated list of supported keywords. Properties are included in the response automatically when a filter query is applied to them. <br>Note that if you use the keyword `originalBillReference` on its own, you will get a 400 error if the original bill is still open. This is not the case if you use the keyword `all`. <br>Note that the value `tax` is obsolete. <br>Please be aware that SAP may later include further properties in the default, non-expanded response. Therefore you should not rely on certain properties being absent from the response when you do not use the `expand` query parameter.'
  @openapi.in : 'query'
  @openapi.explode : false
  expand : many Bills.anonymous.type4,
  @description : 'Exclude zero-amount charges or/and credits from the response by providing the keyword `charges`, `credits` or both. Bill items with only zero-amount charges/credits are also excluded. In case there are no bill items left, the response status is 204 and no response body is provided. If keyword `billItems` is provided, bill items with a total amount of zero are excluded from the response. If all items of the requested bill have zero total amounts, the response status is 204 and no response body is provided.'
  @openapi.in : 'query'
  @openapi.explode : false
  excludeZeroAmounts : many Bills.anonymous.type5
) returns Bills_types.bill;

@Common.Label : 'Event Log'
@Core.Description : 'Retrieves the complete event log of a bill.'
@Core.LongDescription : 'Note that the event log is built up only from the day that it became available in your tenant (October 28/29, 2020). Therefore, the event log will not include any changes to the bill that took place before the delivery of the event log feature.'
@openapi.path : '/bills/{identifier}/eventlog'
function Bills.bills__eventlog(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
) returns Bills_types.eventLog;

@Common.Label : 'Bill Life Cycle'
@Core.Description : 'Closes a bill immediately.'
@Core.LongDescription : 'Once closed, a bill cannot be reopened. Any usage data that is relevant for the bill and received after the bill is closed does **not** update the closed bill. Neither is an additional bill created for this usage. This is the case even if usage records are created successfully.<br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/8b03a0ba5bea4abe9712f833c633f8d9.html) for important information.'
@openapi.path : '/bills/{identifier}/closing'
action Bills.bills__closing_post(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
);

@Common.Label : 'Bill Life Cycle'
@Core.Description : 'Sets the bill closing method.'
@Core.LongDescription : 'By default, bills are closed automatically when the billing date is reached. However, you can prevent automatic closing by specifying that a bill must be closed manually.<br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/27ddce7d0f18444eb673ca6328ff540d.html) for important information.'
@openapi.method : 'PATCH'
@openapi.path : '/bills/{identifier}/closing'
action Bills.bills__closing_patch(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
);

@Common.Label : 'Basic Functions for Bills'
@Core.Description : 'Retrieves metadata.'
@Core.LongDescription : 'Retrieves the metadata of a bill.'
@openapi.path : '/bills/{identifier}/metaData'
function Bills.bills__metaData(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
) returns Bills_types.metaData;

@Common.Label : 'Basic Functions for Bills'
@Core.Description : 'Retrieves credit card information.'
@Core.LongDescription : 'Retrieves credit card information for a bill.'
@openapi.path : '/bills/{identifier}/creditCard'
function Bills.bills__creditCard(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
) returns Bills_types.creditCard;

@Common.Label : 'Credit Card Payment Settlement'
@Core.Description : 'Retriggers settlement of credit card payments.'
@Core.LongDescription : 'Retriggers the settlement of credit card payment for a closed bill with the payment status `FAILED` or `ERROR`.<br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/cb53410361214d5a8546d33ad171e73e.html) for important information.<br>Note that you can only use this endpoint if you have integrated with SAP digital payments add-on and have chosen to trigger the settlement of credit card payments from SAP Subscription Billing.'
@openapi.path : '/bills/{identifier}/creditCard/settlement'
action Bills.bills__creditCard_settlement_post(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
) returns Bills_types.creditCardSettlementsPostResponse;

@Common.Label : 'Bill Transfer'
@Core.Description : 'Indicates transfer of a bill to invoicing.'
@Core.LongDescription : 'You can use this endpoint to change the transfer status of a bill from `NOT_TRANSFERRED` to `TRANSFER_IN_PROGRESS`. Bills with the status `TRANSFER_IN_PROGRESS` will not be retrieved by the `/bills/transferable` (GET) endpoint. <br>Before you use this operation, check the [API Guide](https://help.sap.com/docs/CLOUD_TO_CASH_OD/987aec876092428f88162e438acf80d6/6c0713612f58481fb4c68bf3890dc7d5.html) for important information.<br>In SAP-defined integrations, the transfer status `TRANSFER_IN_PROGRESS` is set automatically when transfer begins. If you use a customer-defined integration, or if you set up integration before the status `TRANSFER_IN_PROGRESS` was added to the predefined integration content, you can use this endpoint to set the status and prevent duplicate transfers.'
@openapi.path : '/bills/{identifier}/transferring'
action Bills.bills__transferring_post(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
);

@Common.Label : 'Bill Transfer'
@Core.Description : 'Retrieves a list of successor documents.'
@Core.LongDescription : 'Retrieves a list of successor documents for a specific bill.'
@openapi.path : '/bills/{identifier}/successorDocuments'
function Bills.bills__successorDocuments(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String,
  @description : 'The page number to be retrieved, where the size of the pages must be specified by the `pageSize` parameter.<br>The number of the first page is 1.'
  @openapi.in : 'query'
  pageNumber : Integer,
  @description : 'The number of bills retrieved on each page. The page size must be greater or equal to 1. Maximum page size is 100.'
  @openapi.in : 'query'
  pageSize : Integer,
  @description : 'If `false`, the response headers `x-count` and `x-pagecount` will not be returned. The recommended setting is `false` if not otherwise required by a special use case, as this results in a significantly faster response time.'
  @openapi.in : 'query'
  @openapi.name : '$count'
  _count : Boolean
) returns many Bills_types.successorDocumentGetResponse;

@Common.Label : 'Bill Transfer'
@Core.Description : 'Manages successor documents of a bill.'
@Core.LongDescription : 'Successor documents are follow-up documents in other systems, for example, invoices in SAP S/4HANA.<br>For successor documents to be added, a bill must be closed and marked as relevant for the invoice creation.<br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/df3d444416664e6d8591ac6f6261d708.html) for important information.'
@openapi.path : '/bills/{identifier}/successorDocuments'
action Bills.bills__successorDocuments_post(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String,
  @openapi.in : 'body'
  body : Bills_types.successorDocumentPostRequest
) returns Bills_types.success;

@Common.Label : 'Bill Transfer'
@Core.Description : 'Deletes all successor document references of a bill.'
@Core.LongDescription : 'You can delete successor document references if at least one successor document was not created due to a failure during transfer of billing data to another system.<br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/df3d444416664e6d8591ac6f6261d708.html) for important information.'
@openapi.method : 'DELETE'
@openapi.path : '/bills/{identifier}/successorDocuments'
action Bills.bills__successorDocuments_delete(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
);

@Common.Label : 'Bill Transfer'
@Core.Description : 'Retrieves a list of failed transfer attempts.'
@Core.LongDescription : 'Retrieves a list of failed transfer attempts for a specific bill.'
@openapi.path : '/bills/{identifier}/successorDocuments/failedAttempts'
function Bills.bills__successorDocuments_failedAttempts(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String,
  @description : 'The page number to be retrieved, where the size of the pages must be specified by the `pageSize` parameter.<br>The number of the first page is 1.'
  @openapi.in : 'query'
  pageNumber : Integer,
  @description : 'The number of bills retrieved on each page. The page size must be greater or equal to 1. Maximum page size is 100.'
  @openapi.in : 'query'
  pageSize : Integer,
  @description : 'If `false`, the response headers `x-count` and `x-pagecount` will not be returned. The recommended setting is `false` if not otherwise required by a special use case, as this results in a significantly faster response time.'
  @openapi.in : 'query'
  @openapi.name : '$count'
  _count : Boolean
) returns many Bills_types.failedAttemptGetResponse;

@Common.Label : 'Bill Transfer'
@Core.Description : 'Manages failed transfer attempts of a bill.'
@Core.LongDescription : 'You can report failed attempts to transfer billing data and create successor documents in other systems. <br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/df3d444416664e6d8591ac6f6261d708.html) for important information.'
@openapi.path : '/bills/{identifier}/successorDocuments/failedAttempts'
action Bills.bills__successorDocuments_failedAttempts_post(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String,
  @openapi.in : 'body'
  body : Bills_types.failedAttemptPostRequest
) returns Bills_types.success;

@Common.Label : 'Bill Transfer'
@Core.Description : 'Deletes all failed transfer attempts of a bill.'
@Core.LongDescription : `Failed transfer attempts can be reported during the transfer of billing data to other systems. The transfer fails if a successor document cannot be created. You can delete the failed attempts, for example in order to enable a retry of the transfer.
<br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/df3d444416664e6d8591ac6f6261d708.html) for important information.`
@openapi.method : 'DELETE'
@openapi.path : '/bills/{identifier}/successorDocuments/failedAttempts'
action Bills.bills__successorDocuments_failedAttempts_delete(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String
);

@Common.Label : 'Bill Transfer'
@Core.Description : 'Retrieves the invoice PDF document.'
@Core.LongDescription : 'Retrieve the invoice PDF document that is stored in a successor document system.<br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/197824c110e24b08a0db3f8944251a0f.html) for important information.'
@openapi.path : '/bills/{identifier}/successorDocuments/{documentSystem}/{documentIdentifier}'
function Bills.bills__successorDocuments__(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String,
  @description : 'The successor document system to which the bill was transferred.'
  @openapi.in : 'path'
  documentSystem : String,
  @description : 'The invoice ID for the bill in the successor document system.'
  @openapi.in : 'path'
  documentIdentifier : String
) returns Boolean;

@Common.Label : 'Bill Transfer'
@Core.Description : 'Retrieves transferable bills.'
@Core.LongDescription : 'Retrieve the identifiers of bills that are ready for transfer to external systems for further processing, such as invoicing. Bills are ready for transfer if they are closed (`billStatus` is `CLOSED`), they have not yet been transferred (`transferStatus` is `NOT_TRANSFERRED`) and they do not yet have a successor document or failed transfer attempt assigned.<br>Bills for subscriptions of the type *Internal Billing* are not retrieved. If you want to prevent certain bills from being transferred (for example, for testing purposes), you can set this subscription type in the product or subscription. <br>Bills without effective charges (or credits) are automatically excluded from the response. These are bills that contain only charges (or credits) that have been balanced out as a result of changes in the subscription or the rate plan. Examples of such changes are subscription withdrawal, subscription cancellation, and price changes.<br> Note: The criteria that make a bill transferable may in future also relate to other properties of a bill due to functional developments. Therefore you should not assume that a query of the `/bills` resource with the above query parameters will return the same bills as `/bills/transferable` in the future.'
@openapi.path : '/bills/transferable'
function Bills.bills_transferable(
  @description : 'The first billing date for which you want to retrieve bills.<br>The date must be in the format YYYY-MM-DD .'
  @openapi.in : 'query'
  ![from] : Date,
  @description : 'The day **after** the last billing date for which you want to retrieve bills. For example, you can retrieve bills with a billing date within a particular month by entering the first of the following month for the `to` parameter.<br>The date must be in the format YYYY-MM-DD .'
  @openapi.in : 'query'
  to : Date,
  @description : 'The bill split element for which you want to retrieve bills.'
  @openapi.in : 'query'
  splitElement : String,
  @assert.range : true
  @description : 'The billing type for which you want to retrieve bills.'
  @openapi.in : 'query'
  billingType : String enum {
    CHARGE;
    CREDIT;
  },
  @description : 'The identifier of the market for which you want to retrieve bills.'
  @openapi.in : 'query'
  @openapi.name : 'market.id'
  market_id : String,
  @description : 'The identifier of the customer for which you want to retrieve bills.'
  @openapi.in : 'query'
  @openapi.name : 'customer.id'
  customer_id : String,
  @description : 'The identifier of the subscription for which you want to retrieve bills.'
  @openapi.in : 'query'
  @openapi.name : 'billItems.subscription.id'
  billItems_subscription_id : String,
  @description : 'The document number of the subscription for which you want to retrieve bills.'
  @openapi.in : 'query'
  @openapi.name : 'billItems.subscription.documentNumber'
  billItems_subscription_documentNumber : Integer64,
  @description : 'The identifier of the product for which you want to retrieve bills.'
  @openapi.in : 'query'
  @openapi.name : 'billItems.product.id'
  billItems_product_id : String,
  @description : 'The identifier of the rate plan for which you want to retrieve bills.'
  @openapi.in : 'query'
  @openapi.name : 'billItems.ratePlan.id'
  billItems_ratePlan_id : String,
  @description : 'The type code and ID of a custom reference for which you want to retrieve bills. The type code defines the reference type in Business Configuration. The ID is the value of the custom reference.<br>Add the string at end of request in the format `?billItems.customReferences.<typeCode>=<id>` for example:  `?billItems.customReferences.PO=4711`<br>You can select multiple references, for example: `?billItems.customReferences.PO=4711&billItems.customReferences.PC=47`'
  @openapi.in : 'query'
  @openapi.name : 'billItems.customReferences.<typeCode>'
  billItems_customReferences__typeCode_ : String,
  @description : 'The page number to be retrieved, where the size of the pages must be specified by the `pageSize` parameter.<br>The number of the first page is 1.'
  @openapi.in : 'query'
  pageNumber : Integer,
  @description : 'The number of bills retrieved on each page. The page size must be greater or equal to 1. Maximum page size is 100.'
  @openapi.in : 'query'
  pageSize : Integer,
  @description : 'If `false`, the response headers `x-count` and `x-pagecount` will not be returned. The recommended setting is `false` if not otherwise required by a special use case, as this results in a significantly faster response time.'
  @openapi.in : 'query'
  @openapi.name : '$count'
  _count : Boolean
) returns Bills_types.billIds;

@Common.Label : 'Bill Item Deletion'
@Core.Description : 'Deletes items from closed bills.'
@Core.LongDescription : 'You can delete bill items that are marked for deletion from closed bills. Items of closed bills are marked for deletion when the respective subscription is deleted. <br>Caution: You should only delete subscriptions and their associated bills before productive use of SAP Subscription Billing. The deletion is not reversible and SAP cannot restore deleted data. <br>Before you use this operation, check the [API Guide](https://help.sap.com/viewer/987aec876092428f88162e438acf80d6/latest/en-US/e1843e7189bd40c3b7eea08748bbb584.html) for important information.'
@openapi.method : 'DELETE'
@openapi.path : '/deletableBillItems'
action Bills.deletableBillItems_delete(
  @description : 'If `true` the bill items in scope of this request will not be deleted, but just listed in the response.'
  @openapi.in : 'query'
  @openapi.required : true
  simulation : Boolean,
  @description : 'The ID of the subscription for which you want to delete bill items.'
  @openapi.in : 'query'
  @openapi.name : 'billItems.subscription.id'
  billItems_subscription_id : String,
  @description : 'The ID of the subscription item for which you want to delete bill items.'
  @openapi.in : 'query'
  @openapi.name : 'billItems.subscription.item.id'
  billItems_subscription_item_id : String,
  @description : 'The ID of the bill containing items that you want to delete.'
  @openapi.in : 'query'
  @openapi.name : 'bill.id'
  bill_id : String,
  @description : 'The document number of the bill containing items that you want to delete'
  @openapi.in : 'query'
  @openapi.name : 'bill.documentNumber'
  bill_documentNumber : Integer64,
  @description : 'The billing date starting from which you want to delete bill items.<br>The date must be in the format YYYY-MM-DD.'
  @openapi.in : 'query'
  @openapi.name : 'bill.billingDate.from'
  bill_billingDate_from : Date,
  @description : 'The day **after** the last billing date for which you want to delete bill items. The date must be in the format YYYY-MM-DD.'
  @openapi.in : 'query'
  @openapi.name : 'bill.billingDate.to'
  bill_billingDate_to : Date
);

@Common.Label : 'Bill Item Deletion'
@Core.Description : 'Retrieves deletion logs.'
@Core.LongDescription : 'Retrieves all deletion logs of the last 90 days. Deletion logs provide information about deletion requests. Note that logs are only kept for 90 days after the deletion request was completed.'
@openapi.path : '/deletableBillItems/deletionLogs'
function Bills.deletableBillItems_deletionLogs() returns many Bills_types.deletionLogList;

@Common.Label : 'Bill Item Deletion'
@Core.Description : 'Retrieves a deletion log.'
@Core.LongDescription : 'Retrieves a single deletion log with a specific identifier. Deletion logs provide information about deletion requests. Note that logs are only kept for 90 days after the deletion request was completed.'
@openapi.path : '/deletableBillItems/deletionLogs/{deletionLogId}'
function Bills.deletableBillItems_deletionLogs_(
  @description : 'The deletion log ID'
  @openapi.in : 'path'
  deletionLogId : String
) returns Bills_types.billItemDeletionLog;

@Common.Label : 'Bill Item Deletion'
@Core.Description : 'Retrieves the deleted bill items from a deletion log.'
@Core.LongDescription : 'Retrieves a paginated list of deleted bill items from a deletion log. This enables you to retrieve all deleted items if more than 40 items are included in the deletion log. '
@openapi.path : '/deletableBillItems/deletionLogs/{deletionLogId}/deletedItems'
function Bills.deletableBillItems_deletionLogs__deletedItems(
  @description : 'The deletion log ID'
  @openapi.in : 'path'
  deletionLogId : String,
  @description : 'The page number to be retrieved, where the size of the pages must be specified by the `pageSize` parameter.<br>The number of the first page is 1.'
  @openapi.in : 'query'
  pageNumber : String,
  @description : 'The number of deleted items retrieved on each page. The page size must be greater or equal to 1. Maximum page size is 100. If not specified a default page size of 40 is applied'
  @openapi.in : 'query'
  pageSize : Integer
) returns many Bills_types.deletionLogDeletedItem;

@Common.Label : 'Usage Records'
@Core.Description : 'Retrieves the usage records for a charge.'
@Core.LongDescription : 'Retrieves a paginated list of usage records that are relevant for a charge. <br>Note: This API can only be used in combination with the GET /bills/{id} API. <br>There you will find in the response body the fully specified path for GET /bills/{identifier}/billItems/{itemId}/charges/{chargeId}/usageRecords under the following conditions: <br> 1.The expand parameter usageRecords is used. <br>2.The value of usageRecords of a specific charge is more than 100. <br>Only in this case, you will get the fully specified path for this API in the response body.<br>For example: usageRecords@nextLink:bills/A7E98BC8-329B-4742-B0AF-BF2034EB0908/billItems/D1277873-01D3-4AE3-A521-E008CEA1EDC4/charges/27A9756C-213E-4116-8B13-BFD62B1F41F4/usageRecords?pageNumber=2&pageSize=100.'
@openapi.path : '/bills/{identifier}/billItems/{itemId}/charges/{chargeId}/usageRecords'
function Bills.bills__billItems__charges__usageRecords(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String,
  @description : 'The unique identifier of the bill item.'
  @openapi.in : 'path'
  itemId : String,
  @description : 'The unique identifier of the credit.'
  @openapi.in : 'path'
  chargeId : String,
  @description : 'The page number to be retrieved, where the size of the pages must be specified by the `pageSize` parameter.<br>The number of the first page is 1.'
  @openapi.in : 'query'
  pageNumber : String,
  @description : 'The number of usage records retrieved on each page. The page size must be greater or equal to 1. Maximum page size is 100. If not specified a default page size of 100 is applied.'
  @openapi.in : 'query'
  pageSize : Integer
) returns many Bills_types.usageRecord;

@Common.Label : 'Usage Records'
@Core.Description : 'Retrieves the usage records for a credit.'
@Core.LongDescription : 'Retrieves a paginated list of usage records that are relevant for a credit. <br>Note: This API can only be used in combination with the GET /bills/{id} API. <br>There you will find in the response body the fully specified path for GET /bills/{identifier}/billItems/{itemId}/credits/{creditId}/usageRecords under the following conditions: <br> 1.The expand parameter usageRecords is used. <br>2.The value of usageRecords of a specific credit is more than 100. <br>Only in this case, you will get the fully specified path for this API in the response body. <br>For example: usageRecords@nextLink:bills/A7E98BC8-329B-4742-B0AF-BF2034EB0908/billItems/D1277873-01D3-4AE3-A521-E008CEA1EDC4/credits/27A9756C-213E-4116-8B13-BFD62B1F41F4/usageRecords?pageNumber=2&pageSize=100.'
@openapi.path : '/bills/{identifier}/billItems/{itemId}/credits/{creditId}/usageRecords'
function Bills.bills__billItems__credits__usageRecords(
  @description : 'The ID or document number of the bill.'
  @openapi.in : 'path'
  identifier : String,
  @description : 'The unique identifier of the bill item.'
  @openapi.in : 'path'
  itemId : String,
  @description : 'The unique identifier of the credit.'
  @openapi.in : 'path'
  creditId : String,
  @description : 'The page number to be retrieved, where the size of the pages must be specified by the `pageSize` parameter.<br>The number of the first page is 1.'
  @openapi.in : 'query'
  pageNumber : String,
  @description : 'The number of usage records retrieved on each page. The page size must be greater or equal to 1. Maximum page size is 100. If not specified a default page size of 100 is applied.'
  @openapi.in : 'query'
  pageSize : Integer
) returns many Bills_types.usageRecord;

@title : 'Bill'
type Bills_types.bill {
  @description : 'The unique identifier of the bill.'
  id : String;
  @description : 'The document number of the bill. The document number is unique per tenant.'
  documentNumber : Integer64;
  metaData : Bills_types.metaData;
  @description : `Defines whether the bill contains charges or credits. Charges and credits are never on the same bill. 
However, future changes to the API may introduce this possibility and indicate it via this property.`
  @assert.range : true
  billingType : String enum {
    CHARGE;
    CREDIT;
  };
  market : Bills_types.market;
  @description : 'The time zone of the subscription, as named in the IANA Time Zone Database. If it wasn''t provided when creating the subscription, the time zone is set to the time zone of the market. This field overrides the time zone of the market if the values differ. '
  timeZone : String;
  @description : 'The date on which all charges or credits that will be included in the bill become due. On the due date the billing delay starts.'
  dueDate : Date;
  @description : 'The legal date of the bill, considering the time zone of the market.'
  billingDate : Date;
  @description : 'The identifier of the billing profile that was applied when the bill was created.'
  billingProfileId : String;
  billingPeriod : Bills_types.billingPeriod;
  @description : 'Status that indicates whether the bill is open for changes. The bill is open until the billing date is reached. The status `CLOSING` is an intermediate state indicating that final processing steps are taking place to close the bill. This should not take more than a few minutes.'
  @assert.range : true
  billStatus : String enum {
    OPEN;
    CLOSING;
    CLOSED;
  };
  closing : Bills_types.closing;
  @description : 'Status that indicates whether the bill was transferred to a successor system. <br>`TRANSFERRED` shows that at least one successor document is assigned. Successor documents can be assigned and viewed using the `/bills/{identifier}/successorDocuments` resource.<br>`FAILED_PARTIALLY` shows that at least one successor document was created and at least one transfer attempt failed.<br>`FAILED` shows that no successor documents were created.'
  @assert.range : true
  transferStatus : String enum {
    NOT_RELEVANT;
    NOT_TRANSFERRED;
    TRANSFERRED;
    FAILED;
    FAILED_PARTIALLY;
  };
  @description : 'An attribute that causes a separate bill to be created for a subscription. For example, if you provide the purchase order number as the bill split element, subscriptions for different purchase orders will be billed separately.'
  splitElement : String;
  @description : 'The contract account in SAP S/4HANA that is used to define payment methods, the dunning procedure, and tolerances, for example. The contract account is derived from the subscription if specified there.'
  contractAccount : String;
  @description : 'Indicator that determines if an invoice will be created for the bill.'
  createInvoice : Boolean;
  customer : Bills_types.customer;
  @description : 'The party that pays for the subscription.'
  payer : Bills_types.partner;
  @description : 'The party that receives the invoice for the subscription. The bill-to party can be, but is not necessarily, the payer of the invoice.'
  billTo : Bills_types.partner;
  payment : Bills_types.payment;
  netAmount : Bills_types.monetaryAmount;
  grossAmount : Bills_types.monetaryAmount;
  netCreditAmount : Bills_types.monetaryAmount;
  grossCreditAmount : Bills_types.monetaryAmount;
  creditCard : Bills.anonymous.type6;
  @description : 'Custom references inherited from the customer. Not included in the response by default. Use query parameter `expand` with value `customReferences` to include this array in the response.'
  customReferences : many Bills_types.customReference;
  @description : 'If `true` the bill has items that are marked for deletion.'
  containsDeletableBillItems : Boolean;
  @description : 'A bill contains a maximum of 100 items. If there are more than 100 items, a new bill is created, which in turn contains up to 100 items.'
  billItems : many Bills_types.billItem;
  notificationSettings : many Bills_types.notificationSetting;
  @description : 'Note that the event log is built up only from the day that it became available in your tenant (October 28/29, 2020). Therefore, the event log will not include any changes to the bill that took place before the delivery of the event log feature.'
  eventLog : many Bills_types.eventLogEntry;
};

@title : 'Bills'
@description : 'A set of bills.'
type Bills_types.bills : many Bills_types.bill;

@title : 'Closing'
@description : 'Details on bill closing.'
type Bills_types.closing {
  @title : 'Method of closing'
  @description : `\`AUTO\` if the bill will be closed on the predetermined billing date.
\`MANUAL\` if the bill will stay open until closed manually.`
  @assert.range : true
  method : String enum {
    AUTO;
    MANUAL;
  };
  latestAttempt : Bills_types.closingAttempt;
};

@title : 'Metadata'
type Bills_types.metaData {
  @description : 'The point in time when the bill was created.'
  createdAt : Timestamp;
};

@title : 'Bill IDs'
@description : 'An array of bill IDs that can be transferred to a backend system.'
type Bills_types.billIds : many String;

@title : 'Credit Card'
type Bills_types.creditCard {
  @description : 'The unique identifier of the card token.'
  token : String;
  @description : 'The type text of the card.'
  @assert.range : true
  type : String enum {
    DPAM;
    DPDS;
    DPVI;
    DPMC;
    DPDI;
    DPJC;
  };
  @description : 'The type text of the card.'
  @assert.range : true
  typeText : String enum {
    AMERICAN_EXPRESS = 'AMERICAN EXPRESS';
    DISCOVER;
    VISA;
    MasterCard;
    Diners_Club = 'Diners Club';
    JCB;
  };
  @description : 'The expiration month of the card.'
  expirationMonth : String;
  @description : 'The expiration year of the card.'
  expirationYear : String;
  @description : 'The masked number of the card.'
  maskedCardNumber : String;
  @description : 'The card holder name.'
  cardHolderName : String;
};

type Bills_types.customReference {
  @description : 'The code representing the type of the reference.'
  typeCode : String;
  @description : 'The identifier of the reference.'
  id : String;
};

@title : 'Error'
@description : 'Schema for API specified errors.'
type Bills_types.error {
  @description : 'original HTTP error code, should be consistent with the response HTTP code'
  status : Integer;
  @description : 'classification of the error type, lower case with underscore eg validation_failure'
  type : String;
  @description : 'descriptive error message for debugging'
  message : String;
  @description : 'list of problems causing this error'
  details : many Bills.anonymous.type7;
};

@title : 'Success'
@description : 'Schema for API success response.'
type Bills_types.success {
  @description : 'original HTTP code, should be consistent with the response HTTP code'
  status : Integer;
  @description : 'descriptive success message'
  message : String;
};

@title : 'Event Log'
type Bills_types.eventLog : many Bills_types.eventLogEntry;

@title : 'Bill Item Deletion Log'
@description : 'A set of deleted bill items or bill items found for deletion.'
type Bills_types.billItemDeletionLog {
  @description : 'If `true`, the respective bill items are not deleted but are listed as a preview of items that potentially would be deleted with the given selection criteria.'
  simulation : Boolean;
  request : {
    @description : 'URI containing all parameters of the request.'
    uri : String;
  };
  @description : 'The total number deleted items.'
  @openapi.name : 'deletedItems@count'
  deletedItems_count : Integer;
  @description : 'A link to the next page of deleted items, if more than 40 deleted items are present'
  @openapi.name : 'deletedItems@nextLink'
  deletedItems_nextLink : String;
  @description : 'A list of the bill items that were deleted with this request. Contains the first 40 deleted items only. If more than 40 items are present, you can retrieve the items with the endpoint `/deletableBillItems/deletionLogs/{deletionLogId}/deletedItems`.'
  deletedItems : many Bills_types.billItemDeletionDeletedItem;
};

@title : 'Rate Plan'
type Bills_types.ratePlan {
  id : String;
};

@title : 'Included Quantitiy'
type Bills_types.includedQuantity {
  @description : 'The descriptive name of the allowance.'
  name : String;
  @description : 'The type of included quantity. This can be an allowance or an included quantity defined in the rate plan.'
  @assert.range : true
  source : String enum {
    ALLOWANCE;
    RATE_PLAN_INCLUDED;
  };
  @description : 'The usage quantity that is allocated to either an allowance or to an included quantity defined in the rate plan.'
  allocatedQuantity : Bills_types.quantity;
  allowanceDetails : Bills_types.allowanceDetails;
};

@title : 'Subscription'
type Bills_types.subscription {
  id : String;
  @description : 'The document identifier of the subscription. The document ID consists of a prefix, if configured in the subscription profile, and of a subscription number'
  subscriptionDocumentId : String;
  documentNumber : Integer64;
  itemId : String;
};

@title : 'Sub-Charge'
type Bills_types.subCharge {
  tier : Bills_types.tier;
  consumedQuantity : Bills_types.quantity;
  netAmount : Bills_types.monetaryAmount;
  grossAmount : Bills_types.monetaryAmount;
};

@title : 'Tier'
type Bills_types.tier {
  ![from] : Integer;
  to : Integer;
};

@title : 'External Object Reference'
@description : 'External object references store document references related to the subscription. External references are used for internal SAP integration scenarios.'
type Bills_types.externalObjectReference {
  @description : 'The identifier of an external system from which the object is replicated.'
  externalSystemId : String;
  @description : 'The document identifier from the external system.'
  externalId : String;
  @description : 'The type of external object replicated from an external system.'
  externalIdTypeCode : String;
};

@title : 'Usage Record'
@description : 'The schema of a usage record.'
type Bills_types.usageRecord {
  @description : 'The unique identifier of this usage record. The service generates the identifier, which is ignored if it is provided during the creation of the usage record.'
  id : String;
  @description : 'The start date (inclusive) of the aggregation period for the quantity of usage. This date is expressed in the UTC time zone with the following pattern: yyyy-MM-DDThh:mm:ss.SSSZ.'
  startedAt : Timestamp;
  @description : 'The end date (exclusive) of the aggregation period for the quantity of usage. This date is expressed in the UTC time zone with the following pattern: yyyy-MM-DDThh:mm:ss.SSSZ.'
  endedAt : Timestamp;
  @description : 'The type of the technical resource.'
  metricId : String(255);
  @description : 'The unique identifier of the rate subelement.'
  subMetricId : String(50);
  @description : 'The number of units of usage, that is expressed by 0 or a positive number with up to 3 decimals.'
  quantity : Decimal;
  @description : 'The rating variant of the usage record.'
  @assert.range : true
  usageRatingVariant : String enum {
    aggregated;
    individual;
  };
  @description : 'The identifier of the technical resource.'
  userTechnicalId : String;
  @description : 'The creation date of the usage record. This date is expressed in the UTC time zone with the following pattern: yyyy-MM-DDThh:mm:ss.SSSZ.'
  createdAt : Timestamp;
  @description : 'The number of the subscription this usage record was applied to.'
  subscriptionNumber : Integer64;
  @description : 'The document identifier of the subscription. The document ID consists of a prefix, if configured in the subscription profile, and of a subscription number.'
  subscriptionDocumentId : String;
  items : many Bills_types.usageRecordItem;
  customReferences : many Bills_types.customReference;
};

@title : 'Payment'
type Bills_types.payment {
  @description : 'The payment method.'
  @assert.range : true
  method : String enum {
    Invoice;
    Payment_Card = 'Payment Card';
    External_Card = 'External Card';
    Unknown;
  };
  @description : 'The payment card token.'
  token : String;
  @description : 'The overall payment status for all credit card settlements of the bill.'
  @assert.range : true
  paymentStatus : String enum {
    UNKNOWN;
    NOT_SETTLED;
    SUCCESS;
    FAILED;
    ERROR;
  };
  creditCardSettlements : Bills_types.creditCardSettlements;
};

@title : 'Credit'
type Bills_types.credit {
  @description : 'The line number of the credit. A credit line number is unique per bill item. This property is only available for closed bills.'
  lineNumber : Integer;
  metricId : String;
  @description : 'The rating type of the credit.'
  @assert.range : true
  ratingType : String enum {
    recurring;
    onetime;
    usage;
  };
  ratingPeriod : Bills_types.ratingPeriod;
  consumedQuantity : Bills_types.quantity;
  @description : 'The usage quantity to be credited. This is usage that is not allocated to either an allowance or an included quantity defined in the rate plan.'
  creditedQuantity : Bills_types.quantity;
  @description : 'The quantity that is allocated either to an allowance or to an included quantity defined in the rate plan. This is determined by the `source` property (either `ALLOWANCE` or `RATE_PLAN_INCLUDED`).'
  includedQuantity : Bills_types.quantity;
  netAmount : Bills_types.monetaryAmount;
  grossAmount : Bills_types.monetaryAmount;
  pricingElements : many Bills_types.pricingElement;
  @description : 'Indicator that determines whether this credit reverses a previous credit.'
  reversal : Boolean;
  @description : 'A link allows you to retrieve all usage records if more than 100 records are included in this credit.'
  @openapi.name : 'usageRecords@nextLink'
  usageRecords_nextLink : String;
  @description : 'The total number of usage records belonging to this credit. Note that it is displayed only when there are more than 100 usage records included in this credit.'
  @openapi.name : 'usageRecords@count'
  usageRecords_count : Integer;
  usageRecords : many Bills_types.usageRecord;
  customAmounts : many Bills_types.customAmount;
  subCredits : many Bills_types.subCharge;
  includedQuantities : many Bills_types.includedQuantity;
};

@title : 'Product'
type Bills_types.product {
  id : String;
  code : String;
  name : String;
};

@title : 'Charge'
type Bills_types.charge {
  @description : 'The line number of the charge. A charge line number is unique per bill item. This property is only available for closed bills.'
  lineNumber : Integer;
  metricId : String;
  @description : 'The custom JSON for the measurement specification.'
  measurementSpecification : common.JSON;
  @description : 'The unique identifier of the rate subelement.'
  subMetricId : String(50);
  @description : 'The rating type of the charge.'
  @assert.range : true
  ratingType : String enum {
    recurring;
    onetime;
    usage;
  };
  ratingPeriod : Bills_types.ratingPeriod;
  @description : 'IDs of technical resources'
  technicalResourceIds : many String;
  @description : 'External object references inherited from specific subscription item attributes.'
  externalObjectReferences : many Bills_types.externalObjectReference;
  consumedQuantity : Bills.anonymous.type8;
  chargedQuantity : Bills.anonymous.type9;
  includedQuantity : Bills.anonymous.type10;
  netAmount : Bills_types.monetaryAmount;
  grossAmount : Bills_types.monetaryAmount;
  pricingElements : many Bills_types.pricingElement;
  @description : 'Indicator that determines whether this charge reverses a previous charge.'
  reversal : Boolean;
  @description : 'In the case of a charge reversal, this provides information about the original charge that is reversed.'
  originalBillReference : Bills_types.originalBillReference;
  @description : 'A link allows you to retrieve all usage records if more than 100 records are included in this charge.'
  @openapi.name : 'usageRecords@nextLink'
  usageRecords_nextLink : String;
  @description : 'The total number of usage records belonging to this charge. Note that it is displayed only when there are more than 100 usage records included in this charge.'
  @openapi.name : 'usageRecords@count'
  usageRecords_count : Integer;
  @description : 'The usage records belonging to this charge, in case the respective expand option `usageRecords` was used. Note that a maximum of 100 usage records are contained in the collection.'
  usageRecords : many Bills_types.usageRecord;
  customAmounts : many Bills_types.customAmount;
  subCharges : many Bills_types.subCharge;
  includedQuantities : many Bills_types.includedQuantity;
};

@title : 'Quantitative Value'
@description : 'Schema defining quantitative value in given measurement unit.'
type Bills_types.quantity {
  @description : 'The value of the item characteristic.'
  value : Double;
  @description : 'The unit of measurement given using the UN/CEFACT Common Code (2-3 characters); if no unit is given, it is assumed to be the code ''C62'', which stands for ''pieces'' (''1'' in math/physics terms, or also ''each'').'
  unit : String default 'C62';
};

@title : 'Custom Amount'
type Bills_types.customAmount {
  code : String;
  amount : Bills_types.monetaryAmount;
};

@title : 'Credit Card Settlements'
@description : 'The result of the credit card settlement.'
type Bills_types.creditCardSettlementsPostResponse {
  creditCardSettlements : Bills_types.creditCardSettlements;
};

@title : 'Allowance'
type Bills_types.allowance {
  @description : 'The unique identifier of the allowance.'
  id : String;
  @description : 'The document number of the allowance.'
  documentNumber : Integer64;
  @description : 'The description of the allowance.'
  description : String;
};

@title : 'Allowance Detail'
type Bills_types.allowanceDetails {
  @description : 'The unique identifier of the allowance.'
  allowanceId : String;
  @description : 'The document number of the allowance.'
  allowanceDocumentNumber : Decimal;
};

@title : 'Market'
type Bills_types.market {
  @description : 'The identifier of the market of the product.'
  id : String;
  @description : 'The time zone of the market.'
  timeZone : String;
  @description : 'ISO 4217 currency code, for example USD, EUR, CHF'
  currency : String;
  @description : 'Defines whether the market prices are gross or net.'
  @assert.range : true
  priceType : String enum {
    Net;
    Gross;
  };
};

@title : 'Rating Period'
@description : 'The period for which a charge is calculated and billed. Currently the period is represented as a multiple of calender days. Future functionality in SAP Subscription Billing may also introduce periods that begin and end at a time other than the start of a day in the subscription time zone.'
type Bills_types.ratingPeriod {
  @description : 'The start of the rating period, inclusive, given as a UTC-based, ISO 8601 compatible timestamp. Currently it is defined as the start of a day in the time zone of the subscription. Future functionality in SAP Subscription Billing may also lead to a starting point other than the start of the day.'
  start : Timestamp;
  @description : 'The end of the rating period, exclusive, given as a UTC-based, ISO 8601 compatible timestamp. Not present for one-time charges. Currently, it is defined as the start of the first day after the rating period in the time zone of the subscription. Future functionality in SAP Subscription Billing may also lead to an period end at a different time of day.'
  end : Timestamp;
};

@title : 'Bill Item'
type Bills_types.billItem {
  @description : 'The line number of the bill item. A bill item line number is unique per bill. This property is only available for closed bills.'
  lineNumber : Integer;
  @description : 'Indicates whether the charges of this item originate from a subscription (`SUBSCRIPTION`) or from an allowance purchase (`ALLOWANCE`)'
  @assert.range : true
  type : String enum {
    SUBSCRIPTION;
    ALLOWANCE;
  };
  subscription : Bills_types.subscription;
  allowance : Bills_types.allowance;
  product : Bills_types.product;
  ratePlan : Bills_types.ratePlan;
  groupingElement : String;
  netAmount : Bills_types.monetaryAmount;
  grossAmount : Bills_types.monetaryAmount;
  netCreditAmount : Bills_types.monetaryAmount;
  grossCreditAmount : Bills_types.monetaryAmount;
  @description : 'Custom references inherited from product, subscription and subscription item. See documentation for details on inheritance behavior. Not included in the response by default. Use query parameter `expand` with value `customReferences` to include this array in the response.'
  customReferences : many Bills_types.customReference;
  @description : 'External object references inherited from subscription and subscription item.'
  externalObjectReferences : many Bills_types.externalObjectReference;
  charges : many Bills_types.charge;
  credits : many Bills_types.credit;
  @description : 'If `true` the corresponding subscription was deleted after the bill was closed. The item can be deleted in a subsequent step by using the `/deletableBillItems` endpoint.'
  markedForDeletion : Boolean;
  @description : 'The party that receives the subscribed product.'
  shipTo : Bills_types.partner;
};

@title : 'Customer'
type Bills_types.customer {
  id : String;
  @assert.range : true
  type : String enum {
    INDIVIDUAL;
    CORPORATE;
  };
  country : String;
};

@title : 'Credit Card Settlement Transaction Detail'
type Bills_types.creditCardSettlementTransactionDetails {
  @assert.range : true
  status : String enum {
    SUCCESS;
    FAILED;
  };
  @description : 'The unique request transaction ID in SAP digital payments add-on.'
  transactionId : String;
  @description : 'The ID that can be used to identify the request at the Payment Service Provider.'
  providerId : String;
  @description : 'The merchant name.'
  merchant : String;
  @description : 'The timestamp (UTC) when the transaction was processed in SAP digital payments add-on.'
  paymentDateTime : String;
  @description : 'The amount that was charged or refunded to the credit card.'
  amount : Bills_types.monetaryAmount;
};

@title : 'Monetary Amount'
@description : 'Schema defining monetary amount in given currency.'
type Bills_types.monetaryAmount {
  @description : 'The amount in the specified currency. Given with all three decimal places, rounding half up. The number of decimal places can be more than the default number defined by the international standards for the specified currency.'
  amount : Decimal;
  @description : 'ISO 4217 currency code, for example USD, EUR, CHF'
  currency : String;
};

type Bills_types.closingPatchRequest : Bills_types.closingPatch;

type Bills_types.successorDocumentGetResponse : Bills_types.successorDocumentGet;

type Bills_types.successorDocumentPostRequest : Bills_types.successorDocumentPost;

type Bills_types.failedAttemptGetResponse : Bills_types.failedAttemptGet;

type Bills_types.failedAttemptPostRequest : Bills_types.failedAttemptPost;

@title : 'Deletion Log'
type Bills_types.deletionLogList : many {
  uri : String;
};

type Bills_types.deletionLogDeletedItem : Bills_types.billItemDeletionDeletedItem;

@title : 'Mass Closing Request Post'
@description : 'A mass closing request.'
type Bills_types.massClosingRequestPost {
  @description : 'If `true`, the respective bills are not processed but are listed as a preview of bills that potentially would be processed with the given selection criteria.'
  simulation : Boolean default 'true';
  filter : Bills_types.massClosingRequestFilter;
};

@title : 'Mass Closing Requests'
type Bills_types.massClosingRequestList : many Bills_types.massClosingRequest;

@title : 'Mass Closing Request Detail'
@description : 'The processing details of a mass closing request.'
type Bills_types.massClosingRequestDetail {
  @description : 'The unique identifier of the mass closing request.'
  id : String;
  @description : 'The point in time when the closing request was created.'
  createdAt : Timestamp;
  @description : 'If `true`, the respective bills are not processed but are listed as a preview of bills that potentially would be processed with the given selection criteria.'
  simulation : Boolean default 'true';
  filter : Bills_types.massClosingRequestFilter;
  @description : 'The total number of processed bills.'
  @openapi.name : 'processedBills@count'
  processedBills_count : Integer;
  @description : 'A link to the next page of processed bills if more than 40 processed bills are present.'
  @openapi.name : 'processedBills@nextLink'
  processedBills_nextLink : String;
  @description : 'A list of the bills that were processed with this request. Contains the first 40 processed bills only. If more than 40 processed bills are present, you can retrieve the bills with the endpoint `/bills/closing/{massClosingRequestId}/processedBills`.'
  processedBills : many Bills_types.massClosingRequestProcessedBill;
};

@title : 'Processed Bill'
@description : 'The bill processed by a mass closing request.'
type Bills_types.massClosingRequestProcessedBill {
  @description : 'The bill ID of the processed bill.'
  billId : String;
  @description : 'Indicates whether the triggered closing was successful.'
  successful : Boolean;
  @title : 'The closing result of the processed bill.'
  result : {
    @description : 'Machine-readable code stating the closing result.'
    @assert.range : true
    code : String enum {
      ALREADY_CLOSED;
      CLOSING_IN_PROGRESS;
      NOT_CLOSABLE_YET;
    };
    @description : 'The human-readable description of the code. For program logic in automated follow-up processes, for example integration flows, the machine-readable `code` property must be used instead.'
    message : String;
  };
};

@title : 'Mass Closing Progress'
@description : 'Mass closing progress indicator.'
type Bills_types.massClosingProgress {
  @description : 'The progress of the mass closing request.'
  progress : String;
};

@title : 'Deleted Bill Item'
@description : 'A deleted bill item or bill item found for deletion.'
type Bills_types.billItemDeletionDeletedItem {
  billId : String;
  billDocumentNumber : Integer;
  subscriptionId : String;
  subscriptionDocumentId : String;
  subscriptionItemId : String;
};

@title : 'Event Log Entry'
type Bills_types.eventLogEntry {
  @description : 'The unique identifier of the event log.'
  id : UUID;
  @description : 'The type of the bill event.'
  @assert.range : true
  eventType : String enum {
    opened;
    due;
    closed;
    reopened;
    transferInProgress;
    transferred;
    transferFailed;
    openedNotification;
    dueNotification;
    closedNotification;
    reopenedNotification;
    transferredNotification;
  };
  @description : 'The date and time when the event was triggered.'
  triggeredAt : Timestamp;
  @description : 'The status of event processing by SAP Event Mesh.'
  @assert.range : true
  sendingStatus : String enum {
    Initiated;
    Successful;
    Failed;
    Deactivated;
    NotRelevant;
  };
  @description : 'List of notification tags.'
  tags : many Bills.anonymous.type11;
};

@description : 'The notification setting defines a planned notification that is sent when the configured offset is reached.'
type Bills_types.notificationSetting {
  @description : 'The type of the notification.'
  @assert.range : true
  type : String enum {
    Opened;
    Due;
    Closed;
    Reopened;
    Transferred;
  };
  @description : 'Defines whether the offset is before or after the notification-relevant event.'
  @assert.range : true
  offsetType : String enum {
    before;
    after;
  };
  @description : 'The offset to the notification-relevant event in days. For example, the offset to the bill due date: in this case, if the offset type is before and the offset is 2, the notification is sent 2 days before the bill due date.'
  offset : Integer;
  @description : 'The date when the event is scheduled to be sent.'
  scheduledFor : String;
  @description : 'The list of notification tags.'
  tags : many Bills.anonymous.type12;
};

@title : 'Mass Closing Request Filter'
@description : 'The filter for the mass closing request.'
type Bills_types.massClosingRequestFilter {
  @description : 'A list of IDs of the bills that you want to close.'
  billIds : many Bills.anonymous.type13;
  @description : 'The ID of the subscription for which you want to close bills.'
  subscriptionId : String;
  @description : 'The number of the customer for which you want to close bills.'
  customerNumber : String;
  @description : 'Indicates whether you want to close bills for which the latest closing attempt was successful. Set `false` if you want to close bills for which the latest closing attempt failed.'
  latestClosingAttemptSuccessful : Boolean;
  @description : 'The closing method of the bill that you want to close.'
  @assert.range : true
  closingMethod : String enum {
    AUTO;
    MANUAL;
  } default 'MANUAL';
};

@title : 'Billing Period Parameters'
type Bills_types.billingPeriod {
  @title : 'Period'
  period : {
    @description : 'The start of the billing period for which the `billingSettings` are fixed.'
    start : Date;
    @description : 'The end of the billing period for which the `billingSettings` are fixed. The end date is exclusive.'
    end : Date;
  };
  @title : 'Billing settings that are applied to the bill and fixed for the billing period.'
  billingSettings : {
    @description : 'Number of days by which the billing date is delayed.'
    billingDateDelay : Decimal;
    @description : 'The timing of billing for adjustments to charges. Only applies to recurring charges that are billed in advance.'
    @assert.range : true
    adjustmentCycle : String enum {
      MATCHES_BILLING_CYCLE = 'MATCHES-BILLING-CYCLE';
      DAILY;
      MONTHLY;
      QUARTERLY;
      HALF_YEARLY = 'HALF-YEARLY';
      YEARLY;
      IMMEDIATE;
    };
  };
};

@title : 'Closing Attempt'
type Bills_types.closingAttempt {
  @description : 'The point in time when the closing attempt happened.'
  attemptedAt : Timestamp;
  @description : 'The person who triggered the closing attempt.'
  attemptedBy : String;
  @description : 'Indicates whether the closing attempt was successful.'
  successful : Boolean;
  @title : 'The result of the closing attempt.'
  result : {
    @description : 'Machine-readable code stating the result.'
    @assert.range : true
    code : String enum {
      PRICING_ERROR;
    };
    @description : 'The human-readable description of the result code. For program logic in automated follow-up processes, for example integration flows, the machine-readable `code` property must be used instead.'
    message : String;
  };
};

@title : 'Failed attempt GET response body'
type Bills_types.failedAttemptGet {
  @description : 'The unique identifier of the failed attempt.'
  id : String;
  successorDocumentSystem : String(255);
  successorDocumentId : String(255);
  successorDocumentType : String(255);
  @description : 'The point in time when the failed transfer attempt was reported.'
  reportedAt : Timestamp;
  @description : 'Array of strings that contains the messages which were reported along with the failed transfer attempt.'
  messages : many String;
  @description : 'The point in time when the transfer failed. This can be provided by the integration process.'
  attemptedAt : Timestamp;
};

@title : 'Successor Document POST request body'
type Bills_types.successorDocumentPost {
  @description : 'Indicates whether a successor document was created successfully. Only when this flag is set to `true`, a successor document is assigned to the bill. The value `false` is currently not used and has no effect.'
  success : Boolean;
  @description : 'An identifier for the system where the successor document of the bill was created.'
  successorDocumentSystem : String(255);
  @description : 'An identifier for the successor document created in the external system. The ID should be unique in the successor document system.'
  successorDocumentId : String(255);
  @description : 'Caption for the type of document that is created, for example an invoice request.'
  successorDocumentType : String(255);
  @description : 'Reserved for future use.'
  messages : many String;
};

@title : 'Credit Card Settlements'
@description : 'Detail information about the credit card payment settlement. Use query parameter `expand` with value `creditCard` to include this property in the response.'
type Bills_types.creditCardSettlements {
  charges : many Bills_types.creditCardSettlementTransactionDetails;
  refunds : many Bills_types.creditCardSettlementTransactionDetails;
};

@title : 'Pricing Element'
@description : 'An element in pricing that contains attributes such as condition types and condition values. Pricing elements can be prices, surcharges, or discounts.'
type Bills_types.pricingElement {
  @description : 'The type of pricing element.'
  step : Decimal;
  @description : 'The type of pricing element.'
  priceElementSpecificationCode : String;
  @description : 'The type of pricing element.'
  name : String;
  statistical : Boolean;
  @description : 'The type of pricing element.'
  conditionType : String;
  @description : 'The value resulting from pricing for a pricing element. This can be the total or subtotal in a document.'
  conditionValue : Bills_types.monetaryAmount;
};

@title : 'Successor Document GET response body'
type Bills_types.successorDocumentGet {
  successorDocumentSystem : String(255);
  successorDocumentId : String(255);
  successorDocumentType : String(255);
  @description : 'The point in time when the successor document was reported.'
  reportedAt : Timestamp;
};

type Bills_types.usageRecordItem {
  @description : 'The unique identifier of this usage record item.'
  id : String;
  @description : 'The number of the usage record item.'
  itemNumber : Integer;
  @description : 'Indicates whether the usage record item is obsolete or not.'
  obsolete : Boolean;
  fields : many Bills_types.usageRecordItemField;
  customReferences : many Bills_types.customReference;
};

@title : 'Original Bill Reference'
type Bills_types.originalBillReference {
  @description : 'The document number of the referenced bill. The document number is unique per tenant.'
  documentNumber : Integer64;
  @description : 'The line number of the referenced bill item. A bill item line number is unique per bill. This property is only available for closed bills.'
  billItemLineNumber : Integer;
  @description : 'The line number of the referenced charge. A charge line number is unique per bill item. This property is only available for closed bills.'
  chargeLineNumber : Integer;
};

@title : 'Mass Closing Request'
@description : 'A mass closing request.'
type Bills_types.massClosingRequest {
  @description : 'The unique identifier of the mass closing request.'
  id : String;
  @description : 'The point in time when the closing request was created.'
  createdAt : Timestamp;
  @description : 'If `true`, the respective bills are not processed but are listed as a preview of bills that potentially would be processed with the given selection criteria.'
  simulation : Boolean default 'true';
  filter : Bills_types.massClosingRequestFilter;
};

type Bills_types.usageRecordItemField {
  @description : 'The code representing the pricing-relevant field.'
  fieldCode : String;
  @description : 'The date value of the pricing-relevant field.'
  dateValue : Date;
  @description : 'The quantity value of the pricing-relevant field.'
  quantityValue : {
    @description : 'The decimal value of the quantity.'
    value : Decimal;
    @description : 'The unit of the quantity.'
    unit : String;
  };
  @description : 'The string value of the pricing-relevant field.'
  stringValue : String(255);
  @description : 'The ratio value of the pricing-relevant field.'
  ratioValue : {
    @description : 'The denominator of the ratio.'
    denominator : Decimal;
    @description : 'The numerator of the ratio.'
    numerator : Decimal;
  };
};

@title : 'Failed attempt POST request body'
type Bills_types.failedAttemptPost {
  @description : 'An identifier for the system to which the transfer failed.'
  successorDocumentSystem : String(255);
  @description : 'An identifier for the successor document created in the external system. The ID should be unique in the successor document system.'
  successorDocumentId : String(255);
  @description : 'Caption for the type of document that failed to create in the successor system.'
  successorDocumentType : String(255);
  @description : 'Array of messages that are stored with the failed attempt. The concatenated length of all lines should not exceed 255 characters or the request may be declined.'
  messages : many String;
  @description : 'The point in time when transfer failed.'
  attemptedAt : Timestamp;
};

@title : 'Business Partner'
@description : 'A person, organization, group of persons or group of organizations in which a company has a business interest.'
type Bills_types.partner {
  @description : 'The unique identifier of the business partner.'
  id : String;
  @description : 'The type of the business partner.'
  type : String;
  @description : 'The country/region of the business partner.'
  country : String;
};

@title : 'Closing PATCH Request'
type Bills_types.closingPatch {
  @description : `\`MANUAL\` if the bill should stay open until closed manually. \`AUTO\` if the bill should be closed when reaching the billing date.
If set to \`AUTO\` on or after the regular billing date, the bill is closed immediately.`
  @assert.range : true
  method : String enum {
    AUTO;
    MANUAL;
  };
};

@assert.range : true
type Bills.anonymous.type0 : String enum {
  subCharges;
  subCredits;
  customReferences;
  customAmounts;
  successorDocuments;
  includedQuantities;
  pricingElements;
  ![all];
};

@assert.range : true
type Bills.anonymous.type1 : String enum {
  OPEN;
  CLOSING;
  CLOSED;
};

@assert.range : true
type Bills.anonymous.type2 : String enum {
  NOT_RELEVANT;
  NOT_TRANSFERRED;
  TRANSFER_IN_PROGRESS;
  TRANSFERRED;
  FAILED;
  FAILED_PARTIALLY;
};

@assert.range : true
type Bills.anonymous.type3 : String enum {
  SUCCESS;
  ERROR;
  UNKNOWN;
  NOT_SETTLED;
  FAILED;
};

@assert.range : true
type Bills.anonymous.type4 : String enum {
  subCharges;
  subCredits;
  customReferences;
  customAmounts;
  successorDocuments;
  includedQuantities;
  pricingElements;
  creditCard;
  usageRecords;
  originalBillReference;
  notificationSettings;
  eventLog;
  ![all];
};

@assert.range : true
type Bills.anonymous.type5 : String enum {
  charges;
  credits;
  billItems;
};

@description : 'Not included in the response by default. Use query parameter `expand` with value `creditCard` to include this structure in the response.'
type Bills.anonymous.type6 : Bills_types.creditCard { };

@description : 'schema for specific error cause'
type Bills.anonymous.type7 {
  @description : 'a bean notation expression specifying the element in request data causing the error, eg product.variants[3].name, this can be empty if violation was not field specific'
  field : String;
  @description : 'classification of the error detail type, lower case with underscore eg missing_value, this value must be always interpreted in context of the general error type.'
  type : String;
  @description : 'descriptive error detail message for debugging'
  message : String;
};

@description : 'The usage for the rating period, as a quantity of units.'
type Bills.anonymous.type8 : Bills_types.quantity { };

@description : 'The usage quantity to be charged. This is usage that is not allocated to either an allowance or an included quantity defined in the rate plan.'
type Bills.anonymous.type9 : Bills_types.quantity { };

@description : 'The quantity that is allocated either to an allowance or to an included quantity defined in the rate plan. This is determined by the `source` property (either `ALLOWANCE` or `RATE_PLAN_INCLUDED`).'
type Bills.anonymous.type10 : Bills_types.quantity { };

@description : 'A notification tag. Tags are keywords that enable a notification to be easily identified or to trigger follow-up processes.'
type Bills.anonymous.type11 : String;

@description : 'A notification tag.'
type Bills.anonymous.type12 : String;

@description : 'A bill ID.'
type Bills.anonymous.type13 : String;

type common.JSON : LargeString;

