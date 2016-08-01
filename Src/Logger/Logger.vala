/*
*   Уровень логирования
*/
public enum LogLevel {
    FATAL,
    INFO,
    DEBUG;
}

/*
*   Запись в журнале лога
*/
public class LogRecord {
    /*
    *   Журнал со всей информацией куда писать журнал
    */
    public Logger Log;

    /*
    *   Дата и время записи
    */
    public DateTime Time;

    /*
    *   Сообщение которое пишется в журнал
    */
    public string Message;

    public LogRecord (Logger log, DateTime time, string message) {
        Log = log;
        Time = time;
        Message = message;
    }

}

/*
*   Занимается логированием
*/
public class Logger : Object {
    public const string DIR_SEPARATOR = "/";

    /*
    *   Папка в которой хранятся все логи
    */
    public const string LOG_DIR = "Logs";

    /*
    *   Пауза между записью в файл
    */
    public const int THREAD_SLEEP = 100;

    /*
    *   Максимальное количество строк в файле
    */
    public static int MaxLineCount = 1000;

    /*
    *   Максимальное количество файлов
    */
    public static int MaxFileCount = 10;

    /*
    *   Cписок со всеми журналами
    */
    private static Gee.ConcurrentList<Logger> _loggerList = new Gee.ConcurrentList<Logger> ();

    /*
    *   Поток который пишет лог в файл
    */
    private static Thread<int> _loggerThread;

    /*
    *   Cписок сообщениями в журнал
    */
    public Gee.ConcurrentList<LogRecord> LogList = new Gee.ConcurrentList<LogRecord> ();

    /*
    *   Индекс текущей строки
    */
    public int CurrentLineIndex = 0;

    /*
    *   Индекс текущего файла
    */
    public int CurrentFileIndex = 0;

    /*
    *   Путь в котором находятся файлы
    */
    public string Path;

    /*
    *   Уровень логирования   
    */
    public LogLevel Level = LogLevel.FATAL;

    /*
    *   Создает поток который пишет лог
    */
    static construct {
        _loggerThread = new Thread<int> ("Logger", Logger.WriteLog);
    }

    /*
    *   Создает журнал
    */
    private Logger(string path) {
        var pathname = Path.build_path (DIR_SEPARATOR, LOG_DIR, path);
        var file = File.new_for_commandline_arg (pathname);
        if (!file.query_exists ()) {
            file.make_directory_with_parents ();
        }
    }

    /*
    *   Берет записи из журнала и пишет в файл
    */
    private static int WriteLog () {
        while (true) {
            foreach (var logger in _loggerList) {
                var file = 

                for (int i = 0; i < logger.LogList.size; i++) {
                    var logRecord = logger.LogList[0];
                    var msg = logRecord.Time.format ("%d.%m.%Y %H:%M:%S") + " " + logRecord.Message;
                    stderr.printf (msg);
                    stderr.printf ("\n");
                    logger.LogList.remove_at (0);
                }   
            }

            Thread.usleep (THREAD_SLEEP);
        }
        return 0;
    }

    /*
    *   Подготавливает путь журнала и возвращает его
    */
    public static Logger GetLogger (string path = "") {
        var logger = new Logger (path);
        _loggerList.add (logger);
        return logger;
    }

    /*
    *   Добавляет линию в буффер
    */
    public void AddLine (string s, LogLevel level = LogLevel.FATAL) {
        if (level > Level) return;
        // Добавляет в список запись журнала
        LogList.add (new LogRecord (this, new DateTime.now_local (), s));
    }
}