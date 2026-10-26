// Without UNICODE the generic Win32 names are the A forms (mingw-w64's
// __MINGW_NAME_AW): the registry, environment, file, character, user name,
// RPC string and Winsock calls below go through them on narrow strings and
// agree with the W forms on the same data.

#ifdef _WIN32
#include <winsock2.h>
#include <windows.h>
#include <rpc.h>
#include <string.h>
#include <wchar.h>

static int registry(void) {
    HKEY key;
    DWORD subkeys = 0, subkeysW = 0;
    char name[256];
    DWORD len = sizeof name;
    if (RegOpenKeyEx(HKEY_CURRENT_USER, "Software", 0, KEY_READ, &key) != ERROR_SUCCESS)
        return 1;
    if (RegQueryInfoKey(key, NULL, NULL, NULL, &subkeys, NULL, NULL, NULL, NULL, NULL, NULL,
                        NULL) != ERROR_SUCCESS ||
        RegQueryInfoKeyW(key, NULL, NULL, NULL, &subkeysW, NULL, NULL, NULL, NULL, NULL, NULL,
                         NULL) != ERROR_SUCCESS ||
        subkeys != subkeysW || subkeys == 0)
        return 2;
    if (RegEnumKeyEx(key, 0, name, &len, NULL, NULL, NULL, NULL) != ERROR_SUCCESS ||
        len != strlen(name))
        return 3;
    RegCloseKey(key);
    return 0;
}

static int environment_and_files(void) {
    WIN32_FILE_ATTRIBUTE_DATA data;
    WCHAR wide[MAX_PATH];
    char text[MAX_PATH];
    if (!SetEnvironmentVariable("BADC_GENERIC_NAME", "ansi") ||
        GetEnvironmentVariableW(L"BADC_GENERIC_NAME", wide, 16) != 4 || wcscmp(wide, L"ansi"))
        return 10;
    if (GetDriveType(NULL) != GetDriveTypeW(NULL))
        return 11;
    if (!GetFileAttributesEx(".", GetFileExInfoStandard, &data) ||
        !(data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
        return 12;
    if (GetLongPathName(".", text, MAX_PATH) != GetLongPathNameW(L".", wide, MAX_PATH))
        return 13;
    if (NeedCurrentDirectoryForExePath("x.exe") != NeedCurrentDirectoryForExePathW(L"x.exe"))
        return 14;
    return 0;
}

static int user_and_strings(void) {
    char upper[] = "abc";
    char lower[] = "XYZ";
    char user[256];
    DWORD len = sizeof user;
    if (strcmp(CharUpper(upper), "ABC") || CharLowerBuff(lower, 2) != 2 || strcmp(lower, "xyZ"))
        return 20;
    if (!GetUserName(user, &len) || len != strlen(user) + 1)
        return 21;
    return 0;
}

static int rpc_and_sockets(void) {
    static const char text[] = "6ba7b810-9dad-11d1-80b4-00c04fd430c8";
    UUID id, back;
    RPC_CSTR s = NULL;
    WSADATA wsa;
    struct sockaddr_in in;
    int len = sizeof in;
    if (UuidFromString((RPC_CSTR)text, &id) != RPC_S_OK || UuidToString(&id, &s) != RPC_S_OK ||
        strcmp((const char *)s, text) || UuidFromString(s, &back) != RPC_S_OK ||
        memcmp(&id, &back, sizeof id))
        return 30;
    RpcStringFree(&s);
    if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0)
        return 31;
    char addr[] = "127.0.0.1";
    if (WSAStringToAddress(addr, AF_INET, NULL, (LPSOCKADDR)&in, &len) != 0 ||
        in.sin_addr.s_addr != htonl(0x7f000001))
        return 32;
    WSAPROTOCOL_INFO *info = NULL;
    SOCKET sock = WSASocket(AF_INET, SOCK_STREAM, 0, info, 0, 0);
    if (sock == INVALID_SOCKET)
        return 33;
    closesocket(sock);
    WSACleanup();
    return 0;
}

int main(void) {
    int r;
    if ((r = registry()) || (r = environment_and_files()) || (r = user_and_strings()) ||
        (r = rpc_and_sockets()))
        return r;
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
