/*
*   Фабрика по созданию менеджеров управления данных
*   Все методы фабрики статические, поэтому её не обязательно наследовать от Object. Достаточно Compact
*/
[Compact]
class ManagerFactory {
    private ManagerFactory() {}

    /*
    *   Экземпляр менеджера
    */
    private static IEntityManager _instance;

    /*
    *   Создает новый менеджер согласно настройкам
    */
    private static IEntityManager CreateManager () {
        var connectionInfo = Configuration.GetInstance ().Connection;

        if (connectionInfo.Driver == DriverType.SQLITE) {
            return new SqliteEntityManager (connectionInfo);
        }

        throw new CommonError.NOT_FOUND ("Driver not found");
    }

    /*
    *   Возвращает менеджер согласно настройкам
    */
    public static IEntityManager GetManager () {
        if (_instance == null) {
            _instance = CreateManager ();
        }

        return _instance;
    }    
}