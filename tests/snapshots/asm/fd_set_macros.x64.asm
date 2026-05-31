
fd_set_macros.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003f6 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400345 <.text+0x85>
               	leaq	0xfde5(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdc5(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdb6(%rip), %rdi      # 0x41011e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfda8(%rip), %rdi      # 0x410125
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400dd7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003c7 <.text+0x107>
               	leaq	0xfd4e(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x4003c7 <.text+0x107>
               	leaq	0xfd32(%rip), %r12      # 0x410100
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	jmp	0x40040a <.text+0x14a>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0x88(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x90(%rbp)
               	jmp	0x400443 <.text+0x183>
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	jne	0x40040a <.text+0x14a>
               	xorq	%r9, %r9
               	movl	%r9d, -0x98(%rbp)
               	jmp	0x400490 <.text+0x1d0>
               	movslq	-0x90(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	0x40048b <.text+0x1cb>
               	movq	-0x88(%rbp), %r11
               	movslq	-0x90(%rbp), %r9
               	addq	%r9, %r11
               	xorq	%r9, %r9
               	movb	%r9b, (%r11)
               	movslq	-0x90(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x90(%rbp)
               	jmp	0x400443 <.text+0x183>
               	jmp	0x400424 <.text+0x164>
               	movslq	-0x98(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	0x4004d1 <.text+0x211>
               	leaq	-0x80(%rbp), %r8
               	movslq	-0x98(%rbp), %r9
               	addq	%r9, %r8
               	movzbq	(%r8), %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4004ef <.text+0x22f>
               	jmp	0x4004d6 <.text+0x216>
               	jmp	0x40050c <.text+0x24c>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movslq	-0x98(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x98(%rbp)
               	jmp	0x400490 <.text+0x1d0>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xa0(%rbp)
               	movq	-0xa0(%rbp), %r8
               	xorq	%r9, %r9
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %r8
               	movzbq	(%r8), %r9
               	orq	$0x1, %r9
               	movb	%r9b, (%r8)
               	jmp	0x40054c <.text+0x28c>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	0x40050c <.text+0x24c>
               	jmp	0x400561 <.text+0x2a1>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %r9
               	movl	$0x7, %r11d
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	movl	$0x1, %r8d
               	shlq	$0x7, %r8
               	orq	%r8, %r11
               	movb	%r11b, (%r9)
               	jmp	0x4005ad <.text+0x2ed>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x400561 <.text+0x2a1>
               	jmp	0x4005c2 <.text+0x302>
               	leaq	-0x80(%rbp), %r8
               	movq	%r8, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %r11
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	addq	%r8, %r11
               	movzbq	(%r11), %r8
               	orq	$0x1, %r8
               	movb	%r8b, (%r11)
               	jmp	0x400602 <.text+0x342>
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	jne	0x4005c2 <.text+0x302>
               	jmp	0x400617 <.text+0x357>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %r8
               	movl	$0x64, %r9d
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %r8
               	movzbq	(%r8), %r9
               	movl	$0x1, %r11d
               	shlq	$0x4, %r11
               	orq	%r11, %r9
               	movb	%r9b, (%r8)
               	jmp	0x400660 <.text+0x3a0>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	0x400617 <.text+0x357>
               	leaq	-0x80(%rbp), %r11
               	xorq	%r9, %r9
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %r11
               	movzbq	(%r11), %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	0x4006c3 <.text+0x403>
               	movl	$0x2, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movl	$0x7, %r11d
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	movl	$0x1, %r9d
               	shlq	$0x7, %r9
               	andq	%r9, %r11
               	cmpq	$0x0, %r11
               	jne	0x40071f <.text+0x45f>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %r11
               	movzbq	(%r11), %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	0x40076f <.text+0x4af>
               	movl	$0x4, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movl	$0x64, %r11d
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	movl	$0x1, %r9d
               	shlq	$0x4, %r9
               	andq	%r9, %r11
               	cmpq	$0x0, %r11
               	jne	0x4007cb <.text+0x50b>
               	movl	$0x5, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x1, %r9d
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	addq	%rdi, %r11
               	movzbq	(%r11), %rdi
               	shlq	$0x1, %r9
               	andq	%r9, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400821 <.text+0x561>
               	movl	$0x6, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x32, %r9d
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rdi
               	movzbq	(%rdi), %r9
               	movl	$0x1, %edi
               	shlq	$0x2, %rdi
               	andq	%rdi, %r9
               	cmpq	$0x0, %r9
               	je	0x400878 <.text+0x5b8>
               	movl	$0x7, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movzbq	(%r9), %rdi
               	xorq	$0x81, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4008b6 <.text+0x5f6>
               	movl	$0xb, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movq	%r9, %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %r11
               	xorq	$0x1, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4008f9 <.text+0x639>
               	movl	$0xc, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	addq	$0xc, %r9
               	movzbq	(%r9), %r11
               	xorq	$0x10, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x40093a <.text+0x67a>
               	movl	$0xd, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x40093f <.text+0x67f>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0xc8(%rbp)
               	movq	-0xc8(%rbp), %r9
               	movl	$0x7, %r11d
               	movl	$0x8, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	movl	$0x1, %edi
               	shlq	$0x7, %rdi
               	xorq	$-0x1, %rdi
               	andq	%rdi, %r11
               	movb	%r11b, (%r9)
               	jmp	0x400990 <.text+0x6d0>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x40093f <.text+0x67f>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x7, %r11d
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %rdi
               	movzbq	(%rdi), %r11
               	movl	$0x1, %edi
               	shlq	$0x7, %rdi
               	andq	%rdi, %r11
               	cmpq	$0x0, %r11
               	je	0x4009fa <.text+0x73a>
               	movl	$0x15, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	xorq	%rdi, %rdi
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	addq	%rdi, %r11
               	movzbq	(%r11), %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x400a4d <.text+0x78d>
               	movl	$0x16, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x8, %r11d
               	movq	%r11, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %rdi
               	movzbq	(%rdi), %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	jne	0x400a9c <.text+0x7dc>
               	movl	$0x17, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x400aa1 <.text+0x7e1>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0xd0(%rbp)
               	movq	-0xd0(%rbp), %rdi
               	xorq	%r11, %r11
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %rdi
               	movzbq	(%rdi), %r11
               	orq	$0x1, %r11
               	movb	%r11b, (%rdi)
               	jmp	0x400ae4 <.text+0x824>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x400aa1 <.text+0x7e1>
               	leaq	-0x80(%rbp), %r9
               	xorq	%r11, %r11
               	movl	$0x8, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	jne	0x400b46 <.text+0x886>
               	movl	$0x18, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x400b4b <.text+0x88b>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0xd8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0xe0(%rbp)
               	jmp	0x400bb1 <.text+0x8f1>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x400b4b <.text+0x88b>
               	leaq	-0x80(%rbp), %r9
               	xorq	%rdi, %rdi
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	addq	%rdi, %r9
               	movzbq	(%r9), %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400c16 <.text+0x956>
               	jmp	0x400bfd <.text+0x93d>
               	movslq	-0xe0(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	0x400bf8 <.text+0x938>
               	movq	-0xd8(%rbp), %r11
               	movslq	-0xe0(%rbp), %r9
               	addq	%r9, %r11
               	xorq	%r9, %r9
               	movb	%r9b, (%r11)
               	movslq	-0xe0(%rbp), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0xe0(%rbp)
               	jmp	0x400bb1 <.text+0x8f1>
               	jmp	0x400b65 <.text+0x8a5>
               	movl	$0x19, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x64, %r9d
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	addq	%r9, %rdi
               	movzbq	(%rdi), %r9
               	movl	$0x1, %edi
               	shlq	$0x4, %rdi
               	andq	%rdi, %r9
               	cmpq	$0x0, %r9
               	je	0x400c6d <.text+0x9ad>
               	movl	$0x1a, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	0xf4dc(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400ddd <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
