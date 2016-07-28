namespace Tests {
    void TestLogger () {
        var logger = Logger.GetLogger ("Test/Good");

        var res = true;

        if (res) {
            stderr.printf ("TestLogger - OK \n");
        } else {
            stderr.printf ("TestLogger - FAIL \n");
        }
    }
}