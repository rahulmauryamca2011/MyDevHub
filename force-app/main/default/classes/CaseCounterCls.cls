public with sharing class CaseCounterCls {
  public id currentid; 
  private final Case Objcase;

  
  public CaseCounterCls(ApexPages.StandardController controller) 
  { 
       Group lstQueueRecords = [Select Id, Name,OwnerId, DeveloperName, Type from Group where Type = 'Queue' and Name = 'DMD Rework'];
                                                       
     currentid = ApexPages.currentPage().getParameters().get('id');
    
  }
 public pagereference Validate()
 {
     return null;
 }

 }