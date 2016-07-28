namespace Tests {
    void TestConfiguration () {
        Configuration.Load ();
        var config = Configuration.GetInstance ();        
        
        var res = true;
        if (config.Connection.Driver != DriverType.SQLITE) res = false;
        if (config.Connection.Source != "database.db") res = false;

        if (res) {
            stderr.printf ("TestConfiguration - OK \n");
        } else {
            stderr.printf ("TestConfiguration - FAIL \n");
        }
    }
}