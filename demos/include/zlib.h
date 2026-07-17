/* Minimal <zlib.h> for building against the system zlib. Declares only the
 * types, constants, and entry points that consuming code here uses; the ABI
 * (types, struct layout, constant values, signatures) matches upstream zlib
 * 1.2.x. The full upstream header's gz* file I/O, dictionary/tuning/header
 * calls, 64-bit large-file variants, and configuration machinery are omitted.
 * The implementation is the system libz, supplied at link time. */
#ifndef ZLIB_H
#define ZLIB_H

#define ZLIB_VERSION "1.2.12"

typedef unsigned char Byte;
typedef unsigned int uInt;   /* at least 16 bits */
typedef unsigned long uLong; /* at least 32 bits */
typedef Byte Bytef;
typedef uLong uLongf;
typedef void *voidpf;

typedef voidpf (*alloc_func)(voidpf opaque, uInt items, uInt size);
typedef void (*free_func)(voidpf opaque, voidpf address);

struct internal_state;

typedef struct z_stream_s {
    const Bytef *next_in; /* next input byte */
    uInt avail_in;        /* number of bytes available at next_in */
    uLong total_in;       /* total number of input bytes read so far */

    Bytef *next_out; /* next output byte will go here */
    uInt avail_out;  /* remaining free space at next_out */
    uLong total_out; /* total number of bytes output so far */

    const char *msg;              /* last error message, NULL if no error */
    struct internal_state *state; /* not visible by applications */

    alloc_func zalloc; /* used to allocate the internal state */
    free_func zfree;   /* used to free the internal state */
    voidpf opaque;     /* private data object passed to zalloc and zfree */

    int data_type; /* best guess about the data type */
    uLong adler;   /* Adler-32 or CRC-32 value of the uncompressed data */
    uLong reserved;
} z_stream;

typedef z_stream *z_streamp;

/* flush values */
#define Z_NO_FLUSH 0
#define Z_PARTIAL_FLUSH 1
#define Z_SYNC_FLUSH 2
#define Z_FULL_FLUSH 3
#define Z_FINISH 4
#define Z_BLOCK 5
#define Z_TREES 6

/* return codes */
#define Z_OK 0
#define Z_STREAM_END 1
#define Z_NEED_DICT 2
#define Z_ERRNO (-1)
#define Z_STREAM_ERROR (-2)
#define Z_DATA_ERROR (-3)
#define Z_MEM_ERROR (-4)
#define Z_BUF_ERROR (-5)
#define Z_VERSION_ERROR (-6)

/* compression levels */
#define Z_NO_COMPRESSION 0
#define Z_BEST_SPEED 1
#define Z_BEST_COMPRESSION 9
#define Z_DEFAULT_COMPRESSION (-1)

/* compression strategies */
#define Z_FILTERED 1
#define Z_HUFFMAN_ONLY 2
#define Z_RLE 3
#define Z_FIXED 4
#define Z_DEFAULT_STRATEGY 0

/* data types */
#define Z_BINARY 0
#define Z_TEXT 1
#define Z_UNKNOWN 2

#define Z_DEFLATED 8
#define Z_NULL 0
#define MAX_WBITS 15
#define MAX_MEM_LEVEL 9

/* The Init entry points take the header version and struct size so the
 * library can reject a caller built against an incompatible ABI; the
 * user-facing forms are the macros below. */
extern int deflateInit_(z_streamp strm, int level, const char *version,
                        int stream_size);
extern int deflateInit2_(z_streamp strm, int level, int method, int windowBits,
                         int memLevel, int strategy, const char *version,
                         int stream_size);
extern int inflateInit_(z_streamp strm, const char *version, int stream_size);
extern int inflateInit2_(z_streamp strm, int windowBits, const char *version,
                         int stream_size);

#define deflateInit(strm, level) \
    deflateInit_((strm), (level), ZLIB_VERSION, (int)sizeof(z_stream))
#define deflateInit2(strm, level, method, windowBits, memLevel, strategy)  \
    deflateInit2_((strm), (level), (method), (windowBits), (memLevel),     \
                  (strategy), ZLIB_VERSION, (int)sizeof(z_stream))
#define inflateInit(strm) \
    inflateInit_((strm), ZLIB_VERSION, (int)sizeof(z_stream))
#define inflateInit2(strm, windowBits) \
    inflateInit2_((strm), (windowBits), ZLIB_VERSION, (int)sizeof(z_stream))

extern int deflate(z_streamp strm, int flush);
extern int deflateEnd(z_streamp strm);
extern int deflateParams(z_streamp strm, int level, int strategy);
extern int inflate(z_streamp strm, int flush);
extern int inflateEnd(z_streamp strm);
extern int inflateReset(z_streamp strm);

extern int compress(Bytef *dest, uLongf *destLen, const Bytef *source,
                    uLong sourceLen);
extern int compress2(Bytef *dest, uLongf *destLen, const Bytef *source,
                     uLong sourceLen, int level);
extern int uncompress(Bytef *dest, uLongf *destLen, const Bytef *source,
                      uLong sourceLen);
extern uLong compressBound(uLong sourceLen);

extern uLong adler32(uLong adler, const Bytef *buf, uInt len);
extern uLong crc32(uLong crc, const Bytef *buf, uInt len);

#endif /* ZLIB_H */
