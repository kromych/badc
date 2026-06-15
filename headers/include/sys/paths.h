// sys/paths.h -- macOS named-fork path specifiers.
//
// The synthetic path components used to address a file's data and
// resource forks. macOS only.

#ifndef _C5_SYS_PATHS_H
#define _C5_SYS_PATHS_H

#ifdef __APPLE__

#define _PATH_FORKSPECIFIER     "/..namedfork/"
#define _PATH_DATANAME          "data"
#define _PATH_RSRCNAME          "rsrc"
#define _PATH_RSRCFORKSPEC      "/..namedfork/rsrc"

#endif /* __APPLE__ */

#endif /* _C5_SYS_PATHS_H */
