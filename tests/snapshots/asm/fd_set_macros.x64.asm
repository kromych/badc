
fd_set_macros.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400410 <.text+0x150>
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
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
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
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400ea7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
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
               	jmp	0x400424 <.text+0x164>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0x88(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x90(%rbp)
               	jmp	0x40045d <.text+0x19d>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x400424 <.text+0x164>
               	xorq	%r9, %r9
               	movl	%r9d, -0x98(%rbp)
               	jmp	0x4004b0 <.text+0x1f0>
               	movslq	-0x90(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	0x4004ab <.text+0x1eb>
               	movq	-0x88(%rbp), %r9
               	movslq	-0x90(%rbp), %r11
               	movq	%r9, %r8
               	addq	%r11, %r8
               	xorq	%r11, %r11
               	movb	%r11b, (%r8)
               	movslq	-0x90(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x90(%rbp)
               	jmp	0x40045d <.text+0x19d>
               	jmp	0x40043e <.text+0x17e>
               	movslq	-0x98(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	0x4004f4 <.text+0x234>
               	leaq	-0x80(%rbp), %r9
               	movslq	-0x98(%rbp), %r11
               	movq	%r9, %r8
               	addq	%r11, %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400512 <.text+0x252>
               	jmp	0x4004f9 <.text+0x239>
               	jmp	0x400532 <.text+0x272>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movslq	-0x98(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x98(%rbp)
               	jmp	0x4004b0 <.text+0x1f0>
               	leaq	-0x80(%rbp), %r8
               	movq	%r8, -0xa0(%rbp)
               	movq	-0xa0(%rbp), %r11
               	xorq	%r8, %r8
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%r11, %r9
               	addq	%rdi, %r9
               	movzbq	(%r9), %rdi
               	movq	%rdi, %r11
               	orq	$0x1, %r11
               	movb	%r11b, (%r9)
               	jmp	0x40057b <.text+0x2bb>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x400532 <.text+0x272>
               	jmp	0x400590 <.text+0x2d0>
               	leaq	-0x80(%rbp), %rdi
               	movq	%rdi, -0xa8(%rbp)
               	movq	-0xa8(%rbp), %r11
               	movl	$0x7, %edi
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movzbq	(%r9), %r8
               	movl	$0x1, %r11d
               	movq	%r11, %rdi
               	shlq	$0x7, %rdi
               	movq	%r8, %r11
               	orq	%rdi, %r11
               	movb	%r11b, (%r9)
               	jmp	0x4005e4 <.text+0x324>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x400590 <.text+0x2d0>
               	jmp	0x4005f9 <.text+0x339>
               	leaq	-0x80(%rbp), %rdi
               	movq	%rdi, -0xb0(%rbp)
               	movq	-0xb0(%rbp), %r11
               	movl	$0x8, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movzbq	(%rdi), %r9
               	movq	%r9, %r11
               	orq	$0x1, %r11
               	movb	%r11b, (%rdi)
               	jmp	0x40063e <.text+0x37e>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x4005f9 <.text+0x339>
               	jmp	0x400653 <.text+0x393>
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, -0xb8(%rbp)
               	movq	-0xb8(%rbp), %r11
               	movl	$0x64, %r9d
               	movl	$0x8, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movzbq	(%rdi), %r8
               	movl	$0x1, %r11d
               	movq	%r11, %r9
               	shlq	$0x4, %r9
               	movq	%r8, %r11
               	orq	%r9, %r11
               	movb	%r11b, (%rdi)
               	jmp	0x4006a7 <.text+0x3e7>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x400653 <.text+0x393>
               	leaq	-0x80(%rbp), %r9
               	xorq	%r11, %r11
               	movl	$0x8, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movzbq	(%rdi), %r8
               	movq	%r8, %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x40070e <.text+0x44e>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r8
               	movl	$0x7, %edi
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	movl	$0x1, %r9d
               	movq	%r9, %r8
               	shlq	$0x7, %r8
               	movq	%r11, %r9
               	andq	%r8, %r9
               	cmpq	$0x0, %r9
               	jne	0x400772 <.text+0x4b2>
               	movl	$0x3, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r8
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	movq	%r11, %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	jne	0x4007c8 <.text+0x508>
               	movl	$0x4, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x64, %r9d
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
               	movq	%r11, %r8
               	addq	%rdi, %r8
               	movzbq	(%r8), %rdi
               	movl	$0x1, %r8d
               	movq	%r8, %r11
               	shlq	$0x4, %r11
               	movq	%rdi, %r8
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	jne	0x40082d <.text+0x56d>
               	movl	$0x5, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x1, %r8d
               	movl	$0x8, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movzbq	(%rdi), %r9
               	movq	%r8, %rdi
               	shlq	$0x1, %rdi
               	movq	%r9, %r8
               	andq	%rdi, %r8
               	cmpq	$0x0, %r8
               	je	0x40088a <.text+0x5ca>
               	movl	$0x6, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r8
               	movl	$0x32, %edi
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %r9
               	addq	%r11, %r9
               	movzbq	(%r9), %r11
               	movl	$0x1, %r9d
               	movq	%r9, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %r9
               	andq	%r8, %r9
               	cmpq	$0x0, %r9
               	je	0x4008ee <.text+0x62e>
               	movl	$0x7, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movzbq	(%r9), %r8
               	movq	%r8, %r11
               	xorq	$0x81, %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40092f <.text+0x66f>
               	movl	$0xb, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movzbq	(%r11), %r8
               	movq	%r8, %r11
               	xorq	$0x1, %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x400976 <.text+0x6b6>
               	movl	$0xc, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movq	%r9, %r11
               	addq	$0xc, %r11
               	movzbq	(%r11), %r9
               	movq	%r9, %r11
               	xorq	$0x10, %r11
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4009bd <.text+0x6fd>
               	movl	$0xd, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x4009c2 <.text+0x702>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0xc8(%rbp)
               	movq	-0xc8(%rbp), %r9
               	movl	$0x7, %r11d
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movzbq	(%r8), %rdi
               	movl	$0x1, %r9d
               	movq	%r9, %r11
               	shlq	$0x7, %r11
               	movq	%r11, %r9
               	xorq	$-0x1, %r9
               	movq	%rdi, %r11
               	andq	%r9, %r11
               	movb	%r11b, (%r8)
               	jmp	0x400a21 <.text+0x761>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x4009c2 <.text+0x702>
               	leaq	-0x80(%rbp), %r9
               	movl	$0x7, %r11d
               	movl	$0x8, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movzbq	(%r8), %rdi
               	movl	$0x1, %r8d
               	movq	%r8, %r9
               	shlq	$0x7, %r9
               	movq	%rdi, %r8
               	andq	%r9, %r8
               	cmpq	$0x0, %r8
               	je	0x400a96 <.text+0x7d6>
               	movl	$0x15, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r8
               	xorq	%r9, %r9
               	movl	$0x8, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdi
               	addq	%r11, %rdi
               	movzbq	(%rdi), %r11
               	movq	%r11, %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x400aed <.text+0x82d>
               	movl	$0x16, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r11
               	movl	$0x8, %edi
               	movq	%rdi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movzbq	(%rdi), %r8
               	movq	%r8, %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x400b41 <.text+0x881>
               	movl	$0x17, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x400b46 <.text+0x886>
               	leaq	-0x80(%rbp), %r8
               	movq	%r8, -0xd0(%rbp)
               	movq	-0xd0(%rbp), %rdi
               	xorq	%r8, %r8
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%rdi, %r11
               	addq	%r9, %r11
               	movzbq	(%r11), %r9
               	movq	%r9, %rdi
               	orq	$0x1, %rdi
               	movb	%dil, (%r11)
               	jmp	0x400b8c <.text+0x8cc>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x400b46 <.text+0x886>
               	leaq	-0x80(%rbp), %r9
               	xorq	%rdi, %rdi
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movzbq	(%r11), %r8
               	movq	%r8, %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	jne	0x400bf2 <.text+0x932>
               	movl	$0x18, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x400bf7 <.text+0x937>
               	leaq	-0x80(%rbp), %r8
               	movq	%r8, -0xd8(%rbp)
               	xorq	%r11, %r11
               	movl	%r11d, -0xe0(%rbp)
               	jmp	0x400c66 <.text+0x9a6>
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	jne	0x400bf7 <.text+0x937>
               	leaq	-0x80(%rbp), %r11
               	xorq	%r8, %r8
               	movl	$0x8, %r9d
               	movq	%r9, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	movq	%r11, %r9
               	addq	%rdi, %r9
               	movzbq	(%r9), %rdi
               	movq	%rdi, %r9
               	andq	$0x1, %r9
               	cmpq	$0x0, %r9
               	je	0x400cd1 <.text+0xa11>
               	jmp	0x400cb9 <.text+0x9f9>
               	movslq	-0xe0(%rbp), %r11
               	cmpq	$0x80, %r11
               	jge	0x400cb4 <.text+0x9f4>
               	movq	-0xd8(%rbp), %r11
               	movslq	-0xe0(%rbp), %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	xorq	%r8, %r8
               	movb	%r8b, (%r9)
               	movslq	-0xe0(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0xe0(%rbp)
               	jmp	0x400c66 <.text+0x9a6>
               	jmp	0x400c11 <.text+0x951>
               	movl	$0x19, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r9
               	movl	$0x64, %edi
               	movl	$0x8, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movzbq	(%r11), %r8
               	movl	$0x1, %r11d
               	movq	%r11, %r9
               	shlq	$0x4, %r9
               	movq	%r8, %r11
               	andq	%r9, %r11
               	cmpq	$0x0, %r11
               	je	0x400d32 <.text+0xa72>
               	movl	$0x1a, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	0xf417(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400ead <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400d97 <.text+0xad7>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400e1e <.text+0xb5e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400e15 <.text+0xb55>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400e19 <.text+0xb59>
               	andb	%ch, 0x74(%rax)
               	je	0x400e29 <.text+0xb69>
               	jae	0x400df5 <.text+0xb35>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400e31 <.text+0xb71>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
		...
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400eb3 <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400e5b <.text+0xb9b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400ee2 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400ed9 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400edd <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x400eed <exit+0x3a>
               	jae	0x400eb9 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400ef5 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf233(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf235(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf237(%rip)           # 0x4100f0
