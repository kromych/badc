// wincrypt.h -- the subset of the Windows CryptoAPI (advapi32) that the c5
// demos reach: provider + hash objects for MD4 / MD5 / SHA-256, and the DES
// key path used by the legacy NTLM core. The handle types are pointer-width
// integers; the algorithm identifiers and provider/flag constants carry their
// documented values.

#pragma once

#include <windows.h>

// HCRYPTPROV / HCRYPTKEY come from <windows.h>; add the hash handle and the
// algorithm-id scalar here.
typedef void        *HCRYPTHASH;
typedef unsigned int ALG_ID;

#define PROV_RSA_FULL       1
#define PROV_RSA_AES        24
#define CRYPT_VERIFYCONTEXT 0xF0000000
#define CRYPT_SILENT        0x00000040
#define CRYPT_NEWKEYSET     0x00000008

#define CALG_MD4     0x00008002
#define CALG_MD5     0x00008003
#define CALG_SHA_256 0x0000800C
#define CALG_DES     0x00006601

#define HP_HASHVAL   0x0002
#define HP_HASHSIZE  0x0004

#pragma binding(advapi32::CryptAcquireContextA, "CryptAcquireContextA")
#pragma binding(advapi32::CryptReleaseContext,  "CryptReleaseContext")
#pragma binding(advapi32::CryptCreateHash,      "CryptCreateHash")
#pragma binding(advapi32::CryptHashData,        "CryptHashData")
#pragma binding(advapi32::CryptGetHashParam,    "CryptGetHashParam")
#pragma binding(advapi32::CryptDestroyHash,     "CryptDestroyHash")
#pragma binding(advapi32::CryptImportKey,       "CryptImportKey")
#pragma binding(advapi32::CryptDestroyKey,      "CryptDestroyKey")
#pragma binding(advapi32::CryptEncrypt,         "CryptEncrypt")

#define CryptAcquireContext CryptAcquireContextA

int CryptAcquireContextA(HCRYPTPROV *prov, const char *container,
                         const char *provider, DWORD prov_type, DWORD flags);
int CryptReleaseContext(HCRYPTPROV prov, DWORD flags);
int CryptCreateHash(HCRYPTPROV prov, ALG_ID algid, HCRYPTKEY key, DWORD flags,
                    HCRYPTHASH *hash);
int CryptHashData(HCRYPTHASH hash, const BYTE *data, DWORD len, DWORD flags);
int CryptGetHashParam(HCRYPTHASH hash, DWORD param, BYTE *data, DWORD *len,
                      DWORD flags);
int CryptDestroyHash(HCRYPTHASH hash);
int CryptImportKey(HCRYPTPROV prov, const BYTE *data, DWORD len,
                   HCRYPTKEY pubkey, DWORD flags, HCRYPTKEY *key);
int CryptDestroyKey(HCRYPTKEY key);
int CryptEncrypt(HCRYPTKEY key, HCRYPTHASH hash, int final, DWORD flags,
                 BYTE *data, DWORD *len, DWORD buflen);
