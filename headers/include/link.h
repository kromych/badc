#pragma once

// Dynamic linker introspection (Linux <link.h>). `dladdr1` with
// RTLD_DL_LINKMAP yields a `struct link_map *` whose `l_addr` is the
// load bias of the containing object. Only the leading public members
// are spelled out; the linker-private tail is not exposed.

struct link_map {
    unsigned long     l_addr;    // load bias added to the object's vaddrs
    char             *l_name;    // absolute pathname of the object
    void             *l_ld;      // the object's PT_DYNAMIC table
    struct link_map  *l_next;
    struct link_map  *l_prev;
};
