/*
*   Менеджер сущностей для sqlite базы данных
*   Возможные применения: встраиваемая база для мобильных устройств
*/
class SqliteEntityManager : IEntityManager { 

    /*
    *   Проверяет подготовлена ли база к работе
    */
    private bool TestSource (ConnectionInfo connection) {
        var file = File.new_for_path (connection.Source);
        if (file.query_exists ()) return true;
        return false;
    }

    /*
    *   Создает базу данных или обновляет
    */
    private void PrepareDatabase (ConnectionInfo connection) {
        Sqlite.Database db;
        var rc = Sqlite.Database.open (connection.Source, out db);
        if (rc != Sqlite.OK) throw new DatabaseError.CANT_OPEN ("Cant open database");

        // TODO: загружать сценарий из файла
        var request = """ 
                         DROP TABLE entities IF EXISTS;
                         DROP TABLE attributes IF EXISTS;
                         DROP TABLE values_string IF EXISTS;
                         CREATE TABLE entities (entity_id TEXT);
                         CREATE TABLE attributes (attr_id TEXT, parent_id TEXT, value_id TEXT);
                         CREATE TABLE values_string (value_id TEXT, data TEXT);
        """;
        rc = db.exec (request);
        if (rc != Sqlite.OK) throw new DatabaseError.SQL_ERROR ("Cant create/update database");
    }

    public SqliteEntityManager(ConnectionInfo connection) {
        if (!TestSource ()) PrepareDatabase (connection);
    }

    /*
    *   Создает задание на создание сущности
    */
    public Entity CreateEntity () {

    }
}