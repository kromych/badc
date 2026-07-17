// linux/hdreg.h -- a subset of the hard-disk uapi header: the drive geometry
// query. The full register/identify interface is not bundled.

#pragma once

#ifdef __linux__

struct hd_geometry {
    unsigned char heads;
    unsigned char sectors;
    unsigned short cylinders;
    unsigned long start;
};

#define HDIO_GETGEO 0x0301 // get device geometry (struct hd_geometry)

#endif /* __linux__ */
