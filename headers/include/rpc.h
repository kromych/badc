#pragma once
// rpc.h -- MS-RPC runtime subset: UUID/GUID string conversion used by
// the AF_HYPERV address path. Bound to rpcrt4.dll.
#ifdef _WIN32
#include <windows.h>

typedef long RPC_STATUS;
typedef unsigned short *RPC_WSTR;
typedef const unsigned short *RPC_CWSTR;
typedef unsigned char *RPC_CSTR;
typedef GUID UUID;

#define RPC_S_OK 0

#pragma dylib(rpcrt4, "rpcrt4.dll")
#pragma binding(rpcrt4::UuidToStringW,   "UuidToStringW")
#pragma binding(rpcrt4::UuidFromStringW, "UuidFromStringW")
#pragma binding(rpcrt4::RpcStringFreeW,  "RpcStringFreeW")

RPC_STATUS UuidToStringW(const UUID *Uuid, RPC_WSTR *StringUuid);
RPC_STATUS UuidFromStringW(RPC_WSTR StringUuid, UUID *Uuid);
RPC_STATUS RpcStringFreeW(RPC_WSTR *String);
#endif
