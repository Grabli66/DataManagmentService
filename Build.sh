if [ ! -d "Tests/Build" ]; then
  mkdir Tests/Build
fi

cd Tests/Build

valac -C ../../Src/ConnectionInfo.vala \
         ../../Src/StringHelper.vala \
         ../../Src/Errors.vala \
         ../TestConnectionInfo.vala \
         ../Main.vala

gcc Main.c \
    ConnectionInfo.c \
    StringHelper.c \
    Errors.c \
    TestConnectionInfo.c \
    -I/usr/local/include/glib-2.0 \
    -I/usr/local/lib/glib-2.0/include \
    -lglib-2.0 \
    -lgobject-2.0 \
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
