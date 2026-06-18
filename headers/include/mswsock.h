#pragma once
// mswsock.h -- Microsoft-specific Winsock extensions: the AcceptEx /
// ConnectEx / DisconnectEx / TransmitFile function-pointer types and
// the WSAID_* GUIDs used to retrieve them via WSAIoctl with the
// SIO_GET_EXTENSION_FUNCTION_POINTER command. Include after
// <winsock2.h>.
#ifdef _WIN32
#include <winsock2.h>

// WSAIoctl command code that maps a WSAID_* GUID to the corresponding
// extension function pointer (mswsock.h).
#define SIO_GET_EXTENSION_FUNCTION_POINTER _WSAIORW(IOC_WS2, 6)

// TransmitFile head/tail buffers (mswsock.h). The fields are NULL/0
// when no framing is requested.
typedef struct _TRANSMIT_FILE_BUFFERS {
    LPVOID Head;
    DWORD  HeadLength;
    LPVOID Tail;
    DWORD  TailLength;
} TRANSMIT_FILE_BUFFERS, *PTRANSMIT_FILE_BUFFERS, *LPTRANSMIT_FILE_BUFFERS;

// TransmitFile dwFlags (mswsock.h). TF_REUSE_SOCKET allows the socket
// to be reused for a subsequent AcceptEx after the transfer.
#define TF_DISCONNECT         0x01
#define TF_REUSE_SOCKET       0x02
#define TF_WRITE_BEHIND       0x04
#define TF_USE_DEFAULT_WORKER 0x00
#define TF_USE_SYSTEM_THREAD  0x10
#define TF_USE_KERNEL_APC     0x20

// setsockopt option names for sockets bound through AcceptEx/ConnectEx
// (mswsock.h, SOL_SOCKET level). The socket inherits the listening /
// connecting socket's properties.
#define SO_UPDATE_ACCEPT_CONTEXT  0x700B
#define SO_UPDATE_CONNECT_CONTEXT 0x7010

// Extension-function pointer types (mswsock.h). Retrieved at runtime
// via WSAIoctl(SIO_GET_EXTENSION_FUNCTION_POINTER); they are not
// exported by ws2_32 directly.
typedef BOOL (*LPFN_ACCEPTEX)(SOCKET sListenSocket, SOCKET sAcceptSocket,
                              LPVOID lpOutputBuffer, DWORD dwReceiveDataLength,
                              DWORD dwLocalAddressLength,
                              DWORD dwRemoteAddressLength,
                              LPDWORD lpdwBytesReceived,
                              LPOVERLAPPED lpOverlapped);
typedef BOOL (*LPFN_CONNECTEX)(SOCKET s, const struct sockaddr *name,
                               int namelen, LPVOID lpSendBuffer,
                               DWORD dwSendDataLength, LPDWORD lpdwBytesSent,
                               LPOVERLAPPED lpOverlapped);
typedef BOOL (*LPFN_DISCONNECTEX)(SOCKET s, LPOVERLAPPED lpOverlapped,
                                  DWORD dwFlags, DWORD dwReserved);
typedef BOOL (*LPFN_TRANSMITFILE)(SOCKET hSocket, HANDLE hFile,
                                  DWORD nNumberOfBytesToWrite,
                                  DWORD nNumberOfBytesPerSend,
                                  LPOVERLAPPED lpOverlapped,
                                  LPTRANSMIT_FILE_BUFFERS lpTransmitBuffers,
                                  DWORD dwReserved);
typedef void (*LPFN_GETACCEPTEXSOCKADDRS)(LPVOID lpOutputBuffer,
                                          DWORD dwReceiveDataLength,
                                          DWORD dwLocalAddressLength,
                                          DWORD dwRemoteAddressLength,
                                          struct sockaddr **LocalSockaddr,
                                          int *LocalSockaddrLength,
                                          struct sockaddr **RemoteSockaddr,
                                          int *RemoteSockaddrLength);

// WSAID_* GUIDs that identify the extension functions above (mswsock.h).
// The values are fixed by the Winsock ABI.
#define WSAID_ACCEPTEX \
    {0xb5367df1,0xcbac,0x11cf,{0x95,0xca,0x00,0x80,0x5f,0x48,0xa1,0x92}}
#define WSAID_CONNECTEX \
    {0x25a207b9,0xddf3,0x4660,{0x8e,0xe9,0x76,0xe5,0x8c,0x74,0x06,0x3e}}
#define WSAID_DISCONNECTEX \
    {0x7fda2e11,0x8630,0x436f,{0xa0,0x31,0xf5,0x36,0xa6,0xee,0xc1,0x57}}
#define WSAID_TRANSMITFILE \
    {0xb5367df0,0xcbac,0x11cf,{0x95,0xca,0x00,0x80,0x5f,0x48,0xa1,0x92}}
#define WSAID_GETACCEPTEXSOCKADDRS \
    {0xb5367df2,0xcbac,0x11cf,{0x95,0xca,0x00,0x80,0x5f,0x48,0xa1,0x92}}
#endif
