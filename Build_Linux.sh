if [ ! -d "Tests/Build" ]; then
  mkdir Tests/Build
fi

cp ./Data/Settings.json ./Tests/Build

cd Tests/Build

valac -C ../../Src/Configuration/ConnectionInfo.vala \
         ../../Src/Configuration/Configuration.vala \
         ../../Src/Configuration/DriverType.vala \
         ../../Src/StringHelper.vala \
         ../../Src/Errors.vala \
         ../TestConfiguration.vala \
         ../Main.vala \
         --pkg json-glib-1.0

gcc Main.c \
    ConnectionInfo.c \
    Configuration.c \
    DriverType.c \
    StringHelper.c \
    Errors.c \
    TestConfiguration.c \
    -I/usr/include/glib-2.0 \
    -I/usr/lib/x86_64-linux-gnu/glib-2.0/include \
    -I/usr/include/json-glib-1.0 \
    -I/usr/lib/glib-2.0/include \
    -lglib-2.0 \
    -lgobject-2.0 \
    -ljson-glib-1.0 \
    -O2 \
    -o Main

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
