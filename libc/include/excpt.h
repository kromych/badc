// <excpt.h> -- Microsoft structured exception handling: the language
// handler a `__try` statement's scope table names, the results a filter
// returns and a handler reports, and the intrinsics a filter, an
// `__except` body and a `__finally` body read, with their Win32
// spellings, under the names MSVC's header gives them.

#pragma once

#ifdef _WIN32

typedef enum _EXCEPTION_DISPOSITION {
    ExceptionContinueExecution,
    ExceptionContinueSearch,
    ExceptionNestedException,
    ExceptionCollidedUnwind
} EXCEPTION_DISPOSITION;

struct _EXCEPTION_RECORD;
struct _CONTEXT;
struct _DISPATCHER_CONTEXT;
struct _EXCEPTION_POINTERS;

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::__C_specific_handler, "__C_specific_handler")
EXCEPTION_DISPOSITION __C_specific_handler(struct _EXCEPTION_RECORD *ExceptionRecord,
                                           void *EstablisherFrame,
                                           struct _CONTEXT *ContextRecord,
                                           struct _DISPATCHER_CONTEXT *DispatcherContext);

// Valid in an `__except` filter or body, in a filter, and in a
// `__finally` body respectively; the compiler supplies the values.
unsigned long _exception_code(void);
void *_exception_info(void);
int _abnormal_termination(void);

#define GetExceptionCode            _exception_code
#define exception_code              _exception_code
#define GetExceptionInformation()   ((struct _EXCEPTION_POINTERS *)_exception_info())
#define exception_info()            ((struct _EXCEPTION_POINTERS *)_exception_info())
#define AbnormalTermination         _abnormal_termination
#define abnormal_termination        _abnormal_termination

// What a filter returns.
#define EXCEPTION_EXECUTE_HANDLER      1
#define EXCEPTION_CONTINUE_SEARCH      0
#define EXCEPTION_CONTINUE_EXECUTION (-1)

#endif
