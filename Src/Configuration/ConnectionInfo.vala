/*
*    Содержит информацию о подключении к источнику данных
*/
public class ConnectionInfo : Object {
    public const string DRIVER_NAME = "Driver";
    public const string SOURCE_NAME = "Source";

    /*
    *   Определяет драйвер источника данных
    */
    public DriverType Driver { get; private set; }

    /*
    *   Определяет источник данных: путь до файла, host базы данных
    */
    public string Source { get; private set; }
    
    /*
    *   Создает информацию о подключении из Json элемента 
    */
    public ConnectionInfo.FromJson (Json.Object node) {
        Driver = DriverType.FromString (node.get_string_member (DRIVER_NAME));
        Source = node.get_string_member (SOURCE_NAME);
    }
}