if [ ! -d "build" ]; then
  mkdir build
fi

cd build
valac -C ../Main.vala \
         ../DSDatabase.vala \
         ../DSAttribute.vala \
         ../DSEntity.vala \
         ../DSEntityFactory.vala \
         ../DSUider.vala \
         ../DSCoreUids.vala \
         --pkg=libgda-6.0 \
         --pkg=gee-0.8
gcc Main.c DSDatabase.c DSAttribute.c DSEntity.c DSEntityFactory.c DSUider.c \
    -I/usr/include/glib-2.0 \
    -I/usr/lib/x86_64-linux-gnu/glib-2.0/include \
    -I/usr/include/libgda-6.0 \
    -I/usr/include/libxml2 \
    -I/usr/include/libgda-6.0/libgda \
    -I/usr/include/gee-0.8 \
    -lglib-2.0 -lgobject-2.0 -lgda-6.0 -lgee-0.8 \
    -O2 \
    -o Main
