namespace Tests {
    public void TestConnectionInfo () {
        var connectionInfo = new ConnectionInfo ("Driver=sqlite Source=database.db");
        var res = true;
        if (connectionInfo.Driver != "sqlite") res = false;
        if (connectionInfo.Source != "database.db") res = false;

        if (res) {
            stderr.printf ("TestConnectionInfo - OK \n");
        } else {
            stderr.printf ("TestConnectionInfo - FAIL \n");
        }
    }
}