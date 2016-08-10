/*
*   Менеджер сущностей для sqlite базы данных
*   Возможные применения: встраиваемая база для мобильных устройств
*/
class SqliteEntityManager : Object, IEntityManager {
    /*
    *   Текущая версия базы данных
    */
    public const int CURRENT_DATABASE_VERSION = 1;

    /*
    *   Информация о подключении к базе данных
    */
    private ConnectionInfo _connection;

    /*
    *   Доступ к базе данных
    */
    private Sqlite.Database _database;

    private Logger _logger = Logger.GetLogger ("SqliteEntityManager");

    /*
    *   Открывает базу данных
    */
    private Sqlite.Database GetDatabase () {
        if (_database == null) {
            var rc = Sqlite.Database.open (_connection.Source, out _database);
            if (rc != Sqlite.OK) throw new DatabaseError.CANT_OPEN ("Cant open database");
        }
        return (owned) _database;
    }

    /*
    *   Проверяет подготовлена ли база к работе
    */
    private bool TestSource () {
        var file = File.new_for_path (_connection.Source);
        if (file.query_exists ()) {
            _logger.AddLine ("Database exists");
            return true;
        }
        _logger.AddLine ("Database not exists");
        var db = GetDatabase ();

        // TODO: проверять версию базы
        return false;
    }

    /*
    *   Создает базу данных или обновляет
    */
    private void PrepareDatabase () {
        var db = GetDatabase ();
        _logger.AddLine ("Start create/update database");
        // TODO: загружать сценарий из файла
        var request = """ 
                         DROP TABLE IF EXISTS entities;
                         DROP TABLE IF EXISTS attributes;
                         DROP TABLE IF EXISTS values_string;
                         DROP TABLE IF EXISTS db_version;
                         CREATE TABLE entities (entity_id TEXT);
                         CREATE TABLE attributes (attr_id TEXT, parent_id TEXT, value_id TEXT);
                         CREATE TABLE values_string (value_id TEXT, data TEXT);
                         CREATE TABLE db_version (version INTEGER);
                         INSERT INTO db_version VALUES ('%d');
        """.printf (CURRENT_DATABASE_VERSION);
        var rc = db.exec (request);
        if (rc != Sqlite.OK) throw new DatabaseError.SQL_ERROR (db.errmsg ());
        _logger.AddLine ("Database created/updated successfuly");
    }

    public SqliteEntityManager(ConnectionInfo connection) {
        _connection = connection;
        if (!TestSource ()) PrepareDatabase ();
    }

    /*
    *   Создает задание на создание сущности
    */
    public Entity CreateEntity () {
        var entity = new Entity ();
        var entityAction = new EntityAction ();
        return entity;
    }
}