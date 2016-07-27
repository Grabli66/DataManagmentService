class Configuration : Object {
    /*
    *   Экземпляр Configuration
    */
    private static Configuration _instance;

    /*
    *   Словарь с настройками
    */
    private Gee.HashMap<string, string> _settings = new Gee.HashMap<string, string>();

    private Configuration() {
        // Загружает файл настроек
        // Парсит настройки
    }

    /*
    *   Возвращает экземпляр Configuration
    */
    private static Configuration GetInstance () {
        if (_instance == null) {
            _instance = new Configuration();
        }

        return _instance;
    }

    /*
    *   Возвращает значение настроек по ключу
    */
    public string Get (string key) {
        return _settings.@get (key);
    }
}