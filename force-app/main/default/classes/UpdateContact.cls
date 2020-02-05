public with sharing class UpdateContact {
  public static Contact getSingleContact(){
       return [SELECT Id, FirstName, LastName FROM Contact LIMIT 1];
    }
}