void main () {
    try {
        // Загружает конфигурацию сервиса
        Configuration.Load ();
        // Стартует сервис
        var service = new Service ();
        service.Start ();
    } catch (Error e) {
        Logger.Error (e);
    }
}