/*
*   Тип драйвера
*/
public enum DriverType {
    SQLITE;

    /*
    *   Название драйвера для SQLITE
    */
    public const string SQLITE_DRIVER = "sqlite";

    /*
    *   Преобразует строку в DriverType
    */
    public static DriverType FromString (string s) {
        if (s == SQLITE_DRIVER) return SQLITE;
    }
}

/*
*   Парсит строку подключения 
*   для того что бы использовать эту информацию при осуществлении подключения к источнику данных
*/
class ConnectionInfo : Object {
    public const string DRIVER_NAME = "Driver";
    public const string SOURCE_NAME = "Source";

    /*
    *   Драйвер: sqlite, postgresql, mysql, xml
    */
    public DriverType Driver { get; private set; default = ""; }
    public string Source { get; private set; default = ""; }

    /*
    *   Парсит строку подключения
    */
    public ConnectionInfo(string connectionString) 
    {
        if (connectionString == "") throw new ParseError.NO_DATA ("No data");

        string[] stringItems = connectionString.split (" ");
        foreach (var stringItem in stringItems) {
            var kvData = stringItem.split ("=");
            if (kvData.length < 2) throw new ParseError.WRONG_DATA ("Wrong data");
            var key = kvData[0];
            var val = kvData[1];
            ProcessKeyValue (key, val);
        }
    }

    /*
    *   Заполняет подключение информацией
    */
    private void ProcessKeyValue (string key, string val) {
        if ((key == "") || (val == "")) throw new ParseError.WRONG_DATA ("Wrong data");
        if (key == DRIVER_NAME) Driver = DriverType.FromString (val);
        if (key == SOURCE_NAME) Source = val;
    }
}