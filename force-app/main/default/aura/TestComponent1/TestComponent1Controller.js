({
	doFormat : function(component, event, helper) {
		var val = component.get("v.phoneNumber");
        if(val.length == 10)
        {
            var varPart1 = val.substring(0,3);
            var varPart2 = val.substring(3,6);
            var varPart3 = val.substring(6,10);
            var finalvar = "("+varPart1+")-"+varPart2+"-"+varPart3;
             component.set("v.phoneNumber",finalvar);
        }
        
       
	}
})