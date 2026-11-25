//! On macOS a fault whose signal the thread blocks or the process ignores
//! is held or dropped and the kernel restarts the instruction, so the thread
//! faults again forever. `sigprocmask` there sets the mask of every thread,
//! and the C library brackets `tmpfile`, `system`, `longjmp` and others with
//! it: programs the JIT runs beside each other can leave every signal
//! blocked. The test binary takes each fault's Mach exception first, makes
//! the fault signals deliverable, and passes the exception on to become its
//! signal, as Linux delivers a fault's signal whatever the mask.

use core::ffi::{c_int, c_void};

type Port = u32;

const MACH_PORT_RIGHT_RECEIVE: u32 = 1;
const MACH_MSG_TYPE_MAKE_SEND: u32 = 20;
const MACH_SEND_MSG: c_int = 1;
const MACH_RCV_MSG: c_int = 2;
const MACH_MSGH_BITS_REMOTE_MASK: u32 = 0x1f;
const EXC_MASK_FAULTS: u32 = (1 << 1) | (1 << 2) | (1 << 3) | (1 << 6);
const EXCEPTION_DEFAULT_CODES: c_int = 1 | 0x8000_0000_u32 as c_int;
const ARM_THREAD_STATE64: c_int = 6;
const MACH_EXCEPTION_RAISE: c_int = 2405;
const KERN_FAILURE: c_int = 5;
const SIG_UNBLOCK: c_int = 2;
const SIG_DFL: usize = 0;
const SIG_IGN: usize = 1;
/// SIGILL, SIGTRAP, SIGFPE, SIGBUS and SIGSEGV.
const FAULT_SIGNALS: [c_int; 5] = [4, 5, 8, 10, 11];

#[repr(C)]
struct Header {
    bits: u32,
    size: u32,
    remote: Port,
    local: Port,
    voucher: Port,
    id: c_int,
}

#[repr(C)]
struct PortDescriptor {
    name: Port,
    pad: [u32; 2],
}

/// `mach_exception_raise`'s request up to its exception type.
#[repr(C)]
struct Request {
    head: Header,
    descriptors: u32,
    thread: PortDescriptor,
    task: PortDescriptor,
    ndr: [u8; 8],
    exception: c_int,
    codes: u32,
}

#[repr(C)]
struct Reply {
    head: Header,
    ndr: [u8; 8],
    ret: c_int,
}

#[repr(C)]
struct SigAction {
    handler: usize,
    mask: u32,
    flags: c_int,
}

unsafe extern "C" {
    static mach_task_self_: Port;
    static NDR_record: [u8; 8];
    fn mach_port_allocate(task: Port, right: u32, name: *mut Port) -> c_int;
    fn mach_port_insert_right(task: Port, name: Port, poly: Port, kind: u32) -> c_int;
    fn mach_port_deallocate(task: Port, name: Port) -> c_int;
    fn task_set_exception_ports(
        task: Port,
        mask: u32,
        port: Port,
        how: c_int,
        flavor: c_int,
    ) -> c_int;
    fn mach_msg(
        m: *mut Header,
        opt: c_int,
        send: u32,
        rcv: u32,
        name: Port,
        t: u32,
        n: Port,
    ) -> c_int;
    fn pid_for_task(task: Port, pid: *mut c_int) -> c_int;
    fn thread_get_state(thread: Port, flavor: c_int, state: *mut u64, count: *mut u32) -> c_int;
    fn getpid() -> c_int;
    fn sigprocmask(how: c_int, set: *const u32, old: *mut u32) -> c_int;
    fn sigaction(sig: c_int, act: *const SigAction, old: *mut SigAction) -> c_int;
    fn write(fd: c_int, buf: *const c_void, len: usize) -> isize;
    fn pthread_create(
        t: *mut usize,
        attr: *const c_void,
        start: unsafe extern "C" fn(*mut c_void) -> *mut c_void,
        arg: *mut c_void,
    ) -> c_int;
}

/// Run before `main`: the exceptions of a fault before the first test reach
/// the port too, and wait there until the thread serving it starts.
#[used]
#[unsafe(link_section = "__DATA,__mod_init_func")]
static INSTALL: extern "C" fn() = install;

extern "C" fn install() {
    let mut port: Port = 0;
    unsafe {
        let task = mach_task_self_;
        if mach_port_allocate(task, MACH_PORT_RIGHT_RECEIVE, &mut port) != 0
            || mach_port_insert_right(task, port, port, MACH_MSG_TYPE_MAKE_SEND) != 0
        {
            return;
        }
        let flavor = ARM_THREAD_STATE64;
        if task_set_exception_ports(task, EXC_MASK_FAULTS, port, EXCEPTION_DEFAULT_CODES, flavor)
            != 0
        {
            return;
        }
        let mut thread = 0;
        pthread_create(
            &mut thread,
            core::ptr::null(),
            serve,
            port as usize as *mut c_void,
        );
    }
}

unsafe extern "C" fn serve(port: *mut c_void) -> *mut c_void {
    let port = port as usize as Port;
    #[repr(C, align(8))]
    struct Buffer([u8; 1024]);
    let mut buf = Buffer([0; 1024]);
    loop {
        let head = buf.0.as_mut_ptr() as *mut Header;
        let size = buf.0.len() as u32;
        if unsafe { mach_msg(head, MACH_RCV_MSG, 0, size, port, 0, 0) } != 0 {
            continue;
        }
        let req = unsafe { &*(head as *const Request) };
        if req.head.id != MACH_EXCEPTION_RAISE {
            continue;
        }
        let mut pid = 0;
        let ours =
            unsafe { pid_for_task(req.task.name, &mut pid) } == 0 && pid == unsafe { getpid() };
        if ours {
            report(req);
            make_deliverable();
        }
        unsafe {
            mach_port_deallocate(mach_task_self_, req.thread.name);
            mach_port_deallocate(mach_task_self_, req.task.name);
        }
        let mut reply = Reply {
            head: Header {
                bits: req.head.bits & MACH_MSGH_BITS_REMOTE_MASK,
                size: size_of::<Reply>() as u32,
                remote: req.head.remote,
                local: 0,
                voucher: 0,
                id: req.head.id + 100,
            },
            ndr: unsafe { NDR_record },
            ret: KERN_FAILURE,
        };
        let size = reply.head.size;
        unsafe { mach_msg(&mut reply.head, MACH_SEND_MSG, size, 0, 0, 0, 0) };
    }
}

/// Unblock the fault signals in every thread and take back an ignored one,
/// the two states in which the kernel restarts the faulting instruction.
fn make_deliverable() {
    let set = FAULT_SIGNALS
        .iter()
        .fold(0u32, |s, &sig| s | 1 << (sig - 1));
    unsafe { sigprocmask(SIG_UNBLOCK, &set, core::ptr::null_mut()) };
    for sig in FAULT_SIGNALS {
        let mut old = SigAction {
            handler: 0,
            mask: 0,
            flags: 0,
        };
        unsafe { sigaction(sig, core::ptr::null(), &mut old) };
        if old.handler == SIG_IGN {
            let dfl = SigAction {
                handler: SIG_DFL,
                mask: 0,
                flags: 0,
            };
            unsafe { sigaction(sig, &dfl, core::ptr::null_mut()) };
        }
    }
}

/// One line on stderr naming the exception, its codes and the thread's pc,
/// formatted without allocating: the faulting thread may hold the
/// allocator's lock.
fn report(req: &Request) {
    let at = core::ptr::addr_of!(req.codes) as *const u8;
    let codes = unsafe { core::ptr::read_unaligned(at.add(4) as *const [u64; 2]) };
    let mut state = [0u64; 34];
    let mut count = (state.len() * 2) as u32;
    let flavor = ARM_THREAD_STATE64;
    let pc = match unsafe {
        thread_get_state(req.thread.name, flavor, state.as_mut_ptr(), &mut count)
    } {
        0 => state[32],
        _ => 0,
    };
    let mut line = Line([0; 128], 0);
    line.put(b"test process: Mach exception ");
    line.hex(req.exception as u64);
    line.put(b" (codes ");
    line.hex(codes[0]);
    line.put(b", ");
    line.hex(codes[1]);
    line.put(b") at pc ");
    line.hex(pc);
    line.put(b"\n");
    unsafe { write(2, line.0.as_ptr().cast(), line.1) };
}

struct Line([u8; 128], usize);

impl Line {
    fn put(&mut self, s: &[u8]) {
        let k = s.len().min(self.0.len() - self.1);
        self.0[self.1..self.1 + k].copy_from_slice(&s[..k]);
        self.1 += k;
    }

    fn hex(&mut self, v: u64) {
        let digits = (64 - (v | 1).leading_zeros()).div_ceil(4);
        self.put(b"0x");
        for d in (0..digits).rev() {
            self.put(&[b"0123456789abcdef"[(v >> (4 * d) & 15) as usize]]);
        }
    }
}
