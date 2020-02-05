public with sharing class quickTableHandler {

    public String columnField { get; set; }
    public String soqls { get; set; }
    public String columnTitle { get; set; }
    public String cContainerIds { get; set; }

    public List<String> columnFieldsList {
        get {
            if(columnFieldsList == null && columnField != null) {
                columnFieldsList = columnField.split(',');
                for(Integer x = 0; x < columnFieldsList.size(); x++) {
                    columnFieldsList[x] = columnFieldsList[x].trim();
                }
            }
            return columnFieldsList;
        }
        set;
    }
    
    public List<String> columnTitlesList {
        get {
            if(columnTitlesList== null && columnTitle != null) {
                columnTitlesList= columnTitle.split(',');
                for(Integer x = 0; x < columnTitlesList.size(); x++) {
                    columnTitlesList[x] = columnTitlesList[x].trim();
                }
            }
            return columnTitlesList;
        }
        set;
    }

    public List<sObject> records {
        get {
            if(records == null && soqls != null) {
                records = Database.query(soqls);
            }
            return records;
        }
        set;
    }
}