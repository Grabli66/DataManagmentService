namespace Tests {
    void TestLogger () {
        var logger = Logger.GetLogger ("Test/Good");

        for (int i = 0; i < 1000; i++) {
            logger.AddLine (i.to_string ());  
        }

        var res = true;

        if (res) {
            stderr.printf ("TestLogger - OK \n");
        } else {
            stderr.printf ("TestLogger - FAIL \n");
        }
    }
}