/*
*   Уровень логирования
*/
public enum LogLevel {
    FATAL,
    INFO,
    DEBUG;
}

/*
*   Элемент списка с именами файлов лога
*/
public class NameItem {
    public string Name;
    public int Index;

    public NameItem (string name, int index) {
        Name = name;
        Index = index;
    }
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
public class Logger {
    /*
    *   Название log файла
    */
    public const string LOG_NAME = "Log";

    /*
    *   Разделитель файлов
    */
    public const string DIR_SEPARATOR = "/";

    /*
    *   Папка в которой хранятся все логи
    */
    public const string LOG_DIR = "Logs";

    /*
    *   Пауза между записью в файл
    */
    public const int THREAD_SLEEP = 1000;

    /*
    *   Cписок со всеми журналами
    */
    private static Gee.HashMap<string, Logger> _loggerMap;

    /*
    *   Поток который пишет лог в файл
    */
    private static Thread<void*> _loggerThread;

    /*
    *   Максимальный размер файла
    */
    public static int MaxFileSize = 100000;

    /*
    *   Максимальное количество файлов
    */
    public static int MaxFileCount = 5;

    /*
    *   Cписок сообщениями в журнал
    */
    public Gee.ArrayList<LogRecord> LogList = new Gee.ArrayList<LogRecord> ();

    /*
    *   Путь в котором находятся файлы
    */
    public string PathName;

    /*
    *   Уровень логирования   
    */
    public LogLevel Level = LogLevel.FATAL;
    
    /*
    *   Создает поток который пишет лог
    */
    static construct {
        _loggerThread = new Thread<void*> ("Logger", Logger.WriteLog);
    }

    /*
    *   Создает журнал
    */
    private Logger(string path) {
        PathName = Path.build_path (DIR_SEPARATOR, LOG_DIR, path);
    }

    /*
    *   Двигает журналы
    */
    private void MoveFiles () {
        var dir = File.new_for_path (PathName);
        var enumerator = dir.enumerate_children (FileAttribute.STANDARD_NAME, 0);

        var nameList = new Gee.ArrayList<NameItem> ();
        FileInfo file_info;
        while ((file_info = enumerator.next_file ()) != null) {
            var name = file_info.get_name ();
            var nameStrs = name.split (".");
            if (nameStrs.length < 2) continue;
            if (nameStrs[0] != LOG_NAME) continue;
            var index = -1;
            if (nameStrs.length > 2) index = int.parse (nameStrs[1]);
            var nameItem = new NameItem (name, index);
            nameList.add (nameItem);
        }

        nameList.sort ((a, b) => {
            return b.Index - a.Index;
        });

        foreach (var item in nameList) {
            var nindex = item.Index + 1;
            var filePath = Path.build_path (DIR_SEPARATOR, PathName, item.Name);
            var file = File.new_for_path (filePath);
            if (nindex > MaxFileCount) {
                file.delete ();
            } else {
                var nname = LOG_NAME + "." + nindex.to_string () + ".log";
                file.set_display_name (nname);
            }
        }
    }

    /*
    *   Подготавливает файл и возвращает поток для вывода
    */
    public DataOutputStream OpenStream () {
        // Создает все необходимые директории
        var file = File.new_for_path (PathName);
        if (!file.query_exists ()) {
            file.make_directory_with_parents ();
        }

        var fileName = LOG_NAME + ".log";
        var filePath = Path.build_path (DIR_SEPARATOR, PathName, fileName);
        file = File.new_for_path (filePath);
        // TODO: сделать проверку размера файла
        if (file.query_exists ()) {
            var fileInfo = file.query_info ("*", FileQueryInfoFlags.NONE);
            var fileSize = fileInfo.get_size ();
            if (fileSize > MaxFileSize) {
                MoveFiles ();
            }
        }

        file = File.new_for_path (filePath);
        var fstr = file.append_to (FileCreateFlags.NONE);
        var data_stream = new DataOutputStream (fstr);
        return data_stream;
    }

    /*
    *   Берет записи из журнала и пишет в файл
    */
    private static void* WriteLog () {
        while (true) {
            foreach (var logger in _loggerMap.values) {
                // Вычисление размера списка очень медленное

                LogRecord[] data;
                int size = 0;
                lock (logger.LogList) {
                    data = logger.LogList.to_array ();
                    size = data.length;
                    logger.LogList.clear ();
                }

                if (size < 1) continue;
                var data_stream = logger.OpenStream ();

                for (int i = 0; i < size; i++) {
                    var logRecord = data[i];
                    var micro = "." + logRecord.Time.get_microsecond ().to_string ();
                    var msg = logRecord.Time.format ("%d.%m.%Y %H:%M:%S") + micro + " " + logRecord.Message + "\n";
                    data_stream.put_string (msg);
                }
            }
            _loggerThread.usleep (THREAD_SLEEP);
        }
    }

    /*
    *   Подготавливает путь журнала и возвращает его
    */
    public static Logger GetLogger (string path = "") {
        // Не хочет создавать через construct
        if (_loggerMap == null) _loggerMap = new Gee.HashMap<string, Logger> ();
        if (_loggerMap.has_key (path)) return _loggerMap[path];

        var logger = new Logger (path);
        _loggerMap[path] = logger;
        return logger;
    }

    /*
    *   Добавляет линию в буффер
    */
    public void AddLine (string s, LogLevel level = LogLevel.FATAL) {
        if (level > Level) return;
        // Добавляет в список запись журнала
        lock (LogList) {
            // Получение текущего времени медленное если использовать now_local
            // Поэтому запоминается временная зона и используется now с передачей зоны
            var tz = Configuration.GetInstance ().LocalTimeZone;
            LogList.add (new LogRecord (this, new DateTime.now (tz), s));
        }
    }
}