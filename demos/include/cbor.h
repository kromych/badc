/* Minimal <cbor.h> for building against the system libcbor. Declares only the
 * decode-side item accessors, the load-result / pair / error structs, and the
 * enums that consuming code here uses; the builder API, streaming decoder,
 * serializer, and configuration are omitted. `cbor_item_t` stays opaque
 * (all access is through the accessor functions). The ABI matches libcbor
 * 0.x; the implementation is the system libcbor, linked in as usual. */
#ifndef LIBCBOR_CBOR_H
#define LIBCBOR_CBOR_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

typedef struct cbor_item_t cbor_item_t;

enum cbor_error_code {
    CBOR_ERR_NONE = 0,
    CBOR_ERR_NOTENOUGHDATA,
    CBOR_ERR_NODATA,
    CBOR_ERR_MALFORMATED,
    CBOR_ERR_MEMERROR,
    CBOR_ERR_SYNTAXERROR
};

struct cbor_error {
    size_t position;
    enum cbor_error_code code;
};

struct cbor_load_result {
    struct cbor_error error;
    size_t read;
};

struct cbor_pair {
    cbor_item_t *key;
    cbor_item_t *value;
};

typedef enum {
    CBOR_INT_8 = 0,
    CBOR_INT_16,
    CBOR_INT_32,
    CBOR_INT_64
} cbor_int_width;

/* Decode a byte buffer into an item tree; on success the caller owns one
 * reference, released with cbor_decref. */
cbor_item_t *cbor_load(const unsigned char *source, size_t source_size,
                       struct cbor_load_result *result);
void cbor_decref(cbor_item_t **item);

/* Type predicates. */
bool cbor_isa_uint(const cbor_item_t *item);
bool cbor_isa_string(const cbor_item_t *item);
bool cbor_isa_array(const cbor_item_t *item);
bool cbor_isa_map(const cbor_item_t *item);

/* Unsigned-integer accessors. */
cbor_int_width cbor_int_get_width(const cbor_item_t *item);
uint8_t cbor_get_uint8(const cbor_item_t *item);

/* String accessors. */
size_t cbor_string_length(const cbor_item_t *item);
unsigned char *cbor_string_handle(const cbor_item_t *item);

/* Array accessors. */
size_t cbor_array_size(const cbor_item_t *item);
cbor_item_t *cbor_array_get(const cbor_item_t *item, size_t index);

/* Map accessors. */
size_t cbor_map_size(const cbor_item_t *item);
struct cbor_pair *cbor_map_handle(const cbor_item_t *item);

#endif /* LIBCBOR_CBOR_H */
