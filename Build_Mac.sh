if [ ! -d "Tests/Build" ]; then
  mkdir Tests/Build
fi

cp ./Data/Settings.json ./Tests/Build

cd Tests/Build

valac -C ../../Src/Configuration/ConnectionInfo.vala \
         ../../Src/Configuration/Configuration.vala \
         ../../Src/Configuration/DriverType.vala \
         ../../Src/Logger/Logger.vala \
         ../../Src/StringHelper.vala \
         ../../Src/Errors.vala \
         ../TestConfiguration.vala \
         ../TestLogger.vala \
         ../Main.vala \
         --pkg json-glib-1.0

gcc Main.c \
    ConnectionInfo.c \
    Configuration.c \
    DriverType.c \
    StringHelper.c \
    Errors.c \
    Logger.c \
    TestConfiguration.c \
    TestLogger.c \
    -I/usr/local/include/glib-2.0 \
    -I/usr/local/lib/glib-2.0/include \
    -I/usr/local/include/json-glib-1.0 \
    -I/usr/local/lib/glib-2.0/include \
    -lglib-2.0 \
    -lgobject-2.0 \
    -ljson-glib-1.0 \
    -O2 \
    -o Main

./Main