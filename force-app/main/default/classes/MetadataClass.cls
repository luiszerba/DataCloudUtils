public class MetadataClass {
    public class Field {
        public String name;
        public String displayName;
        public String type;
        public String keyQualifier;
    }
    
    public class Index {
        // Add index properties here if needed
    }
    
    public class Relationship {
        public String fromEntity;
        public String toEntity;
        public String fromEntityAttribute;
        public String toEntityAttribute;
        public String cardinality;
    }
    
    public class PrimaryKey {
        public String name;
        public String displayName;
        public String indexOrder;
    }
    
    public class Metadata {
        public List<Field> fields;
        public List<Index> indexes;
        public String category;
        public String name;
        public String displayName;
        public List<Relationship> relationships;
        public List<PrimaryKey> primaryKeys;
        public List<Dimension> dimensions;
        public List<Measure> measures;
        public String partitionBy;
    }
    
    public class Dimension {
        public String name;
        public String displayName;
        public String type;
    }
    
    public class Measure {
        public String name;
        public String displayName;
        public String type;
        public Boolean rollupable;
    }
    
    public class AvgSpends {
        public String name;
        public String displayName;
        public List<Dimension> dimensions;
        public List<Measure> measures;
        public List<Relationship> relationships;
        public String partitionBy;
    }
    
    public List<Metadata> metadata{get;set;}
}
