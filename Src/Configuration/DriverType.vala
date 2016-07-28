/*
*   Тип драйвера
*/
public enum DriverType {
    SQLITE;

    /*
    *   Название драйвера для SQLITE
    */
    public const string SQLITE_STR = "sqlite";

    /*
    *   Преобразует строку в DriverType
    */
    public static DriverType FromString (string s) {
        if (s == SQLITE_STR) return SQLITE;
        throw new CommonError.NOT_FOUND ("Driver type not found");
    }
}