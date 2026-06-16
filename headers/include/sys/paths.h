// sys/paths.h -- macOS named-fork path specifiers.
//
// The synthetic path components used to address a file's data and
// resource forks. macOS only.

#pragma once

#ifdef __APPLE__

#define _PATH_FORKSPECIFIER     "/..namedfork/"
#define _PATH_DATANAME          "data"
#define _PATH_RSRCNAME          "rsrc"
#define _PATH_RSRCFORKSPEC      "/..namedfork/rsrc"

#endif /* __APPLE__ */
