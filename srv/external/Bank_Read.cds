/* checksum : 375692b2d772df4ac060c707ba24a8f7 */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service Bank_Read {};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Bank Details'
entity Bank_Read.A_BankDetail {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank Country/Region'
  @sap.quickinfo : 'Country/Region Key of Bank'
  key BankCountry : String(3) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank Key'
  @sap.quickinfo : 'Bank Keys'
  key BankInternalID : String(15) not null;
  @sap.label : 'Bank Name'
  @sap.quickinfo : 'Name of Financial Institution'
  BankName : String(60) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'SWIFT/BIC'
  @sap.quickinfo : 'SWIFT/BIC for International Payments'
  SWIFTCode : String(11) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank group'
  @sap.quickinfo : 'Bank group (bank network)'
  BankGroup : String(2) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank Number'
  BankNumber : String(15) null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Region'
  @sap.quickinfo : 'Region (State, Province, County)'
  Region : String(3) null;
  @sap.label : 'Street'
  @sap.quickinfo : 'Street and House Number'
  StreetName : String(35) null;
  @sap.label : 'City'
  CityName : String(35) null;
  @sap.label : 'Bank Branch'
  Branch : String(40) null;
};

