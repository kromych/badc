/* linux/hidraw.h -- raw HID device interface (Linux UAPI subset).
   Minimal, self-contained declarations for the report-descriptor query
   path; the ioctl request codes follow the kernel's _IOR encoding. */
#ifndef _UAPI_HIDRAW_H
#define _UAPI_HIDRAW_H

#include <sys/ioctl.h>
#include <stdint.h>

#define HID_MAX_DESCRIPTOR_SIZE 4096

struct hidraw_report_descriptor {
    uint32_t size;
    uint8_t value[HID_MAX_DESCRIPTOR_SIZE];
};

struct hidraw_devinfo {
    uint32_t bustype;
    int16_t vendor;
    int16_t product;
};

#define HIDIOCGRDESCSIZE _IOR('H', 0x01, int)
#define HIDIOCGRDESC     _IOR('H', 0x02, struct hidraw_report_descriptor)
#define HIDIOCGRAWINFO   _IOR('H', 0x03, struct hidraw_devinfo)

#endif
