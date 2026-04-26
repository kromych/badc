pub mod c4 {
    use std::collections::HashMap;
    use std::fmt;
    use std::fs::File;
    use std::io::Read;

    #[derive(Debug, Clone)]
    pub enum C4Error {
        Compile(String),
        Runtime(String),
    }

    impl fmt::Display for C4Error {
        fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
            match self {
                C4Error::Compile(msg) => write!(f, "Compile Error: {}", msg),
                C4Error::Runtime(msg) => write!(f, "Runtime Error: {}", msg),
            }
        }
    }

    impl std::error::Error for C4Error {}

    /// Virtual Machine Operations (Opcodes)
    /// These represent the low-level instructions executed by the VM.
    #[repr(i64)]
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub enum Op {
        /// Load Effective Address: Calculates address of a local variable.
        Lea = 0,
        /// Load Immediate: Loads a constant value into the accumulator.
        Imm,
        /// Jump: Unconditional jump to a specific text address.
        Jmp,
        /// Jump to Subroutine: Pushes return address and jumps.
        Jsr,
        /// Jump to Subroutine indirect.
        Jsri,
        /// Branch if Zero: Jumps if the accumulator is 0.
        Bz,
        /// Branch if Not Zero: Jumps if the accumulator is not 0.
        Bnz,
        /// Enter Subroutine: Sets up the stack frame for a new function.
        Ent,
        /// Adjust Stack: Cleans up arguments from the stack after a call.
        Adj,
        /// Leave Subroutine: Restores previous stack frame and returns.
        Lev,
        /// Load Integer: Loads an i64 from the address in the accumulator.
        Li,
        /// Load Character: Loads a u8 from the address in the accumulator.
        Lc,
        /// Store Integer: Stores the accumulator into the address on top of stack.
        Si,
        /// Store Character: Stores the lower byte of accumulator into address on stack.
        Sc,
        /// Push: Pushes the accumulator onto the stack.
        Psh,
        /// Bitwise OR
        Or,
        /// Bitwise XOR
        Xor,
        /// Bitwise AND
        And,
        /// Equality `==`
        Eq,
        /// Inequality `!=`
        Ne,
        /// Less Than `<`
        Lt,
        /// Greater Than `>`
        Gt,
        /// Less Than or Equal `<=`
        Le,
        /// Greater Than or Equal `>=`
        Ge,
        /// Shift Left `<<`
        Shl,
        /// Shift Right `>>`
        Shr,
        /// Addition `+`
        Add,
        /// Subtraction `-`
        Sub,
        /// Multiplication `*`
        Mul,
        /// Division `/`
        Div,
        /// Modulo `%`
        Mod,
        /// Syscall: Open a file
        Open,
        /// Syscall: Read from a file descriptor
        Read,
        /// Syscall: Close a file descriptor
        Clos,
        /// Syscall: Formatted print to stdout
        Prtf,
        /// Syscall: Dynamic memory allocation
        Malc,
        /// Syscall: Deallocate memory
        Free,
        /// Syscall: Set memory block to value
        Mset,
        /// Syscall: Compare memory blocks
        Mcmp,
        /// Syscall: Terminate program with exit code
        Exit,
    }

    const OPS: [Op; 40] = [
        Op::Lea,
        Op::Imm,
        Op::Jmp,
        Op::Jsr,
        Op::Jsri,
        Op::Bz,
        Op::Bnz,
        Op::Ent,
        Op::Adj,
        Op::Lev,
        Op::Li,
        Op::Lc,
        Op::Si,
        Op::Sc,
        Op::Psh,
        Op::Or,
        Op::Xor,
        Op::And,
        Op::Eq,
        Op::Ne,
        Op::Lt,
        Op::Gt,
        Op::Le,
        Op::Ge,
        Op::Shl,
        Op::Shr,
        Op::Add,
        Op::Sub,
        Op::Mul,
        Op::Div,
        Op::Mod,
        Op::Open,
        Op::Read,
        Op::Clos,
        Op::Prtf,
        Op::Malc,
        Op::Free,
        Op::Mset,
        Op::Mcmp,
        Op::Exit,
    ];

    impl Op {
        pub fn from_i64(val: i64) -> Option<Self> {
            if val >= 0 && val < OPS.len() as i64 {
                Some(OPS[val as usize])
            } else {
                None
            }
        }
    }

    /// Lexical Tokens
    #[repr(i64)]
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub enum Token {
        /// Numeric literal
        Num = 128,
        /// Function definition/declaration
        Fun,
        /// System call / Library function
        Sys,
        /// Global variable
        Glo,
        /// Local variable
        Loc,
        /// Identifier (variable or function name)
        Id,
        /// 'char' keyword
        Char,
        /// 'else' keyword
        Else,
        /// 'enum' keyword
        Enum,
        /// 'for' keyword
        For,
        /// 'if' keyword
        If,
        /// 'int' keyword
        Int,
        /// 'return' keyword
        Return,
        /// 'sizeof' keyword
        Sizeof,
        /// 'while' keyword
        While,
        /// Assignment '='
        Assign,
        /// Ternary conditional '?'
        Cond,
        /// Logical OR '||'
        Lor,
        /// Logical AND '&&'
        Lan,
        /// Bitwise OR '|'
        OrOp,
        /// Bitwise XOR '^'
        XorOp,
        /// Bitwise AND '&'
        AndOp,
        /// Equality '=='
        EqOp,
        /// Inequality '!='
        NeOp,
        /// Less than '<'
        LtOp,
        /// Greater than '>'
        GtOp,
        LeOp,
        /// Greater than or equal '>='
        GeOp,
        /// Shift left '<<'
        ShlOp,
        /// Shift right '>>'
        ShrOp,
        /// Addition '+'
        AddOp,
        /// Subtraction '-'
        SubOp,
        /// Multiplication '*'
        MulOp,
        /// Division '/'
        DivOp,
        /// Modulo '%'
        ModOp,
        /// Increment '++'
        Inc,
        /// Decrement '--'
        Dec,
        /// Array bracket '['
        Brak,
        Do,
        Break,
        Continue,
        Goto,
        Switch,
        Case,
        Default,
    }

    /// Primitive Types
    #[repr(i64)]
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub enum Ty {
        /// 8-bit character
        Char = 0,
        /// 64-bit signed integer
        Int = 1,
        /// Pointer type (values > 1 represent pointer depth)
        Ptr = 2,
    }

    const STACK_CAPACITY: usize = 256 * 1024;
    const STACK_BASE: usize = 0x1000_0000;

    #[derive(Clone, Debug, Default)]
    pub struct Symbol {
        pub name: String,
        pub hash: i64,
        pub token: i64,
        pub class: i64,
        pub type_: i64,
        pub val: i64,
        pub h_class: i64,
        pub h_type: i64,
        pub h_val: i64,
    }

    pub struct C4 {
        src: Vec<u8>,
        src_pos: usize,
        debug: bool,
        pub text: Vec<i64>,
        pub data: Vec<u8>,
        stack: Vec<i64>,
        pub symbols: Vec<Symbol>,
        fd_table: HashMap<i64, File>,
        next_fd: i64,
        curr_id_idx: usize,
        tk: i64,
        ival: i64,
        ty: i64,
        line: usize,
        loc_offs: i64,
        loop_breaks: Vec<Vec<usize>>,
        loop_continues: Vec<Vec<usize>>,
        labels: HashMap<String, usize>,
        unresolved_gotos: Vec<(String, usize)>,
        switch_cases: Vec<Vec<(i64, usize)>>,
        switch_defaults: Vec<Option<usize>>,
    }

    impl C4 {
        pub fn new(source: String, debug: bool) -> Self {
            let mut vm = C4 {
                src: source.into_bytes(),
                src_pos: 0,
                debug,
                text: Vec::new(),
                data: Vec::new(),
                stack: vec![0; STACK_CAPACITY],
                symbols: Vec::new(),
                fd_table: HashMap::new(),
                next_fd: 3,
                curr_id_idx: 0,
                tk: 0,
                ival: 0,
                ty: 0,
                line: 1,
                loc_offs: 0,
                loop_breaks: Vec::new(),
                loop_continues: Vec::new(),
                labels: HashMap::new(),
                unresolved_gotos: Vec::new(),
                switch_cases: Vec::new(),
                switch_defaults: Vec::new(),
            };
            vm.init_symbols();
            vm
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

        fn init_symbols(&mut self) {
            let keywords = [
                ("char", Token::Char),
                ("else", Token::Else),
                ("enum", Token::Enum),
                ("for", Token::For),
                ("if", Token::If),
                ("int", Token::Int),
                ("return", Token::Return),
                ("sizeof", Token::Sizeof),
                ("while", Token::While),
                ("do", Token::Do),
                ("break", Token::Break),
                ("continue", Token::Continue),
                ("goto", Token::Goto),
                ("switch", Token::Switch),
                ("case", Token::Case),
                ("default", Token::Default),
                ("open", Token::Id),
                ("read", Token::Id),
                ("close", Token::Id),
                ("printf", Token::Id),
                ("malloc", Token::Id),
                ("free", Token::Id),
                ("memset", Token::Id),
                ("memcmp", Token::Id),
                ("exit", Token::Id),
                ("void", Token::Char),
                ("main", Token::Id),
            ];

            let lib_ops = [
                ("open", Op::Open),
                ("read", Op::Read),
                ("close", Op::Clos),
                ("printf", Op::Prtf),
                ("malloc", Op::Malc),
                ("free", Op::Free),
                ("memset", Op::Mset),
                ("memcmp", Op::Mcmp),
                ("exit", Op::Exit),
            ];

            for (name, tok) in keywords.iter() {
                self.add_keyword(name, *tok as i64);
            }

            for (name, op) in lib_ops.iter() {
                let idx = self.find_symbol(name).unwrap();
                self.symbols[idx].class = Token::Sys as i64;
                self.symbols[idx].type_ = Ty::Int as i64;
                self.symbols[idx].val = *op as i64;
            }

            let _ = self.find_symbol("main").unwrap();
        }

        fn add_keyword(&mut self, name: &str, token: i64) {
            let hash = self.hash_name(name.as_bytes());
            self.symbols.push(Symbol {
                name: name.to_string(),
                hash,
                token,
                ..Default::default()
            });
        }

        pub fn hash_name(&self, name: &[u8]) -> i64 {
            let mut h: i64 = 0;
            for &b in name {
                h = h.wrapping_mul(147).wrapping_add(b as i64);
            }
            h
        }

        pub fn find_symbol(&self, name: &str) -> Option<usize> {
            self.symbols.iter().position(|s| s.name == name)
        }

        pub fn resolve_symbol(&mut self, name: &[u8], hash: i64) -> usize {
            for (i, s) in self.symbols.iter().enumerate().rev() {
                if s.hash == hash && s.token != 0 && s.name.as_bytes() == name {
                    return i;
                }
            }

            let sym = Symbol {
                name: String::from_utf8_lossy(name).to_string(),
                hash,
                token: Token::Id as i64,
                ..Default::default()
            };
            self.symbols.push(sym);
            self.symbols.len() - 1
        }

        fn next(&mut self) -> Result<(), C4Error> {
            loop {
                if self.src_pos >= self.src.len() {
                    self.tk = 0;
                    return Ok(());
                }

                let c = self.src[self.src_pos] as char;
                self.src_pos += 1;

                if c == '\n' {
                    self.line += 1;
                } else if c == '#' {
                    while self.src_pos < self.src.len() && self.src[self.src_pos] as char != '\n' {
                        self.src_pos += 1;
                    }
                } else if c.is_ascii_alphabetic() || c == '_' {
                    let start = self.src_pos - 1;
                    let mut hash: i64 = c as i64;
                    while self.src_pos < self.src.len() {
                        let nc = self.src[self.src_pos] as char;
                        if !nc.is_ascii_alphanumeric() && nc != '_' {
                            break;
                        }
                        hash = hash.wrapping_mul(147).wrapping_add(nc as i64);
                        self.src_pos += 1;
                    }
                    let name_vec = self.src[start..self.src_pos].to_vec();
                    self.curr_id_idx = self.resolve_symbol(&name_vec, hash);
                    self.tk = self.symbols[self.curr_id_idx].token;
                    return Ok(());
                } else if c.is_ascii_digit() {
                    let mut val = (c as u8 - b'0') as i64;
                    if val == 0
                        && self.src_pos < self.src.len()
                        && (self.src[self.src_pos] as char == 'x'
                            || self.src[self.src_pos] as char == 'X')
                    {
                        self.src_pos += 1;
                        while self.src_pos < self.src.len() {
                            let nc = self.src[self.src_pos] as char;
                            if nc.is_ascii_digit() {
                                val = val * 16 + (nc as u8 - b'0') as i64;
                            } else if ('a'..='f').contains(&nc) {
                                val = val * 16 + (nc as u8 - b'a' + 10) as i64;
                            } else if ('A'..='F').contains(&nc) {
                                val = val * 16 + (nc as u8 - b'A' + 10) as i64;
                            } else {
                                break;
                            }
                            self.src_pos += 1;
                        }
                    } else {
                        while self.src_pos < self.src.len() {
                            let nc = self.src[self.src_pos] as char;
                            if !nc.is_ascii_digit() {
                                break;
                            }
                            val = val * 10 + (nc as u8 - b'0') as i64;
                            self.src_pos += 1;
                        }
                    }
                    self.ival = val;
                    self.tk = Token::Num as i64;
                    return Ok(());
                } else if c == '/' {
                    if self.src_pos < self.src.len() && self.src[self.src_pos] as char == '/' {
                        self.src_pos += 1;
                        while self.src_pos < self.src.len()
                            && self.src[self.src_pos] as char != '\n'
                        {
                            self.src_pos += 1;
                        }
                    } else {
                        self.tk = Token::DivOp as i64;
                        return Ok(());
                    }
                } else if c == '\'' || c == '"' {
                    let start_data = self.data.len() as i64;
                    while self.src_pos < self.src.len() && self.src[self.src_pos] as char != c {
                        let mut val = self.src[self.src_pos] as i64;
                        self.src_pos += 1;
                        if val == '\\' as i64 {
                            val = self.src[self.src_pos] as i64;
                            self.src_pos += 1;
                            if val == 'n' as i64 {
                                val = '\n' as i64;
                            }
                        }
                        if c == '"' {
                            self.data.push(val as u8);
                        } else {
                            self.ival = val;
                        }
                    }
                    self.src_pos += 1;
                    if c == '"' {
                        self.data.push(0);
                        self.ival = start_data;
                        self.tk = '"' as i64;
                    } else {
                        self.tk = Token::Num as i64;
                    }
                    return Ok(());
                } else {
                    let next_char = if self.src_pos < self.src.len() {
                        self.src[self.src_pos] as char
                    } else {
                        '\0'
                    };
                    match c {
                        '=' => {
                            if next_char == '=' {
                                self.src_pos += 1;
                                self.tk = Token::EqOp as i64;
                            } else {
                                self.tk = Token::Assign as i64;
                            }
                        }
                        '+' => {
                            if next_char == '+' {
                                self.src_pos += 1;
                                self.tk = Token::Inc as i64;
                            } else {
                                self.tk = Token::AddOp as i64;
                            }
                        }
                        '-' => {
                            if next_char == '-' {
                                self.src_pos += 1;
                                self.tk = Token::Dec as i64;
                            } else {
                                self.tk = Token::SubOp as i64;
                            }
                        }
                        '!' => {
                            if next_char == '=' {
                                self.src_pos += 1;
                                self.tk = Token::NeOp as i64;
                            } else {
                                self.tk = 0;
                            }
                        }
                        '<' => {
                            if next_char == '=' {
                                self.src_pos += 1;
                                self.tk = Token::LeOp as i64;
                            } else if next_char == '<' {
                                self.src_pos += 1;
                                self.tk = Token::ShlOp as i64;
                            } else {
                                self.tk = Token::LtOp as i64;
                            }
                        }
                        '>' => {
                            if next_char == '=' {
                                self.src_pos += 1;
                                self.tk = Token::GeOp as i64;
                            } else if next_char == '>' {
                                self.src_pos += 1;
                                self.tk = Token::ShrOp as i64;
                            } else {
                                self.tk = Token::GtOp as i64;
                            }
                        }
                        '|' => {
                            if next_char == '|' {
                                self.src_pos += 1;
                                self.tk = Token::Lor as i64;
                            } else {
                                self.tk = Token::OrOp as i64;
                            }
                        }
                        '&' => {
                            if next_char == '&' {
                                self.src_pos += 1;
                                self.tk = Token::Lan as i64;
                            } else {
                                self.tk = Token::AndOp as i64;
                            }
                        }
                        '^' => self.tk = Token::XorOp as i64,
                        '%' => self.tk = Token::ModOp as i64,
                        '*' => self.tk = Token::MulOp as i64,
                        '[' => self.tk = Token::Brak as i64,
                        '?' => self.tk = Token::Cond as i64,
                        _ => {
                            if "!~;{}()],:".contains(c) {
                                self.tk = c as i64;
                            } else {
                                continue;
                            }
                        }
                    }
                    return Ok(());
                }
            }
        }

        fn emit_op(&mut self, op: Op) {
            self.text.push(op as i64);
        }

        fn emit_val(&mut self, val: i64) {
            self.text.push(val);
        }

        fn expr(&mut self, lev: i64) -> Result<(), C4Error> {
            let mut t: i64;

            if self.tk == 0 {
                return Err(C4Error::Compile(format!(
                    "{}: unexpected eof in expression",
                    self.line
                )));
            } else if self.tk == Token::Num as i64 {
                self.emit_op(Op::Imm);
                self.emit_val(self.ival);
                self.next()?;
                self.ty = Ty::Int as i64;
            } else if self.tk == '"' as i64 {
                self.emit_op(Op::Imm);
                self.emit_val(self.ival);
                self.next()?;
                while self.tk == '"' as i64 {
                    self.next()?;
                }
                self.ty = Ty::Ptr as i64;
            } else if self.tk == Token::Sizeof as i64 {
                self.next()?;
                if self.tk == '(' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: open paren expected in sizeof",
                        self.line
                    )));
                }
                self.ty = Ty::Int as i64;
                if self.tk == Token::Int as i64 {
                    self.next()?;
                } else if self.tk == Token::Char as i64 {
                    self.next()?;
                    self.ty = Ty::Char as i64;
                }
                while self.tk == Token::MulOp as i64 {
                    self.next()?;
                    self.ty += Ty::Ptr as i64;
                }
                if self.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close paren expected in sizeof",
                        self.line
                    )));
                }
                self.emit_op(Op::Imm);
                self.emit_val(if self.ty == Ty::Char as i64 { 1 } else { 8 });
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::Id as i64 {
                let id_idx = self.curr_id_idx;
                self.next()?;
                if self.tk == '(' as i64 {
                    self.next()?;
                    let mut nargs = 0;
                    while self.tk != ')' as i64 {
                        self.expr(Token::Assign as i64)?;
                        self.emit_op(Op::Psh);
                        nargs += 1;
                        if self.tk == ',' as i64 {
                            self.next()?;
                        }
                    }
                    self.next()?;
                    if self.symbols[id_idx].class == Token::Sys as i64 {
                        self.emit_op(Op::from_i64(self.symbols[id_idx].val).unwrap());
                    } else if self.symbols[id_idx].class == Token::Fun as i64 {
                        self.emit_op(Op::Jsr);
                        self.emit_val(self.symbols[id_idx].val);
                    } else if self.symbols[id_idx].class == Token::Loc as i64
                        || self.symbols[id_idx].class == Token::Glo as i64
                    {
                        if self.symbols[id_idx].class == Token::Loc as i64 {
                            self.emit_op(Op::Lea);
                            self.emit_val(self.symbols[id_idx].val);
                        } else {
                            self.emit_op(Op::Imm);
                            self.emit_val(self.symbols[id_idx].val);
                        }
                        self.emit_op(Op::Li);
                        self.emit_op(Op::Jsri);
                    } else {
                        return Err(C4Error::Compile(format!(
                            "{}: bad function call",
                            self.line
                        )));
                    }
                    if nargs > 0 {
                        self.emit_op(Op::Adj);
                        self.emit_val(nargs);
                    }
                    self.ty = self.symbols[id_idx].type_;
                } else if self.symbols[id_idx].class == Token::Num as i64 {
                    self.emit_op(Op::Imm);
                    self.emit_val(self.symbols[id_idx].val);
                    self.ty = Ty::Int as i64;
                } else if self.symbols[id_idx].class == Token::Fun as i64 {
                    self.emit_op(Op::Imm);
                    self.emit_val(self.symbols[id_idx].val);
                    self.ty = Ty::Ptr as i64;
                } else {
                    if self.symbols[id_idx].class == Token::Loc as i64 {
                        self.emit_op(Op::Lea);
                        self.emit_val(self.symbols[id_idx].val);
                    } else if self.symbols[id_idx].class == Token::Glo as i64 {
                        self.emit_op(Op::Imm);
                        self.emit_val(self.symbols[id_idx].val);
                    } else {
                        return Err(C4Error::Compile(format!(
                            "{}: undefined variable {}",
                            self.line, self.symbols[id_idx].name
                        )));
                    }
                    self.ty = self.symbols[id_idx].type_;
                    self.emit_op(if self.ty == Ty::Char as i64 {
                        Op::Lc
                    } else {
                        Op::Li
                    });
                }
            } else if self.tk == '(' as i64 {
                self.next()?;
                if self.tk == Token::Int as i64 || self.tk == Token::Char as i64 {
                    t = if self.tk == Token::Int as i64 {
                        Ty::Int as i64
                    } else {
                        Ty::Char as i64
                    };
                    self.next()?;
                    while self.tk == Token::MulOp as i64 {
                        self.next()?;
                        t += Ty::Ptr as i64;
                    }
                    if self.tk == ')' as i64 {
                        self.next()?;
                    } else {
                        return Err(C4Error::Compile(format!("{}: bad cast", self.line)));
                    }
                    self.expr(Token::Inc as i64)?;
                    self.ty = t;
                } else {
                    self.expr(Token::Assign as i64)?;
                    if self.tk == ')' as i64 {
                        self.next()?;
                    } else {
                        return Err(C4Error::Compile(format!(
                            "{}: close paren expected",
                            self.line
                        )));
                    }
                }
            } else if self.tk == Token::MulOp as i64 {
                self.next()?;
                self.expr(Token::Inc as i64)?;
                if self.ty > Ty::Int as i64 {
                    self.ty -= Ty::Ptr as i64;
                } else {
                    return Err(C4Error::Compile(format!("{}: bad dereference", self.line)));
                }
                self.emit_op(if self.ty == Ty::Char as i64 {
                    Op::Lc
                } else {
                    Op::Li
                });
            } else if self.tk == Token::AndOp as i64 {
                self.next()?;
                self.expr(Token::Inc as i64)?;
                let last = self.text.pop().unwrap();
                if last != Op::Lc as i64 && last != Op::Li as i64 {
                    return Err(C4Error::Compile(format!("{}: bad address-of", self.line)));
                }
                self.ty += Ty::Ptr as i64;
            } else if self.tk == '!' as i64 {
                self.next()?;
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(0);
                self.emit_op(Op::Eq);
                self.ty = Ty::Int as i64;
            } else if self.tk == '~' as i64 {
                self.next()?;
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(-1);
                self.emit_op(Op::Xor);
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::AddOp as i64 {
                self.next()?;
                self.expr(Token::Inc as i64)?;
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::SubOp as i64 {
                self.next()?;
                self.emit_op(Op::Imm);
                if self.tk == Token::Num as i64 {
                    self.emit_val(-self.ival);
                    self.next()?;
                } else {
                    self.emit_val(-1);
                    self.emit_op(Op::Psh);
                    self.expr(Token::Inc as i64)?;
                    self.emit_op(Op::Mul);
                }
                self.ty = Ty::Int as i64;
            } else if self.tk == Token::Inc as i64 || self.tk == Token::Dec as i64 {
                t = self.tk;
                self.next()?;
                self.expr(Token::Inc as i64)?;
                let last = *self.text.last().unwrap();
                if last == Op::Lc as i64 {
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                    self.emit_op(Op::Lc);
                } else if last == Op::Li as i64 {
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                    self.emit_op(Op::Li);
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: bad lvalue in pre-increment",
                        self.line
                    )));
                }
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
                self.emit_op(if t == Token::Inc as i64 {
                    Op::Add
                } else {
                    Op::Sub
                });
                self.emit_op(if self.ty == Ty::Char as i64 {
                    Op::Sc
                } else {
                    Op::Si
                });
            } else {
                return Err(C4Error::Compile(format!(
                    "{}: bad expression tk={}",
                    self.line, self.tk
                )));
            }

            while self.tk >= lev {
                t = self.ty;
                if self.tk == Token::Assign as i64 {
                    self.next()?;
                    let last = *self.text.last().unwrap();
                    if last == Op::Lc as i64 || last == Op::Li as i64 {
                        *self.text.last_mut().unwrap() = Op::Psh as i64;
                    } else {
                        return Err(C4Error::Compile(format!(
                            "{}: bad lvalue in assignment",
                            self.line
                        )));
                    }
                    self.expr(Token::Assign as i64)?;
                    self.ty = t;
                    self.emit_op(if self.ty == Ty::Char as i64 {
                        Op::Sc
                    } else {
                        Op::Si
                    });
                } else if self.tk == Token::Cond as i64 {
                    self.next()?;
                    self.emit_op(Op::Bz);
                    let b_else = self.text.len();
                    self.emit_val(0);
                    self.expr(Token::Assign as i64)?;
                    if self.tk == ':' as i64 {
                        self.next()?;
                    } else {
                        return Err(C4Error::Compile(format!(
                            "{}: conditional missing colon",
                            self.line
                        )));
                    }
                    let b_end_val = (self.text.len() + 2) as i64;
                    self.text[b_else] = b_end_val;
                    self.emit_op(Op::Jmp);
                    let b_end = self.text.len();
                    self.emit_val(0);
                    self.expr(Token::Cond as i64)?;
                    self.text[b_end] = self.text.len() as i64;
                } else if self.tk == Token::Lor as i64 {
                    self.next()?;
                    self.emit_op(Op::Bnz);
                    let b = self.text.len();
                    self.emit_val(0);
                    self.expr(Token::Lan as i64)?;
                    self.text[b] = self.text.len() as i64;
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::Lan as i64 {
                    self.next()?;
                    self.emit_op(Op::Bz);
                    let b = self.text.len();
                    self.emit_val(0);
                    self.expr(Token::OrOp as i64)?;
                    self.text[b] = self.text.len() as i64;
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::OrOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::XorOp as i64)?;
                    self.emit_op(Op::Or);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::XorOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::AndOp as i64)?;
                    self.emit_op(Op::Xor);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::AndOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::EqOp as i64)?;
                    self.emit_op(Op::And);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::EqOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::LtOp as i64)?;
                    self.emit_op(Op::Eq);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::NeOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::LtOp as i64)?;
                    self.emit_op(Op::Ne);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::LtOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::ShlOp as i64)?;
                    self.emit_op(Op::Lt);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::GtOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::ShlOp as i64)?;
                    self.emit_op(Op::Gt);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::LeOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::ShlOp as i64)?;
                    self.emit_op(Op::Le);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::GeOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::ShlOp as i64)?;
                    self.emit_op(Op::Ge);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::ShlOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::AddOp as i64)?;
                    self.emit_op(Op::Shl);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::ShrOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::AddOp as i64)?;
                    self.emit_op(Op::Shr);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::AddOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::MulOp as i64)?;
                    if t > Ty::Ptr as i64 {
                        self.emit_op(Op::Psh);
                        self.emit_op(Op::Imm);
                        self.emit_val(8);
                        self.emit_op(Op::Mul);
                    }
                    self.emit_op(Op::Add);
                    self.ty = t;
                } else if self.tk == Token::SubOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::MulOp as i64)?;
                    if t > Ty::Ptr as i64 && t == self.ty {
                        self.emit_op(Op::Sub);
                        self.emit_op(Op::Psh);
                        self.emit_op(Op::Imm);
                        self.emit_val(8);
                        self.emit_op(Op::Div);
                        self.ty = Ty::Int as i64;
                    } else if t > Ty::Ptr as i64 {
                        self.emit_op(Op::Psh);
                        self.emit_op(Op::Imm);
                        self.emit_val(8);
                        self.emit_op(Op::Mul);
                        self.emit_op(Op::Sub);
                        self.ty = t;
                    } else {
                        self.emit_op(Op::Sub);
                        self.ty = t;
                    }
                } else if self.tk == Token::MulOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::Inc as i64)?;
                    self.emit_op(Op::Mul);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::DivOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::Inc as i64)?;
                    self.emit_op(Op::Div);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::ModOp as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::Inc as i64)?;
                    self.emit_op(Op::Mod);
                    self.ty = Ty::Int as i64;
                } else if self.tk == Token::Inc as i64 || self.tk == Token::Dec as i64 {
                    let last = *self.text.last().unwrap();
                    if last == Op::Lc as i64 {
                        *self.text.last_mut().unwrap() = Op::Psh as i64;
                        self.emit_op(Op::Lc);
                    } else if last == Op::Li as i64 {
                        *self.text.last_mut().unwrap() = Op::Psh as i64;
                        self.emit_op(Op::Li);
                    } else {
                        return Err(C4Error::Compile(format!(
                            "{}: bad lvalue in post-increment",
                            self.line
                        )));
                    }
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
                    self.emit_op(if self.tk == Token::Inc as i64 {
                        Op::Add
                    } else {
                        Op::Sub
                    });
                    self.emit_op(if self.ty == Ty::Char as i64 {
                        Op::Sc
                    } else {
                        Op::Si
                    });
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
                    self.emit_op(if self.tk == Token::Inc as i64 {
                        Op::Sub
                    } else {
                        Op::Add
                    });
                    self.next()?;
                } else if self.tk == Token::Brak as i64 {
                    self.next()?;
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;
                    if self.tk == ']' as i64 {
                        self.next()?;
                    } else {
                        return Err(C4Error::Compile(format!(
                            "{}: close bracket expected",
                            self.line
                        )));
                    }
                    if t > Ty::Ptr as i64 {
                        self.emit_op(Op::Psh);
                        self.emit_op(Op::Imm);
                        self.emit_val(8);
                        self.emit_op(Op::Mul);
                    } else if t < Ty::Ptr as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: pointer type expected",
                            self.line
                        )));
                    }
                    self.emit_op(Op::Add);
                    self.ty = t - Ty::Ptr as i64;
                    self.emit_op(if self.ty == Ty::Char as i64 {
                        Op::Lc
                    } else {
                        Op::Li
                    });
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: compiler error tk={}",
                        self.line, self.tk
                    )));
                }
            }
            Ok(())
        }

        fn stmt(&mut self) -> Result<(), C4Error> {
            if self.tk == Token::Id as i64 {
                let mut p = self.src_pos;
                while p < self.src.len() && self.src[p].is_ascii_whitespace() {
                    p += 1;
                }
                if p < self.src.len() && self.src[p] == b':' {
                    let name = self.symbols[self.curr_id_idx].name.clone();
                    self.labels.insert(name, self.text.len());
                    self.next()?; // consume Id
                    self.next()?; // consume ':'
                    self.stmt()?;
                    return Ok(());
                }
            }

            if self.tk == Token::If as i64 {
                self.next()?;
                if self.tk == '(' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: open paren expected",
                        self.line
                    )));
                }
                self.expr(Token::Assign as i64)?;
                if self.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close paren expected",
                        self.line
                    )));
                }
                self.emit_op(Op::Bz);
                let b = self.text.len();
                self.emit_val(0);
                self.stmt()?;
                if self.tk == Token::Else as i64 {
                    self.text[b] = (self.text.len() + 2) as i64;
                    self.emit_op(Op::Jmp);
                    let b_else = self.text.len();
                    self.emit_val(0);
                    self.next()?;
                    self.stmt()?;
                    self.text[b_else] = self.text.len() as i64;
                } else {
                    self.text[b] = self.text.len() as i64;
                }
            } else if self.tk == Token::While as i64 {
                self.next()?;
                let cond_pc = self.text.len();
                if self.tk == '(' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: open paren expected",
                        self.line
                    )));
                }
                self.expr(Token::Assign as i64)?;
                if self.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close paren expected",
                        self.line
                    )));
                }
                self.emit_op(Op::Bz);
                let bz_pc = self.text.len();
                self.emit_val(0);

                self.loop_breaks.push(Vec::new());
                self.loop_continues.push(Vec::new());

                self.stmt()?;

                // Patch continues
                for pc in self.loop_continues.pop().unwrap() {
                    self.text[pc] = cond_pc as i64;
                }

                self.emit_op(Op::Jmp);
                self.emit_val(cond_pc as i64);

                // Patch condition end / breaks
                self.text[bz_pc] = self.text.len() as i64;
                let end_pc = self.text.len();
                for pc in self.loop_breaks.pop().unwrap() {
                    self.text[pc] = end_pc as i64;
                }
            } else if self.tk == Token::Do as i64 {
                self.next()?;
                let start_pc = self.text.len();

                self.loop_breaks.push(Vec::new());
                self.loop_continues.push(Vec::new());

                self.stmt()?;

                if self.tk == Token::While as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: while expected after do",
                        self.line
                    )));
                }

                let cond_pc = self.text.len();
                for pc in self.loop_continues.pop().unwrap() {
                    self.text[pc] = cond_pc as i64;
                }

                if self.tk == '(' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: open paren expected",
                        self.line
                    )));
                }
                self.expr(Token::Assign as i64)?;
                if self.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close paren expected",
                        self.line
                    )));
                }

                self.emit_op(Op::Bnz);
                self.emit_val(start_pc as i64);

                if self.tk == ';' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: semicolon expected after do-while",
                        self.line
                    )));
                }

                let end_pc = self.text.len();
                for pc in self.loop_breaks.pop().unwrap() {
                    self.text[pc] = end_pc as i64;
                }
            } else if self.tk == Token::For as i64 {
                self.next()?;
                if self.tk == '(' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: open paren expected",
                        self.line
                    )));
                }

                // Initialization
                if self.tk != ';' as i64 {
                    self.expr(Token::Assign as i64)?;
                }
                if self.tk == ';' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: semicolon expected after for-init",
                        self.line
                    )));
                }

                // Condition
                let cond_pc = self.text.len();
                if self.tk != ';' as i64 {
                    self.expr(Token::Assign as i64)?;
                } else {
                    self.emit_op(Op::Imm);
                    self.emit_val(1);
                }
                self.emit_op(Op::Bz);
                let end_jmp_pc = self.text.len();
                self.emit_val(0);

                self.emit_op(Op::Jmp);
                let body_jmp_pc = self.text.len();
                self.emit_val(0);

                if self.tk == ';' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: semicolon expected after for-cond",
                        self.line
                    )));
                }

                // Step
                let step_pc = self.text.len();
                if self.tk != ')' as i64 {
                    self.expr(Token::Assign as i64)?;
                }
                self.emit_op(Op::Jmp);
                self.emit_val(cond_pc as i64);

                if self.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close paren expected",
                        self.line
                    )));
                }

                // Body
                self.text[body_jmp_pc] = self.text.len() as i64;

                self.loop_breaks.push(Vec::new());
                self.loop_continues.push(Vec::new());

                self.stmt()?;

                for pc in self.loop_continues.pop().unwrap() {
                    self.text[pc] = step_pc as i64;
                }

                self.emit_op(Op::Jmp);
                self.emit_val(step_pc as i64);

                // End of loop / Patch Breaks
                self.text[end_jmp_pc] = self.text.len() as i64;
                let end_pc = self.text.len();
                for pc in self.loop_breaks.pop().unwrap() {
                    self.text[pc] = end_pc as i64;
                }
            } else if self.tk == Token::Switch as i64 {
                self.next()?;
                if self.tk == '(' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: open paren expected",
                        self.line
                    )));
                }

                self.loc_offs += 1;
                let switch_val_offset = -self.loc_offs;
                self.emit_op(Op::Lea);
                self.emit_val(switch_val_offset);
                self.emit_op(Op::Psh);

                self.expr(Token::Assign as i64)?;
                if self.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: close paren expected",
                        self.line
                    )));
                }

                self.emit_op(Op::Si);

                // 1. Jump immediately to the dispatcher (the case checks)
                self.emit_op(Op::Jmp);
                let disp_pc_patch = self.text.len();
                self.emit_val(0);

                self.switch_cases.push(Vec::new());
                self.switch_defaults.push(None);
                self.loop_breaks.push(Vec::new());

                // 2. Parse the body (the case labels and code)
                self.stmt()?;

                // 3. After the body, if we haven't broken out, jump to the end of the switch
                self.emit_op(Op::Jmp);
                let end_switch_patch = self.text.len();
                self.emit_val(0);

                // 4. Define the dispatcher block
                self.text[disp_pc_patch] = self.text.len() as i64;
                let cases = self.switch_cases.pop().unwrap();
                let default_pc = self.switch_defaults.pop().unwrap();

                for (val, pc) in cases {
                    self.emit_op(Op::Lea);
                    self.emit_val(switch_val_offset);
                    self.emit_op(Op::Li);
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(val);
                    self.emit_op(Op::Eq);
                    self.emit_op(Op::Bnz);
                    self.emit_val(pc as i64);
                }

                // 5. If no cases match, jump to default or the end
                if let Some(dpc) = default_pc {
                    self.emit_op(Op::Jmp);
                    self.emit_val(dpc as i64);
                } else {
                    // If no default, jump to the end
                    self.emit_op(Op::Jmp);
                    self.emit_val(0); // Will be patched below
                    self.loop_breaks
                        .last_mut()
                        .unwrap()
                        .push(self.text.len() - 1);
                }

                // 6. Patch the jump that skips the dispatcher and the breaks
                self.text[end_switch_patch] = self.text.len() as i64;
                let end_pc = self.text.len();
                for pc in self.loop_breaks.pop().unwrap() {
                    self.text[pc] = end_pc as i64;
                }
            } else if self.tk == Token::Case as i64 {
                self.next()?;
                if self.tk != Token::Num as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: invalid case value",
                        self.line
                    )));
                }
                let val = self.ival;
                self.next()?;
                if self.tk != ':' as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: expected colon after case",
                        self.line
                    )));
                }
                self.next()?;
                if let Some(cases) = self.switch_cases.last_mut() {
                    cases.push((val, self.text.len()));
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: case outside switch",
                        self.line
                    )));
                }
                self.stmt()?;
            } else if self.tk == Token::Default as i64 {
                self.next()?;
                if self.tk != ':' as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: expected colon after default",
                        self.line
                    )));
                }
                self.next()?;
                if let Some(def) = self.switch_defaults.last_mut() {
                    *def = Some(self.text.len());
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: default outside switch",
                        self.line
                    )));
                }
                self.stmt()?;
            } else if self.tk == Token::Goto as i64 {
                self.next()?;
                if self.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: expected identifier after goto",
                        self.line
                    )));
                }
                let target_name = self.symbols[self.curr_id_idx].name.clone();
                self.next()?;

                self.emit_op(Op::Jmp);
                let pc = self.text.len();
                self.emit_val(0);

                if let Some(&target) = self.labels.get(&target_name) {
                    self.text[pc] = target as i64;
                } else {
                    self.unresolved_gotos.push((target_name, pc));
                }

                if self.tk == ';' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: semicolon expected after goto",
                        self.line
                    )));
                }
            } else if self.tk == Token::Break as i64 {
                self.next()?;
                if self.loop_breaks.is_empty() {
                    return Err(C4Error::Compile(format!(
                        "{}: break outside of loop or switch",
                        self.line
                    )));
                }
                self.emit_op(Op::Jmp);
                let pc = self.text.len();
                self.emit_val(0);
                self.loop_breaks.last_mut().unwrap().push(pc);

                if self.tk == ';' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: semicolon expected after break",
                        self.line
                    )));
                }
            } else if self.tk == Token::Continue as i64 {
                self.next()?;
                if self.loop_continues.is_empty() {
                    return Err(C4Error::Compile(format!(
                        "{}: continue outside of loop",
                        self.line
                    )));
                }
                self.emit_op(Op::Jmp);
                let pc = self.text.len();
                self.emit_val(0);
                self.loop_continues.last_mut().unwrap().push(pc);

                if self.tk == ';' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: semicolon expected after continue",
                        self.line
                    )));
                }
            } else if self.tk == Token::Return as i64 {
                self.next()?;
                if self.tk != ';' as i64 {
                    self.expr(Token::Assign as i64)?;
                }
                self.emit_op(Op::Lev);
                if self.tk == ';' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: semicolon expected",
                        self.line
                    )));
                }
            } else if self.tk == '{' as i64 {
                self.next()?;
                let mut block_symbols = Vec::new();

                // Parse block-scoped local variables
                while self.tk == Token::Int as i64 || self.tk == Token::Char as i64 {
                    let lbt = if self.tk == Token::Int as i64 {
                        Ty::Int as i64
                    } else {
                        Ty::Char as i64
                    };
                    self.next()?;
                    while self.tk != ';' as i64 {
                        self.ty = lbt;
                        while self.tk == Token::MulOp as i64 {
                            self.next()?;
                            self.ty += Ty::Ptr as i64;
                        }
                        if self.tk != Token::Id as i64 {
                            return Err(C4Error::Compile(format!(
                                "{}: bad local declaration",
                                self.line
                            )));
                        }
                        let loc_idx = self.curr_id_idx;

                        block_symbols.push((
                            loc_idx,
                            self.symbols[loc_idx].class,
                            self.symbols[loc_idx].type_,
                            self.symbols[loc_idx].val,
                        ));

                        self.symbols[loc_idx].class = Token::Loc as i64;
                        self.symbols[loc_idx].type_ = self.ty;
                        self.loc_offs += 1;
                        self.symbols[loc_idx].val = -self.loc_offs;

                        self.next()?;
                        if self.tk == ',' as i64 {
                            self.next()?;
                        }
                    }
                    self.next()?;
                }

                while self.tk != '}' as i64 {
                    self.stmt()?;
                }
                self.next()?;

                // Restore shadowed variables
                for (idx, class, ty, val) in block_symbols.into_iter().rev() {
                    self.symbols[idx].class = class;
                    self.symbols[idx].type_ = ty;
                    self.symbols[idx].val = val;
                }
            } else if self.tk == ';' as i64 {
                self.next()?;
            } else {
                self.expr(Token::Assign as i64)?;
                if self.tk == ';' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: semicolon expected",
                        self.line
                    )));
                }
            }
            Ok(())
        }

        fn parse_enum_decl(&mut self) -> Result<(), C4Error> {
            self.next()?;
            if self.tk != '{' as i64 {
                self.next()?;
            }
            if self.tk == '{' as i64 {
                self.next()?;
                let mut i = 0;
                while self.tk != '}' as i64 {
                    if self.tk != Token::Id as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad enum identifier",
                            self.line
                        )));
                    }
                    let idx = self.curr_id_idx;
                    self.next()?;
                    if self.tk == Token::Assign as i64 {
                        self.next()?;
                        if self.tk != Token::Num as i64 {
                            return Err(C4Error::Compile(format!(
                                "{}: bad enum initializer",
                                self.line
                            )));
                        }
                        i = self.ival;
                        self.next()?;
                    }
                    self.symbols[idx].class = Token::Num as i64;
                    self.symbols[idx].type_ = Ty::Int as i64;
                    self.symbols[idx].val = i;
                    i += 1;
                    if self.tk == ',' as i64 {
                        self.next()?;
                    }
                }
                self.next()?;
            }
            Ok(())
        }

        fn parse_function_params(&mut self) -> Result<Vec<usize>, C4Error> {
            let mut args = Vec::new();
            while self.tk != ')' as i64 {
                self.ty = Ty::Int as i64;
                if self.tk == Token::Int as i64 {
                    self.next()?;
                } else if self.tk == Token::Char as i64 {
                    self.next()?;
                    self.ty = Ty::Char as i64;
                }
                while self.tk == Token::MulOp as i64 {
                    self.next()?;
                    self.ty += Ty::Ptr as i64;
                }
                if self.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: bad parameter declaration",
                        self.line
                    )));
                }
                let param_idx = self.curr_id_idx;
                if self.symbols[param_idx].class == Token::Loc as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: duplicate parameter definition",
                        self.line
                    )));
                }

                self.symbols[param_idx].h_class = self.symbols[param_idx].class;
                self.symbols[param_idx].class = Token::Loc as i64;
                self.symbols[param_idx].h_type = self.symbols[param_idx].type_;
                self.symbols[param_idx].type_ = self.ty;
                self.symbols[param_idx].h_val = self.symbols[param_idx].val;

                args.push(param_idx);

                self.next()?;
                if self.tk == ',' as i64 {
                    self.next()?;
                }
            }
            self.next()?;
            Ok(args)
        }

        pub fn compile(&mut self) -> Result<(), C4Error> {
            self.next()?;
            while self.tk != 0 {
                let mut bt = Ty::Int as i64;
                if self.tk == Token::Int as i64 {
                    self.next()?;
                    bt = Ty::Int as i64;
                } else if self.tk == Token::Char as i64 {
                    self.next()?;
                    bt = Ty::Char as i64;
                } else if self.tk == Token::Enum as i64 {
                    self.parse_enum_decl()?;
                }

                while self.tk != ';' as i64 && self.tk != '}' as i64 {
                    self.ty = bt;
                    while self.tk == Token::MulOp as i64 {
                        self.next()?;
                        self.ty += Ty::Ptr as i64;
                    }
                    if self.tk != Token::Id as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad global declaration",
                            self.line
                        )));
                    }
                    let id_idx = self.curr_id_idx;
                    if self.symbols[id_idx].class != 0 {
                        return Err(C4Error::Compile(format!(
                            "{}: duplicate global definition",
                            self.line
                        )));
                    }
                    self.next()?;
                    self.symbols[id_idx].type_ = self.ty;

                    if self.tk == '(' as i64 {
                        self.symbols[id_idx].class = Token::Fun as i64;
                        self.symbols[id_idx].val = self.text.len() as i64;
                        self.next()?;

                        let args = self.parse_function_params()?;

                        if self.tk != '{' as i64 {
                            return Err(C4Error::Compile(format!(
                                "{}: bad function definition",
                                self.line
                            )));
                        }
                        self.next()?;

                        let nargs = args.len() as i64;
                        for (i, &idx) in args.iter().enumerate() {
                            self.symbols[idx].val = nargs - (i as i64) + 1;
                        }

                        self.loc_offs = 0;
                        self.labels.clear();
                        self.unresolved_gotos.clear();

                        while self.tk == Token::Int as i64 || self.tk == Token::Char as i64 {
                            let lbt = if self.tk == Token::Int as i64 {
                                Ty::Int as i64
                            } else {
                                Ty::Char as i64
                            };
                            self.next()?;
                            while self.tk != ';' as i64 {
                                self.ty = lbt;
                                while self.tk == Token::MulOp as i64 {
                                    self.next()?;
                                    self.ty += Ty::Ptr as i64;
                                }
                                if self.tk != Token::Id as i64 {
                                    return Err(C4Error::Compile(format!(
                                        "{}: bad local declaration",
                                        self.line
                                    )));
                                }
                                let loc_idx = self.curr_id_idx;
                                if self.symbols[loc_idx].class == Token::Loc as i64 {
                                    return Err(C4Error::Compile(format!(
                                        "{}: duplicate local definition",
                                        self.line
                                    )));
                                }

                                self.symbols[loc_idx].h_class = self.symbols[loc_idx].class;
                                self.symbols[loc_idx].class = Token::Loc as i64;
                                self.symbols[loc_idx].h_type = self.symbols[loc_idx].type_;
                                self.symbols[loc_idx].type_ = self.ty;
                                self.symbols[loc_idx].h_val = self.symbols[loc_idx].val;

                                self.loc_offs += 1;
                                self.symbols[loc_idx].val = -self.loc_offs;

                                self.next()?;
                                if self.tk == ',' as i64 {
                                    self.next()?;
                                }
                            }
                            self.next()?;
                        }

                        let ent_pc = self.text.len();
                        self.emit_op(Op::Ent);
                        self.emit_val(0); // Placeholder patched at the end of function body

                        while self.tk != '}' as i64 {
                            self.stmt()?;
                        }
                        self.emit_op(Op::Lev);

                        // Patch the 'Ent' placeholder instruction
                        self.text[ent_pc + 1] = self.loc_offs;

                        // Resolve pending gotos against recorded function labels
                        for (name, pc) in &self.unresolved_gotos {
                            if let Some(&target) = self.labels.get(name) {
                                self.text[*pc] = target as i64;
                            } else {
                                return Err(C4Error::Compile(format!(
                                    "unresolved label: {}",
                                    name
                                )));
                            }
                        }

                        for sym in self.symbols.iter_mut() {
                            if sym.class == Token::Loc as i64 {
                                sym.class = sym.h_class;
                                sym.type_ = sym.h_type;
                                sym.val = sym.h_val;
                            }
                        }
                    } else {
                        self.symbols[id_idx].class = Token::Glo as i64;
                        self.symbols[id_idx].val = self.data.len() as i64;
                        for _ in 0..8 {
                            self.data.push(0);
                        }
                    }
                    if self.tk == ',' as i64 {
                        self.next()?;
                    }
                }
                self.next()?;
            }
            Ok(())
        }

        pub fn run(&mut self) -> Result<i64, C4Error> {
            let main_sym = self
                .find_symbol("main")
                .ok_or_else(|| C4Error::Runtime("main() not defined".to_string()))?;
            let pc_start = self.symbols[main_sym].val;
            if pc_start == 0 && self.text.is_empty() {
                return Err(C4Error::Runtime("main() not defined".to_string()));
            }

            let mut sp = STACK_BASE + STACK_CAPACITY * 8;
            let mut bp = sp;

            let bootstrap_addr = self.text.len() as i64;
            self.emit_op(Op::Psh);
            self.emit_op(Op::Exit);

            sp -= 8;
            self.store_i64(sp, 0)?;
            sp -= 8;
            self.store_i64(sp, 0)?;

            sp -= 8;
            self.store_i64(sp, bootstrap_addr)?;

            let mut pc = pc_start as usize;
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
}

// --- Tests ---
#[cfg(test)]
mod tests {
    use super::c4::*;

    fn setup_and_compile(code: &str) -> C4 {
        let mut vm = C4::new(code.to_string(), false);
        vm.compile().unwrap();
        vm
    }

    #[test]
    fn test_arithmetic() {
        let code = r#"
        int main() { 
            return (10 + 20) * 2; 
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 60);
    }

    #[test]
    fn test_goto() {
        let code = r#"
        int main() {
            int a;
            a = 0;
        start:
            a = a + 1;
            if (a < 5) goto start;
            goto end;
            a = a + 100;
        end:
            return a;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 5);
    }

    #[test]
    fn test_function_pointers() {
        let code = r#"
        int add(int a, int b) { return a + b; }
        int sub(int a, int b) { return a - b; }
        int main() {
            int *fp;
            int res1;
            int res2;
            fp = add;
            res1 = fp(10, 20);
            fp = sub;
            res2 = fp(10, 5);
            return res1 * res2;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 150); // 30 * 5 = 150
    }

    #[test]
    fn test_switch_statement() {
        let code = r#"
        int main() {
            int a; int res;
            a = 2; res = 0;
            switch(a) {
                case 1: res = 10; break;
                case 2: res = 20; // Tests fallthrough
                case 3: res = res + 5; break;
                default: res = 100; break;
            }
            return res;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 25);
    }

    #[test]
    fn test_switch_default_routing() {
        let code = r#"
        int main() {
            int a; int res;
            a = 99; res = 0;
            switch(a) {
                case 1: res = 10; break;
                case 2: res = 20; break;
                default: res = 100; break;
            }
            return res;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 100);
    }

    #[test]
    fn test_control_flow() {
        let code = r#"
        int main() { 
            int i;
            i = 0;
            while (i < 5) {
                i = i + 1;
            }
            if (i == 5) return 1;
            return 0;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 1);
    }

    #[test]
    fn test_do_while() {
        let code = r#"
        int main() {
            int i;
            i = 0;
            do {
                i = i + 1;
            } while (i < 5);
            return i;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 5);
    }

    #[test]
    fn test_break_continue() {
        let code = r#"
        int main() {
            int i;
            int sum;
            sum = 0;
            for (i = 0; i < 10; i++) {
                if (i == 5) break;
                if (i % 2 == 0) continue;
                sum = sum + i;
            }
            return sum; // Should be 1 + 3 = 4
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 4);
    }

    #[test]
    fn test_for_loop() {
        let code = r#"
        int main() {
            int i;
            int sum;
            sum = 0;
            for (i = 0; i < 5; i++) {
                sum = sum + i;
            }
            return sum; 
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 10);
    }

    #[test]
    fn test_recursion_factorial() {
        let code = r#"
        int fact(int n) {
            if (n < 2) return 1;
            return n * fact(n - 1);
        }
        int main() { 
            return fact(5);
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 120);
    }

    #[test]
    fn test_pointers() {
        let code = r#"
        int main() {
            int a;
            int *p;
            a = 100;
            p = &a;
            *p = 200;
            return a;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 200);
    }

    #[test]
    fn test_nested_function_calls() {
        let code = r#"
        int add(int a, int b) {
            return a + b;
        }
        int main() {
            return add(add(10, 20), add(30, 40));
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 100);
    }

    #[test]
    fn test_printf() {
        let code = r#"
        int main() {
            printf("Hello %d\n", 123);
            return 0;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 0);
    }

    #[test]
    fn test_memory_ops() {
        let code = r#"
        int main() {
            char *s1;
            char *s2;
            s1 = malloc(10);
            s2 = malloc(10);
            memset(s1, 'A', 9);
            s1[9] = 0;
            memset(s2, 'A', 9);
            s2[9] = 0;
            if (memcmp(s1, s2, 10) != 0) return 1;
            s2[5] = 'B';
            if (memcmp(s1, s2, 10) == 0) return 2;
            return 0;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 0);
    }

    #[test]
    fn test_file_io() {
        std::fs::write("test_dummy.txt", "1234567890").unwrap();

        let code = r#"
        int main() {
            int fd;
            char *buf;
            fd = open("test_dummy.txt", 0);
            if (fd < 0) return 1;
            
            buf = malloc(10);
            read(fd, buf, 9);
            buf[9] = 0;
            close(fd);
            
            return 0;
        }
        "#;
        let mut vm = setup_and_compile(code);
        let res = vm.run().unwrap();

        std::fs::remove_file("test_dummy.txt").unwrap();
        assert_eq!(res, 0);
    }

    #[test]
    fn test_ir_execution() {
        let mut vm = C4::new("".to_string(), false);
        vm.text = vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            5,
            Op::Psh as i64,
            Op::Imm as i64,
            10,
            Op::Add as i64,
            Op::Lev as i64,
        ];

        let _ = vm.resolve_symbol(b"main", vm.hash_name(b"main"));
        let main_sym = vm.find_symbol("main").unwrap();
        vm.symbols[main_sym].val = 0;

        let res = vm.run().unwrap();
        assert_eq!(res, 15);
    }

    #[test]
    fn test_ir_translation_simple() {
        let code = r#"
        int main() {
            return 42;
        }
        "#;
        let mut vm = C4::new(code.to_string(), false);
        vm.compile().unwrap();

        let expected_text = vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            42,
            Op::Lev as i64,
            Op::Lev as i64,
        ];
        assert_eq!(vm.text, expected_text);
    }

    #[test]
    fn test_ir_translation_if() {
        let code = r#"
        int main() {
            if (1) {
                return 2;
            } else {
                return 3;
            }
        }
        "#;
        let vm = setup_and_compile(code);

        let bz_target = 11;
        let jmp_target = 14;

        let expected_text = vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            1,
            Op::Bz as i64,
            bz_target,
            Op::Imm as i64,
            2,
            Op::Lev as i64,
            Op::Jmp as i64,
            jmp_target,
            Op::Imm as i64,
            3,
            Op::Lev as i64,
            Op::Lev as i64,
        ];
        assert_eq!(vm.text, expected_text);
    }

    #[test]
    fn test_ir_translation_while() {
        let code = r#"
        int main() {
            while (0) {
                return 1;
            }
        }
        "#;
        let vm = setup_and_compile(code);

        let bz_target = 11;
        let jmp_target = 2;

        let expected_text = vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            0,
            Op::Bz as i64,
            bz_target,
            Op::Imm as i64,
            1,
            Op::Lev as i64,
            Op::Jmp as i64,
            jmp_target,
            Op::Lev as i64,
        ];
        assert_eq!(vm.text, expected_text);
    }

    #[test]
    fn test_pointer_arithmetic_scaling() {
        let code = r#"
            int main() {
                int *p;
                p = 100; 
                return p + 1; // Should return 108, not 101
            }
            "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 108);
    }

    #[test]
    fn test_expression_precedence() {
        let code = "int main() { return 2 + 3 * 4 == 14; }";
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 1);
    }

    #[test]
    fn test_variable_shadowing() {
        let code = r#"
        int main() {
            int i; i = 10;
            if (1) { int i; i = 20; }
            return i;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 10);
    }

    #[test]
    fn test_pointer_arithmetic() {
        let code = r#"
        int main() {
            int *p;
            p = malloc(16);
            *p = 1;
            *(p + 1) = 2;
            return *p + *(p + 1);
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 3);
    }

    #[test]
    fn test_memset_mcmp() {
        let code = r#"
        int main() {
            char *s; s = malloc(5);
            memset(s, 65, 4); // 'AAAA'
            s[4] = 0;
            if (s[0] == 65) return 42;
            return 0;
        }
        "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 42);
    }

    #[test]
    fn test_quicksort() {
        let code = r#"
            void swap(int *a, int *b) {
                int t;
                t = *a;
                *a = *b;
                *b = t;
            }

            int partition(int *arr, int low, int high) {
                int pivot;
                int i;
                int j;
                
                pivot = arr[high];
                i = low - 1;
                
                for (j = low; j < high; j++) {
                    if (arr[j] <= pivot) {
                        i++;
                        swap(&arr[i], &arr[j]);
                    }
                }
                swap(&arr[i + 1], &arr[high]);
                return i + 1;
            }

            void quicksort(int *arr, int low, int high) {
                int pi;
                if (low < high) {
                    pi = partition(arr, low, high);
                    quicksort(arr, low, pi - 1);
                    quicksort(arr, pi + 1, high);
                }
            }

            int main() {
                int *arr;
                int i;
                arr = malloc(40); // 5 integers * 8 bytes
                arr[0] = 12; arr[1] = 7; arr[2] = 15; arr[3] = 5; arr[4] = 10;
                
                quicksort(arr, 0, 4);
                
                // Check if sorted: 5, 7, 10, 12, 15
                if (arr[0] != 5) return 1;
                if (arr[1] != 7) return 2;
                if (arr[2] != 10) return 3;
                if (arr[3] != 12) return 4;
                if (arr[4] != 15) return 5;
                
                return 0; // Success
            }
            "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 0);
    }

    #[test]
    fn test_linked_list() {
        let code = r#"
            int main() {
                int *head; int *temp; int *node;
                int sum; int i;

                head = 0;
                sum = 0;

                // Create a list of 5 nodes: [4, 3, 2, 1, 0]
                for (i = 0; i < 5; i++) {
                    node = malloc(16); // 8 bytes for value, 8 bytes for next pointer
                    node[0] = i;       // data
                    node[1] = head;    // next
                    head = node;
                }

                // Traverse and sum
                temp = head;
                while (temp != 0) {
                    sum = sum + temp[0];
                    temp = temp[1];
                }

                return sum; // Expected: 4+3+2+1+0 = 10
            }
            "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 10);
    }

    #[test]
    fn test_binary_search_tree() {
        let code = r#"
            int* insert(int *root, int val) {
                if (root == 0) {
                    root = malloc(24); // [0]=val, [1]=left, [2]=right
                    root[0] = val;
                    root[1] = 0;
                    root[2] = 0;
                    return root;
                }
                if (val < root[0]) {
                    root[1] = insert(root[1], val);
                } else {
                    root[2] = insert(root[2], val);
                }
                return root;
            }

            int search(int *root, int val) {
                if (root == 0) return 0;
                if (root[0] == val) return 1;
                if (val < root[0]) return search(root[1], val);
                return search(root[2], val);
            }

            int main() {
                int *root;
                root = 0;
                root = insert(root, 50);
                insert(root, 30);
                insert(root, 70);
                insert(root, 20);
                insert(root, 40);

                if (search(root, 20) == 0) return 1; // Failed to find existing
                if (search(root, 40) == 0) return 2; // Failed to find existing
                if (search(root, 99) == 1) return 3; // Found non-existent
                
                return 0; // Success
            }
            "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 0);
    }

    #[test]
    fn test_bst_free() {
        let code = r#"
            void free_tree(int *root) {
                if (root == 0) return;
                
                // Post-order traversal: visit children before the parent
                free_tree(root[1]); // left
                free_tree(root[2]); // right
                
                free(root);
            }

            int* insert(int *root, int val) {
                if (root == 0) {
                    root = malloc(24);
                    root[0] = val; root[1] = 0; root[2] = 0;
                    return root;
                }
                if (val < root[0]) root[1] = insert(root[1], val);
                else root[2] = insert(root[2], val);
                return root;
            }

            int main() {
                int *root;
                root = 0;
                root = insert(root, 50);
                insert(root, 30);
                insert(root, 70);
                
                // This validates the recursive calls for deallocation
                free_tree(root);
                
                return 0; // Success if no VM crash
            }
            "#;
        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 0);
    }

    #[test]
    fn test_double_pointers() {
        let code = r#"
            int main() {
                int a;
                int *p;
                int **pp;
                int **matrix;
                
                // 1. Basic address-of and double dereference
                a = 10;
                p = &a;
                pp = &p;
                
                **pp = 42; // Modifies 'a' through the double pointer
                
                if (a != 42) return 1;
                if (*p != 42) return 2;
                
                // 2. Dynamic memory and 2D array syntax
                matrix = malloc(8);    // Allocate array of 1 pointer (8 bytes)
                matrix[0] = malloc(8); // Allocate array of 1 integer for the first row
                
                matrix[0][0] = 123;    // Write via chained brackets
                
                if (**matrix != 123) return 3;
                if (matrix[0][0] != 123) return 4;
                
                return 0; // Success
            }
            "#;

        let mut vm = setup_and_compile(code);
        assert_eq!(vm.run().unwrap(), 0);
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        eprintln!("usage: c4_rust <file>");
        return;
    }

    let path = &args[1];
    let mut file = std::fs::File::open(path).expect("Could not open file");
    let mut contents = String::new();
    std::io::Read::read_to_string(&mut file, &mut contents).expect("Could not read file");

    let mut vm = c4::C4::new(contents, false);
    if let Err(e) = vm.compile() {
        eprintln!("{}", e);
        std::process::exit(1);
    }

    match vm.run() {
        Ok(res) => println!("exit({})", res),
        Err(e) => {
            eprintln!("{}", e);
            std::process::exit(1);
        }
    }
}
