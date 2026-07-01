/* Minimal <linux/joystick.h> for the RGFW gamepad path (demo-local).
 * Only the event record and the few constants RGFW reads. */
#ifndef _LINUX_JOYSTICK_H_
#define _LINUX_JOYSTICK_H_

struct js_event {
    unsigned int time;   /* event timestamp in milliseconds */
    short value;         /* axis position / button state */
    unsigned char type;  /* event type */
    unsigned char number; /* axis / button index */
};

#define JS_EVENT_BUTTON 0x01
#define JS_EVENT_AXIS 0x02
#define JS_EVENT_INIT 0x80

/* _IOR('j', 0x11, __u8): number of axes */
#define JSIOCGAXES 0x80016a11

#endif /* _LINUX_JOYSTICK_H_ */
