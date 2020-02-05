global class UpdateDataBatch implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
        string Basequery ='select id,';
        string query ='';
        map<string,string> mapRelationShip = new map<string,string>();
        for(RelationShipMapping__mdt objR :[select id,MasterLabel,Field_Api_Name__c from RelationShipMapping__mdt ])
        {
            mapRelationShip.put(objR.MasterLabel.toupperCase(),objR.Field_Api_Name__c);
        }
        
        date dt= system.today();
        set<string> setField = new set<string>();
        for(Field_Mapping__mdt obj :[select id,Object_Name__c,Source_Object_Field_name__c,Target_Object_field_name__c from Field_Mapping__mdt where IsActive__c =true])
        {
            if(mapRelationShip.get(obj.Object_Name__c.toupperCase()) != null && setField.contains(obj.Object_Name__c.touppercase()) ==false)
            {
                Basequery += mapRelationShip.get(obj.Object_Name__c.toupperCase())+',';
                setField.add(obj.Object_Name__c.touppercase());
            }
            if(obj.Source_Object_Field_name__c != null && setField.contains(obj.Source_Object_Field_name__c.touppercase()) ==false)
            {
                query += (obj.Source_Object_Field_name__c+',');
                setField.add(obj.Source_Object_Field_name__c.touppercase());
            }
        }
        query = query.substring(0,query.length()-1);
        query += ' from Candidate__c where CreatedDate__c = :dt';
        Basequery += query;
        return Database.getQueryLocator(Basequery);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
        map<string,list<Field_Mapping__mdt >> mapAobjectTofield = new map<string,list<Field_Mapping__mdt >>();
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        list<sobject> lstSObj = new list<sobject>(); 
        map<string,string> mapRelationShip = new map<string,string>();
        set<id> setAcIds = new set<id>();
        list<Candidate__c> lstCandidate = new list<Candidate__c>(); 
        set<string> setOppAge = new set<string>();
        map<id,map<string,Opportunity>> mapAcToOpp = new map<id,map<string,Opportunity>>();
        for(RelationShipMapping__mdt objR :[select id,MasterLabel,Field_Api_Name__c from RelationShipMapping__mdt ])
        {
            mapRelationShip.put(objR.MasterLabel.toupperCase(),objR.Field_Api_Name__c);
        }
        system.debug('mapRelationShip=='+mapRelationShip);
        for(Field_Mapping__mdt obj :[select id,Object_Name__c,Source_Object_Field_name__c,Target_Object_field_name__c,Opportunity_Age__c from Field_Mapping__mdt ])
        {
            if(mapAobjectTofield.get(obj.Object_Name__c.toupperCase()) == null)
                mapAobjectTofield.put(obj.Object_Name__c.toupperCase(),new list<Field_Mapping__mdt>());
            
            mapAobjectTofield.get(obj.Object_Name__c.toupperCase()).add(obj);
            
            if(obj.Opportunity_Age__c != null)
                setOppAge.add(obj.Opportunity_Age__c);
        }
        system.debug('setOppAge=='+setOppAge);
        for(sObject objC :scope)
        {
            Candidate__c obj =(Candidate__c)objC;
            setAcIds.add(obj.Account__c);
            lstCandidate.add(obj);
        }
        if(setAcIds.size()>0)
        {
            for(Account objAc :[select id,(select id,name from opportunities) from account where id in  :setAcIds])
            {
                map<string,opportunity> mapAgeToId = new map<string,opportunity>();
                for(Opportunity objOpp :objAc.opportunities)
                {
                    system.debug('objAc.opportunities=='+objAc.opportunities.size());
                    for(string strAge : setOppAge)
                    {
                        system.debug('objOpp.name='+objOpp.name);
                        system.debug('strAge=='+strAge);
                        if(objOpp.name.contains(strAge))
                        {
                            system.debug('inside age=='+objOpp.name);
                            if(mapAcToOpp.get(objAc.id) == null)
                                mapAcToOpp.put(objAc.id,new map<string,opportunity>());
                            
                            
                            opportunity o = new opportunity();
                            o.id= objOpp.id;
                            mapAgeToId.put(strAge,o);
                            mapAcToOpp.put(objAc.id,mapAgeToId);
                        }
                    }
                }
            }
        }
        system.debug('mapAcToOpp=='+mapAcToOpp);
        system.debug('lstCandidate=='+lstCandidate);
        
        for(Candidate__c obj :lstCandidate)
        {
            for(string str :mapAobjectTofield.keyset())
            {
                system.debug('str==='+str); 
                
                Schema.SobjectType oType = gd.get(str);
                sobject Newobj = oType.newSObject(); 
                system.debug('mapRelationShip=='+mapRelationShip.get(str) +'=='+Newobj.id); 
                if(mapRelationShip.get(str) != null && Newobj.id == null)
                {
                    system.debug('mapRelationShip.get(str)=='+mapRelationShip.get(str));
                    system.debug('test=='+obj.get(mapRelationShip.get(str)));
                    string acid = string.valueof(obj.get(mapRelationShip.get(str)));
                    Newobj.id = acid;
                }
                if(str == 'OPPORTUNITY')
                {
                    system.debug('mapAcToOpp.get(obj.Account__c)==='+mapAcToOpp.get(obj.Account__c)); 
                    if(mapAcToOpp.get(obj.Account__c) != null)
                    {
                        map<string,opportunity> mapAgeToOpp = new map<string,opportunity>();
                        mapAgeToOpp = mapAcToOpp.get(obj.Account__c);
                        for(Field_Mapping__mdt strF : mapAobjectTofield.get('OPPORTUNITY'))
                        {
                            system.debug('strF==='+strF.Target_Object_field_name__c); 
                            system.debug('mapAgeToOpp==='+mapAgeToOpp);
                            system.debug('mapAgeToOpp.get(strF.Opportunity_Age__c)==='+mapAgeToOpp.get(strF.Opportunity_Age__c));
                            if(mapAgeToOpp.get(strF.Opportunity_Age__c) != null)
                            {
                                system.debug('pass from here=========='+mapAgeToOpp.get(strF.Opportunity_Age__c));
                                mapAgeToOpp.get(strF.Opportunity_Age__c).put(strF.Target_Object_field_name__c,(obj.get(strF.Source_Object_Field_name__c)));
                                system.debug('pass from here1=========='+mapAgeToOpp.get(strF.Opportunity_Age__c));
                            }
                        }
                        for(string strA : mapAgeToOpp.keyset())
                            lstSObj.add(mapAgeToOpp.get(strA));
                    }
                }
                else
                {
                    for(Field_Mapping__mdt strF : mapAobjectTofield.get(str))
                    {
                        system.debug('strF==='+strF); 
                        Newobj.put(strF.Target_Object_field_name__c,(obj.get(strF.Source_Object_Field_name__c)));
                    }
                }
                system.debug('Newobj==='+Newobj); 
                if(Newobj.id != null)
                    lstSObj.add(Newobj);
            }
        }
        
        system.debug('lstSObj==='+lstSObj); 
        update lstSObj  ;   
    }

    global void finish(Database.BatchableContext BC){
        
    }
}