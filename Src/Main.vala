void main () {
    try {
        // Загружает конфигурацию сервиса
        Configuration.Init ();
        // Стартует сервис
        var service = new Service ();
        service.Start ();
    } catch (Error e) {
        Logger.Error (e);
    }
}