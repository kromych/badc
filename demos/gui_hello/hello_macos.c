/* Minimal Cocoa "Hello, world!" demo for the macOS-aarch64
 * target. macOS GUI requires Objective-C messaging; c5
 * doesn't speak ObjC, so we drive the Apple ObjC runtime
 * (`libobjc.A.dylib`) directly:
 *
 *   * `objc_getClass("NSApplication")` returns the `Class`
 *     metaobject the receiver dispatches against.
 *   * `sel_registerName("sharedApplication")` interns the
 *     selector for `[NSApplication sharedApplication]`.
 *   * `objc_msgSend(receiver, sel, ...args)` is the
 *     dispatcher every `[recv sel:arg]` ObjC syntax compiles
 *     down to. We call it as a regular C variadic function.
 *
 * The result is a window-on-screen Cocoa app that opens a
 * single NSWindow, runs the standard NSApp event loop, and
 * exits when the user closes the window. No nib, no
 * AppKit shortcut path, no XIB / storyboard.
 *
 * Build:
 *
 *     badc --target=macos-aarch64 demos/gui_hello/hello_macos.c -o hello-macos
 *     ./hello-macos
 *
 * Caveats:
 *   * Cocoa expects a few coordinated bits of state
 *     (`activateIgnoringOtherApps:` etc.); the demo
 *     follows the AppKit boilerplate Apple's documentation
 *     spells out (cf. "Bundles and Frameworks" /
 *     `Apple-AppKit-Sample-Code`).
 *   * Frameworks resolve through `/System/Library/Frameworks`
 *     -- listed below the same way `libSystem` is. */

#include <stdio.h>
#include <stdlib.h>

/* libobjc.A.dylib -- the ObjC runtime. */
#pragma dylib(libobjc, "/usr/lib/libobjc.A.dylib")
#pragma binding(libobjc::objc_getClass,    "_objc_getClass")
#pragma binding(libobjc::sel_registerName, "_sel_registerName")
#pragma binding(libobjc::objc_msgSend,     "_objc_msgSend")
/* objc_msgSend's *underlying* ABI follows the receiver method's
 * declared signature, not a variadic register layout. Apple's
 * runtime is happy to be called with any argument shape that
 * matches the method's selector, but each call site has to
 * pick the right register / stack assignment for that
 * signature. c5 picks one calling convention per binding, so
 * we declare each shape we use as a *separate*, non-variadic
 * binding pointing at the same `_objc_msgSend` symbol. The
 * non-variadic prototype below lets c5 emit standard AAPCS64
 * register-passing (first 4 doubles in d0..d3, first few
 * integers in x0..x7), which matches what AppKit expects of
 * the method we're dispatching to. */
#pragma binding(libobjc::objc_msgSend_rect, "_objc_msgSend")
#pragma binding(libobjc::objc_msgSend_b,    "_objc_msgSend")
#pragma binding(libobjc::objc_msgSend_p,    "_objc_msgSend")

void *objc_getClass(char *name);
void *sel_registerName(char *name);
/* `objc_msgSend(id self, SEL op, ...)` -- variadic trampoline
 * for the call sites that match Apple's "two-arg-and-no-FP"
 * shape (alloc, run, ...). */
void *objc_msgSend(void *recv, void *sel, ...);
/* Non-variadic specialisation for the NSWindow initWithContentRect
 * shape: receiver + selector + four NSRect doubles + three
 * integer arguments. With a non-variadic prototype, c5 emits the
 * standard AAPCS64 register layout (d0..d3 for the NSRect
 * doubles; x2..x4 for the styleMask / backing / defer), which is
 * what AppKit's selector implementation reads on macOS arm64. */
void *objc_msgSend_rect(void *recv, void *sel,
                        double x, double y, double w, double h,
                        long long mask, long long backing, long long defer);
/* Non-variadic specialisation for selectors that take a single
 * `long long`-shaped argument (BOOL / NSUInteger). Examples:
 * `activateIgnoringOtherApps:`. */
void *objc_msgSend_b(void *recv, void *sel, long long arg);
/* Non-variadic specialisation for selectors that take a single
 * pointer (`id` / `NSString *` / `char *`). Examples:
 * `setTitle:`, `makeKeyAndOrderFront:`,
 * `stringWithUTF8String:`. */
void *objc_msgSend_p(void *recv, void *sel, void *arg);

/* Cocoa lives in AppKit.framework; pulling
 * `_NSApp` etc. would normally happen through AppKit's
 * exported symbols, but everything we need flows through
 * objc_msgSend, so we link AppKit only for symbol
 * resolution at app startup. The `link` directive is
 * Mach-O-side (LC_LOAD_DYLIB) rather than badc-side
 * (#pragma dylib doesn't currently emit framework
 * paths), so we fall back to declaring the framework
 * inline through the runtime's existing dylib syntax. */
#pragma dylib(appkit, "/System/Library/Frameworks/AppKit.framework/AppKit")

/* AppKit constants the demo uses. NSWindowStyleMaskTitled =
 * 0x1, NSWindowStyleMaskClosable = 0x2,
 * NSWindowStyleMaskResizable = 0x8. Combined: a normal
 * windowed app with a title bar, close button, and resize
 * grip. NSBackingStoreBuffered = 2 -- the only backing
 * store macOS supports today, but the API still wants
 * the constant. */
#define NS_TITLED      0x1
#define NS_CLOSABLE    0x2
#define NS_RESIZABLE   0x8
#define NS_BACKING_BUF 2

/* NSRect-shaped argument (CGFloat == double on 64-bit Apple
 * platforms). Cocoa's frame APIs take it by value; with c5's
 * struct-by-value support that means four doubles back-to-
 * back. Today c5 marshals struct-by-value through pointer
 * thunks for many APIs; for objc_msgSend we route through
 * the variadic surface, which AAPCS64 / SysV both spell as
 * "first 4 doubles in d0..d3" -- the same convention NSRect
 * uses. */

int main(int argc, char **argv) {
    (void)argc; (void)argv;

    /* [NSApplication sharedApplication] -- the singleton
     * NSApp instance that owns the run loop. */
    void *NSApplication = objc_getClass("NSApplication");
    void *sharedApp     = sel_registerName("sharedApplication");
    void *app = objc_msgSend(NSApplication, sharedApp);
    if (!app) {
        fprintf(stderr, "hello-macos: NSApplication sharedApplication failed\n");
        return 1;
    }

    /* NSWindow alloc + init with content rect, style mask,
     * backing store, defer flag. The four NSRect doubles
     * land in d0..d3 of the variadic call, the integer
     * mask + backing + defer in x0..x2 (after the receiver
     * + selector). Cocoa returns the new window ID. */
    void *NSWindow = objc_getClass("NSWindow");
    void *alloc    = sel_registerName("alloc");
    void *init     = sel_registerName(
        "initWithContentRect:styleMask:backing:defer:");
    void *winAlloc = objc_msgSend(NSWindow, alloc);
    void *window = objc_msgSend_rect(
        winAlloc, init,
        100.0, 100.0, 480.0, 240.0,
        (long long)(NS_TITLED | NS_CLOSABLE | NS_RESIZABLE),
        (long long)NS_BACKING_BUF,
        (long long)0);
    if (!window) {
        fprintf(stderr, "hello-macos: NSWindow alloc / init failed\n");
        return 1;
    }

    /* [window setTitle:@"badc Cocoa hello"] -- @"..." is an
     * NSString literal in ObjC; since we don't have those,
     * synthesise one from a UTF-8 byte string via the
     * NSString class method `stringWithUTF8String:`. */
    void *NSString = objc_getClass("NSString");
    void *swus     = sel_registerName("stringWithUTF8String:");
    void *title    = objc_msgSend_p(NSString, swus, "badc Cocoa hello");
    void *setTitle = sel_registerName("setTitle:");
    objc_msgSend_p(window, setTitle, title);

    /* [window makeKeyAndOrderFront:nil] + [NSApp run]. The
     * activate / run pair gives the window focus and starts
     * the modal AppKit event loop. */
    void *makeKey = sel_registerName("makeKeyAndOrderFront:");
    objc_msgSend_p(window, makeKey, (void *)0);
    void *activate = sel_registerName("activateIgnoringOtherApps:");
    objc_msgSend_b(app, activate, (long long)1);
    void *run = sel_registerName("run");
    objc_msgSend(app, run);
    return 0;
}
