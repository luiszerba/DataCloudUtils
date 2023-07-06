global class DF_DataCloudPropertyDS extends VisualEditor.DynamicPickList{

    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('red', 'RED');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {

        
        MetadataClass result = DataCloudDAOFactory.getDataCloudDAO(DataCloudDAOFactory.DAO_TYPE.API)
        .queryDataCloudMetadata('DataModelObject','Engagement',null);

        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        for(MetadataClass.Metadata metadata: result.metadata){
            VisualEditor.DataRow dataRow = new VisualEditor.DataRow(metadata.name, metadata.name);
            System.debug('[metadata name]:'+metadata.name);
            myValues.addRow(dataRow);
        }

        // VisualEditor.DataRow value1 = new VisualEditor.DataRow('red', 'RED');
        // VisualEditor.DataRow value2 = new VisualEditor.DataRow('yellow', 'YELLOW');
        // VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        // myValues.addRow(value1);
        // myValues.addRow(value2);
        return myValues;
    }
}