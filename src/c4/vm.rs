use std::collections::HashMap;
use std::fs::File;
use std::io::Read;

use super::error::C4Error;
use super::op::Op;
use super::program::Program;

const STACK_CAPACITY: usize = 256 * 1024;
const STACK_BASE: usize = 0x1000_0000;

/// Virtual machine that executes a [`Program`].
pub struct Vm {
    pub(crate) text: Vec<i64>,
    pub(crate) data: Vec<u8>,
    entry_pc: usize,
    stack: Vec<i64>,
    fd_table: HashMap<i64, File>,
    next_fd: i64,
    debug: bool,
}

impl Vm {
    pub fn new(program: Program, debug: bool) -> Self {
        Self {
            text: program.text,
            data: program.data,
            entry_pc: program.entry_pc,
            stack: vec![0; STACK_CAPACITY],
            fd_table: HashMap::new(),
            next_fd: 3,
            debug,
        }
    }

    fn get_stack_idx(&self, addr: usize) -> Option<usize> {
        if addr >= STACK_BASE {
            Some((addr - STACK_BASE) / 8)
        } else {
            None
        }
    }

    fn load_i64(&self, addr: usize) -> Result<i64, C4Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                Ok(self.stack[idx])
            } else {
                Err(C4Error::Runtime(format!(
                    "Stack overflow read at addr {:x}",
                    addr
                )))
            }
        } else if addr + 8 <= self.data.len() {
            let mut bytes = [0u8; 8];
            bytes.copy_from_slice(&self.data[addr..addr + 8]);
            Ok(i64::from_le_bytes(bytes))
        } else {
            Ok(0)
        }
    }

    fn store_i64(&mut self, addr: usize, val: i64) -> Result<(), C4Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                self.stack[idx] = val;
                Ok(())
            } else {
                Err(C4Error::Runtime(format!(
                    "Stack overflow write at addr {:x}",
                    addr
                )))
            }
        } else {
            if addr + 8 > self.data.len() {
                self.data.resize(addr + 8, 0);
            }
            let bytes = val.to_le_bytes();
            self.data[addr..addr + 8].copy_from_slice(&bytes);
            Ok(())
        }
    }

    fn load_u8(&self, addr: usize) -> Result<u8, C4Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                let word = self.stack[idx];
                let byte_offset = (addr - STACK_BASE) % 8;
                let shift = byte_offset * 8;
                Ok(((word >> shift) & 0xFF) as u8)
            } else {
                Ok(0)
            }
        } else if addr < self.data.len() {
            Ok(self.data[addr])
        } else {
            Ok(0)
        }
    }

    fn store_u8(&mut self, addr: usize, val: u8) -> Result<(), C4Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                let word = self.stack[idx];
                let byte_offset = (addr - STACK_BASE) % 8;
                let shift = byte_offset * 8;
                let mask = !(0xFFu64 << shift) as i64;
                let new_val = (word & mask) | ((val as i64 & 0xFF) << shift);
                self.stack[idx] = new_val;
            }
        } else {
            if addr >= self.data.len() {
                self.data.resize(addr + 1, 0);
            }
            self.data[addr] = val;
        }
        Ok(())
    }

    fn read_cstring(&self, addr: usize) -> Result<String, C4Error> {
        let mut s = String::new();
        let mut p = addr;
        while s.len() < 5000 {
            let c = self.load_u8(p)? as char;
            if c == '\0' {
                break;
            }
            s.push(c);
            p += 1;
        }
        Ok(s)
    }

    pub fn run(&mut self) -> Result<i64, C4Error> {
        if self.text.is_empty() {
            return Err(C4Error::Runtime("empty program".to_string()));
        }

        let mut sp = STACK_BASE + STACK_CAPACITY * 8;
        let mut bp = sp;

        // Append a Psh+Exit bootstrap so main's `Lev` returns into it
        // and terminates with the value left in the accumulator.
        let bootstrap_addr = self.text.len() as i64;
        self.text.push(Op::Psh as i64);
        self.text.push(Op::Exit as i64);

        sp -= 8;
        self.store_i64(sp, 0)?;
        sp -= 8;
        self.store_i64(sp, 0)?;
        sp -= 8;
        self.store_i64(sp, bootstrap_addr)?;

        let mut pc = self.entry_pc;
        let mut _cycle = 0;
        let mut a: i64 = 0;

        loop {
            _cycle += 1;
            if pc >= self.text.len() {
                return Err(C4Error::Runtime("PC out of bounds".to_string()));
            }

            let raw_op = self.text[pc];
            let op = Op::from_i64(raw_op).ok_or_else(|| {
                C4Error::Runtime(format!("Invalid instruction {} at PC {}", raw_op, pc))
            })?;
            pc += 1;

            if self.debug {
                println!("{} op: {:?}", _cycle, op);
            }

            match op {
                Op::Lea => {
                    let offset = self.text[pc] * 8;
                    a = (bp as i64) + offset;
                    pc += 1;
                }
                Op::Imm => {
                    a = self.text[pc];
                    pc += 1;
                }
                Op::Jmp => {
                    pc = self.text[pc] as usize;
                }
                Op::Jsr => {
                    sp -= 8;
                    self.store_i64(sp, (pc + 1) as i64)?;
                    pc = self.text[pc] as usize;
                }
                Op::Jsri => {
                    sp -= 8;
                    self.store_i64(sp, pc as i64)?;
                    pc = a as usize;
                }
                Op::Bz => {
                    pc = if a == 0 {
                        self.text[pc] as usize
                    } else {
                        pc + 1
                    };
                }
                Op::Bnz => {
                    pc = if a != 0 {
                        self.text[pc] as usize
                    } else {
                        pc + 1
                    };
                }
                Op::Ent => {
                    sp -= 8;
                    self.store_i64(sp, bp as i64)?;
                    bp = sp;
                    sp -= (self.text[pc] as usize) * 8;
                    pc += 1;
                }
                Op::Adj => {
                    sp += (self.text[pc] as usize) * 8;
                    pc += 1;
                }
                Op::Lev => {
                    sp = bp;
                    bp = self.load_i64(sp)? as usize;
                    sp += 8;
                    pc = self.load_i64(sp)? as usize;
                    sp += 8;
                }
                Op::Li => {
                    a = self.load_i64(a as usize)?;
                }
                Op::Lc => {
                    a = self.load_u8(a as usize)? as i64;
                }
                Op::Si => {
                    let addr = self.load_i64(sp)? as usize;
                    sp += 8;
                    self.store_i64(addr, a)?;
                }
                Op::Sc => {
                    let addr = self.load_i64(sp)? as usize;
                    sp += 8;
                    self.store_u8(addr, a as u8)?;
                }
                Op::Psh => {
                    sp -= 8;
                    self.store_i64(sp, a)?;
                }
                Op::Or => {
                    a |= self.load_i64(sp)?;
                    sp += 8;
                }
                Op::Xor => {
                    a ^= self.load_i64(sp)?;
                    sp += 8;
                }
                Op::And => {
                    a &= self.load_i64(sp)?;
                    sp += 8;
                }
                Op::Eq => {
                    a = if self.load_i64(sp)? == a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Ne => {
                    a = if self.load_i64(sp)? != a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Lt => {
                    a = if self.load_i64(sp)? < a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Gt => {
                    a = if self.load_i64(sp)? > a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Le => {
                    a = if self.load_i64(sp)? <= a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Ge => {
                    a = if self.load_i64(sp)? >= a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Shl => {
                    a = self.load_i64(sp)? << a;
                    sp += 8;
                }
                Op::Shr => {
                    a = self.load_i64(sp)? >> a;
                    sp += 8;
                }
                Op::Add => {
                    a += self.load_i64(sp)?;
                    sp += 8;
                }
                Op::Sub => {
                    a = self.load_i64(sp)? - a;
                    sp += 8;
                }
                Op::Mul => {
                    a *= self.load_i64(sp)?;
                    sp += 8;
                }
                Op::Div => {
                    a = self.load_i64(sp)? / a;
                    sp += 8;
                }
                Op::Mod => {
                    a = self.load_i64(sp)? % a;
                    sp += 8;
                }
                Op::Open => {
                    let name_addr = self.load_i64(sp + 8)? as usize;
                    let _flags = self.load_i64(sp)?;
                    let name = self.read_cstring(name_addr)?;
                    if let Ok(file) = File::open(&name) {
                        let fd = self.next_fd;
                        self.next_fd += 1;
                        self.fd_table.insert(fd, file);
                        a = fd;
                    } else {
                        a = -1;
                    }
                }
                Op::Read => {
                    let fd = self.load_i64(sp + 16)?;
                    let buf_addr = self.load_i64(sp + 8)? as usize;
                    let size = self.load_i64(sp)? as usize;

                    if let Some(file) = self.fd_table.get_mut(&fd) {
                        let mut buf = vec![0u8; size];
                        if let Ok(bytes_read) = file.read(&mut buf) {
                            for (i, &byte) in buf.iter().enumerate().take(bytes_read) {
                                self.store_u8(buf_addr + i, byte)?;
                            }
                            a = bytes_read as i64;
                        } else {
                            a = -1;
                        }
                    } else {
                        a = -1;
                    }
                }
                Op::Clos => {
                    let fd = self.load_i64(sp)?;
                    if self.fd_table.remove(&fd).is_some() {
                        a = 0;
                    } else {
                        a = -1;
                    }
                }
                Op::Malc => {
                    let size = self.load_i64(sp)? as usize;
                    let aligned_size = (size + 7) & !7;
                    if self.data.is_empty() {
                        // Reserve address 0 so allocations never alias NULL.
                        self.data.resize(8, 0);
                    }
                    a = self.data.len() as i64;
                    self.data.resize(self.data.len() + aligned_size, 0);
                }
                Op::Free => {
                    a = 0;
                }
                Op::Mset => {
                    let dst_addr = self.load_i64(sp + 16)? as usize;
                    let val = self.load_i64(sp + 8)? as u8;
                    let size = self.load_i64(sp)? as usize;
                    for i in 0..size {
                        self.store_u8(dst_addr + i, val)?;
                    }
                    a = dst_addr as i64;
                }
                Op::Mcmp => {
                    let s1_addr = self.load_i64(sp + 16)? as usize;
                    let s2_addr = self.load_i64(sp + 8)? as usize;
                    let size = self.load_i64(sp)? as usize;
                    a = 0;
                    for i in 0..size {
                        let c1 = self.load_u8(s1_addr + i)?;
                        let c2 = self.load_u8(s2_addr + i)?;
                        if c1 != c2 {
                            a = (c1 as i64) - (c2 as i64);
                            break;
                        }
                    }
                }
                Op::Prtf => {
                    if pc < self.text.len() && self.text[pc] == Op::Adj as i64 {
                        let nargs = self.text[pc + 1] as usize;
                        let fmt_addr = self.load_i64(sp + (nargs - 1) * 8)? as usize;
                        let s = self.read_cstring(fmt_addr)?;

                        let mut arg_idx = 1;
                        let mut output = String::new();
                        let mut chars = s.chars();
                        while let Some(c) = chars.next() {
                            if c == '%' {
                                let Some(nc) = chars.next() else {
                                    continue;
                                };
                                if arg_idx < nargs {
                                    let offset = (nargs - 1 - arg_idx) * 8;
                                    let val = self.load_i64(sp + offset)?;
                                    arg_idx += 1;

                                    match nc {
                                        'd' => output.push_str(&val.to_string()),
                                        'c' => output.push(val as u8 as char),
                                        's' => {
                                            let addr = val as usize;
                                            output.push_str(&self.read_cstring(addr)?);
                                        }
                                        _ => output.push(nc),
                                    }
                                }
                            } else if c == '\\' {
                                if let Some(nc) = chars.next() {
                                    if nc == 'n' {
                                        output.push('\n');
                                    } else {
                                        output.push(nc);
                                    }
                                }
                            } else {
                                output.push(c);
                            }
                        }
                        print!("{}", output);
                    }
                    a = 0;
                }
                Op::Exit => {
                    return self.load_i64(sp);
                }
            }
        }
    }
}
