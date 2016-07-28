/*
*   Уровень логирования
*/
public enum LogLevel {
    FATAL,
    INFO,
    DEBUG;
}

/*
*   Занимается логированием
*/
class Logger : Object {
    public const string DIR_SEPARATOR = "/";
    public const string LOG_DIR = "Logs";

    /*
    *   Уровень логирования   
    */
    public LogLevel Level = LogLevel.FATAL;

    /*
    *   Создает журнал
    */
    private Logger(string path) {
        var pathname = Path.build_path (DIR_SEPARATOR, LOG_DIR, path);
        var file = File.new_for_commandline_arg (pathname);
        file.make_directory_with_parents ();
    }

    /*
    *   Подготавливает путь журнала и возвращает его
    */
    public static Logger GetLogger (string path = "") {
        return new Logger (path);
    }

    /*
    *   Добавляет линию в буффер
    */
    public void AddLine (string s, LogLevel level = LogLevel.FATAL) {

    }
}