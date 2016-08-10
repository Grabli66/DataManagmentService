namespace Tests {
    void TestLogger () {
        Configuration.Load ();
        var logger = Logger.GetLogger ("Test/Good");

        for (int i = 0; i < 20000; i++) {
            logger.AddLine (i.to_string ());  
        }

        var mainloop = new MainLoop ();

        Timeout.add_seconds (5, () => {
            mainloop.quit ();
            return true;
        });

        mainloop.run ();

        var res = true;

        if (res) {
            stderr.printf ("TestLogger - OK \n");
        } else {
            stderr.printf ("TestLogger - FAIL \n");
        }
    }
}