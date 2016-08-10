namespace Tests {
    public void TestSqliteEntityManager() {
        Configuration.Load ();
        var manager = ManagerFactory.GetManager ();
        var entity = manager.CreateEntity ();
    }
}