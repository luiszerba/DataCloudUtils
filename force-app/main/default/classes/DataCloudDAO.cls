public interface DataCloudDAO  {

    List<Map<String,Object>> queryAll(List<String> header, String query);
    Map<String,Object> queryById(String id,String query);
}