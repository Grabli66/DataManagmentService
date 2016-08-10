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
         ../../Src/EntityManagers/Attribute.vala \
         ../../Src/EntityManagers/Entity.vala \
         ../../Src/EntityManagers/IEntityManager.vala \
         ../../Src/EntityManagers/ManagerFactory.vala \
         ../../Src/EntityManagers/SqliteEntityManager.vala \
         ../TestConfiguration.vala \
         ../TestLogger.vala \
         ../TestSqliteEntityManager.vala \
         ../Main.vala \
         --pkg json-glib-1.0 \
         --pkg gee-0.8 \
         --pkg gio-2.0 \
         --pkg sqlite3 \

gcc Main.c \
    ConnectionInfo.c \
    Configuration.c \
    DriverType.c \
    StringHelper.c \
    Errors.c \
    Attribute.c \
    Entity.c \
    IEntityManager.c \
    ManagerFactory.c \
    SqliteEntityManager.c \
    Logger.c \
    TestConfiguration.c \
    TestLogger.c \
    TestSqliteEntityManager.c \
    -I/usr/include/glib-2.0 \
    -I/usr/lib/x86_64-linux-gnu/glib-2.0/include \
    -I/usr/include/json-glib-1.0 \
    -I/usr/lib/glib-2.0/include \
    -I/usr/include/gee-0.8 \
    -I/usr/include/sqlite3 \
    -lglib-2.0 \
    -lgobject-2.0 \
    -ljson-glib-1.0 \
    -lgee-0.8 \
    -lgio-2.0 \
    -lsqlite3 \
    -O2 \
    -o Main

clear
./Main

#if [ ! -d "Build" ]; then
#  mkdir Build
#fi

#cd Build

#valac -C ../Main.vala \
#         ../DSDatabase.vala \
#         ../DSAttribute.vala \
#         ../DSEntity.vala \
#         ../DSEntityFactory.vala \
#         ../DSUider.vala \
#         ../DSCoreUids.vala \
#         --pkg=libgda-6.0 \
#         --pkg=gee-0.8
#gcc Main.c DSDatabase.c DSAttribute.c DSEntity.c DSEntityFactory.c DSUider.c \
#    -I/usr/include/glib-2.0 \
#    -I/usr/lib/x86_64-linux-gnu/glib-2.0/include \
#    -I/usr/include/libgda-6.0 \
#    -I/usr/include/libxml2 \
#    -I/usr/include/libgda-6.0/libgda \
#    -I/usr/include/gee-0.8 \
#    -lglib-2.0 -lgobject-2.0 -lgda-6.0 -lgee-0.8 \
#    -O2 \
#    -o Main
