/*
*   Конфигурация приложения
*/
class Configuration : Object {
    /*
    *   Экземпляр Configuration
    */
    private static Configuration _instance;

    /*
    *   Настройки в виде Json объекта
    */
    private Json.Node _settings;

    /*
    *   Загружает файл настроек
    */
    private Configuration() {
        Json.Parser parser = new Json.Parser ();
        parser.load_from_file ("Settings.json");        
        _settings = parser.get_root ();
    }

    /*
    *   Загружает настройки
    */
    public static void Init () {
        _instance = new Configuration();
    }    

    /*
    *   Ищет элемент в настройках по названию
    *   Если parent == null то ищет начиная с корневого элемента
    */
    public static Json.Node FindNode (string name, Json.Node parent = null) {
        return null;
    }
}