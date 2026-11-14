/* Mbed TLS settings over its default configuration for the badc build
 * (MBEDTLS_USER_CONFIG_FILE). MBEDTLS_AESCE_C is on by default and, once
 * __ARM_NEON is defined, aesce.c rejects GCC before 6 with #error; badc
 * claims GNU C 4.3. */
#undef MBEDTLS_AESCE_C
