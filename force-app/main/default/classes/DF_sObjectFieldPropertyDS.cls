global with sharing class DF_sObjectFieldPropertyDS extends VisualEditor.DynamicPickList{

    VisualEditor.DesignTimePageContext context;

    global DF_sObjectFieldPropertyDS(VisualEditor.DesignTimePageContext context) {
        this.context = context;
    }

    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('Id', 'Id');
        return defaultValue;
    }

    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        
        Schema.DescribeSObjectResult sObjectDescribe = Schema.getGlobalDescribe().get(context.entityName).getDescribe();

        Map<String, Schema.SObjectField> fieldsMap = sObjectDescribe.fields.getMap();
        List<String> fieldNames = new List<String>(fieldsMap.keySet());

        for (String fieldName : fieldNames) {
            Schema.DescribeFieldResult fieldDescribe = fieldsMap.get(fieldName).getDescribe();
            VisualEditor.DataRow row = new VisualEditor.DataRow(fieldDescribe.label,fieldDescribe.name);
            myValues.addRow(row);
        }

        return myValues;
    }
}