/* Demo-local <dinput.h> for RGFW's minigamepad backend on Windows. RGFW loads
 * DirectInput8Create at runtime and supplies its own GUIDs, so this header
 * declares only the DirectInput8 types, the COM interface vtables (method
 * order per the SDK so the used slots resolve), the C-style call macros, and
 * the DI constants the backend reads. No link bindings. */
#ifndef RGFW_DEMO_DINPUT_H
#define RGFW_DEMO_DINPUT_H

#include <windows.h>

#define DIRECTINPUT_VERSION 0x0800

typedef const GUID *REFGUID;
typedef const GUID *REFIID;
typedef void *LPUNKNOWN;

/* Device-object data-format entry and the joystick data format. */
typedef struct {
    const GUID *pguid;
    DWORD dwOfs;
    DWORD dwType;
    DWORD dwFlags;
} DIOBJECTDATAFORMAT, *LPDIOBJECTDATAFORMAT;

typedef struct {
    DWORD dwSize;
    DWORD dwObjSize;
    DWORD dwFlags;
    DWORD dwDataSize;
    DWORD dwNumObjs;
    LPDIOBJECTDATAFORMAT rgodf;
} DIDATAFORMAT, *LPDIDATAFORMAT;

typedef struct {
    LONG lX, lY, lZ, lRx, lRy, lRz;
    LONG rglSlider[2];
    DWORD rgdwPOV[4];
    BYTE rgbButtons[32];
} DIJOYSTATE, *LPDIJOYSTATE;

typedef struct {
    DWORD dwSize;
    DWORD dwFlags;
    DWORD dwDevType;
    DWORD dwAxes;
    DWORD dwButtons;
    DWORD dwPOVs;
    DWORD dwFFSamplePeriod;
    DWORD dwFFMinTimeResolution;
    DWORD dwFirmwareRevision;
    DWORD dwHardwareRevision;
    DWORD dwFFDriverVersion;
} DIDEVCAPS, *LPDIDEVCAPS;

typedef struct {
    DWORD dwSize;
    DWORD dwHeaderSize;
    DWORD dwObj;
    DWORD dwHow;
} DIPROPHEADER, *LPDIPROPHEADER;

typedef struct {
    DIPROPHEADER diph;
    DWORD dwData;
} DIPROPDWORD, *LPDIPROPDWORD;

typedef struct {
    DWORD dwSize;
    GUID guidInstance;
    GUID guidProduct;
    DWORD dwDevType;
    WCHAR tszInstanceName[MAX_PATH];
    WCHAR tszProductName[MAX_PATH];
    GUID guidFFDriver;
    WORD wUsagePage;
    WORD wUsage;
} DIDEVICEINSTANCE, *LPDIDEVICEINSTANCE;
typedef const DIDEVICEINSTANCE *LPCDIDEVICEINSTANCE;

typedef struct IDirectInput8 IDirectInput8;
typedef struct IDirectInputDevice8 IDirectInputDevice8;
typedef BOOL (CALLBACK *LPDIENUMDEVICESCALLBACK)(LPCDIDEVICEINSTANCE, LPVOID);

/* Vtable member order follows IDirectInput8W; unused slots are placeholders so
 * the used methods keep their SDK offsets. */
typedef struct IDirectInput8Vtbl {
    HRESULT (WINAPI *QueryInterface)(IDirectInput8 *, REFIID, void **);
    ULONG (WINAPI *AddRef)(IDirectInput8 *);
    ULONG (WINAPI *Release)(IDirectInput8 *);
    HRESULT (WINAPI *CreateDevice)(IDirectInput8 *, REFGUID,
                                   IDirectInputDevice8 **, LPUNKNOWN);
    HRESULT (WINAPI *EnumDevices)(IDirectInput8 *, DWORD, LPDIENUMDEVICESCALLBACK,
                                  LPVOID, DWORD);
} IDirectInput8Vtbl;
struct IDirectInput8 { const IDirectInput8Vtbl *lpVtbl; };

/* Vtable member order follows IDirectInputDevice8W through Poll (slot 25). */
typedef struct IDirectInputDevice8Vtbl {
    HRESULT (WINAPI *QueryInterface)(IDirectInputDevice8 *, REFIID, void **);
    ULONG (WINAPI *AddRef)(IDirectInputDevice8 *);
    ULONG (WINAPI *Release)(IDirectInputDevice8 *);
    HRESULT (WINAPI *GetCapabilities)(IDirectInputDevice8 *, LPDIDEVCAPS);
    void *EnumObjects;
    void *GetProperty;
    HRESULT (WINAPI *SetProperty)(IDirectInputDevice8 *, REFGUID,
                                  const DIPROPHEADER *);
    HRESULT (WINAPI *Acquire)(IDirectInputDevice8 *);
    HRESULT (WINAPI *Unacquire)(IDirectInputDevice8 *);
    HRESULT (WINAPI *GetDeviceState)(IDirectInputDevice8 *, DWORD, LPVOID);
    void *GetDeviceData;
    HRESULT (WINAPI *SetDataFormat)(IDirectInputDevice8 *, const DIDATAFORMAT *);
    void *SetEventNotification;
    void *SetCooperativeLevel;
    void *GetObjectInfo;
    void *GetDeviceInfo;
    void *RunControlPanel;
    void *Initialize;
    void *CreateEffect;
    void *EnumEffects;
    void *GetEffectInfo;
    void *GetForceFeedbackState;
    void *SendForceFeedbackCommand;
    void *EnumCreatedEffectObjects;
    void *Escape;
    HRESULT (WINAPI *Poll)(IDirectInputDevice8 *);
} IDirectInputDevice8Vtbl;
struct IDirectInputDevice8 { const IDirectInputDevice8Vtbl *lpVtbl; };

#define IDirectInput8_CreateDevice(p, a, b, c) (p)->lpVtbl->CreateDevice(p, a, b, c)
#define IDirectInput8_EnumDevices(p, a, b, c, d) (p)->lpVtbl->EnumDevices(p, a, b, c, d)
#define IDirectInput8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectInputDevice8_GetCapabilities(p, a) (p)->lpVtbl->GetCapabilities(p, a)
#define IDirectInputDevice8_SetProperty(p, a, b) (p)->lpVtbl->SetProperty(p, a, b)
#define IDirectInputDevice8_Acquire(p) (p)->lpVtbl->Acquire(p)
#define IDirectInputDevice8_Unacquire(p) (p)->lpVtbl->Unacquire(p)
#define IDirectInputDevice8_GetDeviceState(p, a, b) (p)->lpVtbl->GetDeviceState(p, a, b)
#define IDirectInputDevice8_SetDataFormat(p, a) (p)->lpVtbl->SetDataFormat(p, a)
#define IDirectInputDevice8_Poll(p) (p)->lpVtbl->Poll(p)
#define IDirectInputDevice8_Release(p) (p)->lpVtbl->Release(p)

/* Data-format object offsets into DIJOYSTATE. */
#define DIJOFS_X 0
#define DIJOFS_Y 4
#define DIJOFS_Z 8
#define DIJOFS_RX 12
#define DIJOFS_RY 16
#define DIJOFS_RZ 20
#define DIJOFS_SLIDER(n) (24 + (n) * 4)
#define DIJOFS_POV(n) (32 + (n) * 4)
#define DIJOFS_BUTTON(n) (48 + (n))

/* Object-type flags (DIDFT_*), data-format flags, property access. */
#define DIDFT_ABSAXIS      0x00000002
#define DIDFT_AXIS         0x00000003
#define DIDFT_BUTTON       0x0000000C
#define DIDFT_POV          0x00000010
#define DIDFT_ANYINSTANCE  0x00FFFF00
#define DIDFT_OPTIONAL     0x80000000
#define DIDOI_ASPECTPOSITION 0x00000100
#define DIDF_ABSAXIS       0x00000001
#define DI_DEGREES 100

#define DIPH_DEVICE 0
#define DIPROPAXISMODE_ABS 0
#define MAKEDIPROP(prop) ((REFGUID)(ULONG_PTR)(prop))
#define DIPROP_AXISMODE MAKEDIPROP(2)

#define DIENUM_STOP 0
#define DIENUM_CONTINUE 1
#define DIEDFL_ALLDEVICES 0x00000000
#define DIEDFL_ATTACHEDONLY 0x00000001
#define DI8DEVCLASS_GAMECTRL 4

#define DIERR_INPUTLOST   ((HRESULT)0x8007001EL)
#define DIERR_NOTACQUIRED ((HRESULT)0x8007000CL)

#endif /* RGFW_DEMO_DINPUT_H */
