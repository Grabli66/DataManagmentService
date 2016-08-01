namespace Tests {
    public void main () {
        //TestConfiguration ();
        TestLogger ();

        var mainLoop = new MainLoop ();
        mainLoop.run ();
    }
}