/*
*   Фабрика по созданию менеджеров управления данных
*   Все методы фабрики статические, поэтому её не обязательно наследовать от Object. Достаточно Compact
*/
[Compact]
class ManagerFactory {
    private DSManagerFactory() {}

    /*
    *   Возвращает менеджер согласно переданной строке подключения    
    *   Пример: "Driver=sqlite Source=database.db"
    */
    public static IEntityManager GetManager (string connectionString) {
        
    }    
}