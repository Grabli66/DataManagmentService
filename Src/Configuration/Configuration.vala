/*
*   Конфигурация приложения
*/
public class Configuration : Object { 
    public const string SETTINGS_FILE = "Settings.json";
    public const string CONFIGURATION_INFO = "ConnectionInfo";

    /*
    *   Экземпляр Configuration
    */
    private static Configuration _instance;

    /*
    *   Информация о подключении к источнику данных
    */
    public ConnectionInfo Connection { get; private set; }

    /*
    *   Возвращает экземляр конфигурации
    */
    public static Configuration GetInstance () {
        return _instance;
    }

    /*
    *   Загружает конфигурацию
    */
    public static void Load () {      
        _instance = new Configuration ();
    }

    /*
    *   Загружает файл настроек
    */
    private Configuration() {        
        Json.Parser parser = new Json.Parser ();
        parser.load_from_file (SETTINGS_FILE);        
        var root = parser.get_root ().get_object ();        
        var connInfo = root.get_object_member (CONFIGURATION_INFO);
        if (connInfo != null) Connection = new ConnectionInfo.FromJson (connInfo);        
    }    
}