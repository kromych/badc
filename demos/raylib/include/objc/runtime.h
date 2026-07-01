/* Minimal Objective-C runtime declarations for driving Cocoa from C via
 * objc_msgSend, as RGFW does on macOS. Opaque object/class/selector
 * handles plus the small set of runtime entry points RGFW calls. The
 * real types are pointers to opaque structs; that is all a C caller
 * needs. */
#ifndef _OBJC_RUNTIME_H
#define _OBJC_RUNTIME_H

#include <os/availability.h>

typedef struct objc_class *Class;
typedef struct objc_object {
    Class isa;
} *id;
typedef struct objc_selector *SEL;
typedef id (*IMP)(id, SEL, ...);
typedef struct objc_method *Method;
typedef struct objc_ivar *Ivar;
typedef signed char BOOL;

#define YES ((BOOL)1)
#define NO ((BOOL)0)
#ifndef nil
#define nil ((id)0)
#endif
#ifndef Nil
#define Nil ((Class)0)
#endif

struct objc_super {
    id receiver;
    Class super_class;
};

SEL sel_registerName(const char *name);
SEL sel_getUid(const char *str);
Class objc_getClass(const char *name);
Class object_getClass(id obj);
Class class_getSuperclass(Class cls);
Class objc_allocateClassPair(Class superclass, const char *name,
                             unsigned long extraBytes);
void objc_registerClassPair(Class cls);
void objc_disposeClassPair(Class cls);
BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types);
BOOL class_addIvar(Class cls, const char *name, unsigned long size,
                   unsigned char alignment, const char *types);
Ivar object_getInstanceVariable(id obj, const char *name, void **outValue);
Ivar object_setInstanceVariable(id obj, const char *name, void *value);

#endif /* _OBJC_RUNTIME_H */
