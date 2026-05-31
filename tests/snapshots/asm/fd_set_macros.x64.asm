
fd_set_macros.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40040d <.text+0x14d>
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
               	callq	0x400e97 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003d9 <.text+0x119>
               	leaq	0xfd3f(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003d9 <.text+0x119>
               	leaq	0xfd20(%rip), %r12      # 0x410100
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
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
               	jmp	0x400421 <.text+0x161>
               	leaq	-0x80(%rbp), %r11
               	movq	%r11, -0x88(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x90(%rbp)
               	jmp	0x40045a <.text+0x19a>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x400421 <.text+0x161>
               	xorq	%r9, %r9
               	movl	%r9d, -0x98(%rbp)
               	jmp	0x4004ad <.text+0x1ed>
               	movslq	-0x90(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	0x4004a8 <.text+0x1e8>
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
               	jmp	0x40045a <.text+0x19a>
               	jmp	0x40043b <.text+0x17b>
               	movslq	-0x98(%rbp), %r9
               	cmpq	$0x80, %r9
               	jge	0x4004f1 <.text+0x231>
               	leaq	-0x80(%rbp), %r9
               	movslq	-0x98(%rbp), %r11
               	movq	%r9, %r8
               	addq	%r11, %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	0x40050f <.text+0x24f>
               	jmp	0x4004f6 <.text+0x236>
               	jmp	0x40052f <.text+0x26f>
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
               	jmp	0x4004ad <.text+0x1ed>
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
               	jmp	0x400578 <.text+0x2b8>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x40052f <.text+0x26f>
               	jmp	0x40058d <.text+0x2cd>
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
               	jmp	0x4005e1 <.text+0x321>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x40058d <.text+0x2cd>
               	jmp	0x4005f6 <.text+0x336>
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
               	jmp	0x40063b <.text+0x37b>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x4005f6 <.text+0x336>
               	jmp	0x400650 <.text+0x390>
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
               	jmp	0x4006a4 <.text+0x3e4>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x400650 <.text+0x390>
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
               	jne	0x40070b <.text+0x44b>
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
               	jne	0x40076f <.text+0x4af>
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
               	jne	0x4007c5 <.text+0x505>
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
               	jne	0x40082a <.text+0x56a>
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
               	je	0x400887 <.text+0x5c7>
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
               	je	0x4008eb <.text+0x62b>
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
               	je	0x40092c <.text+0x66c>
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
               	je	0x400973 <.text+0x6b3>
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
               	je	0x4009ba <.text+0x6fa>
               	movl	$0xd, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x4009bf <.text+0x6ff>
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
               	jmp	0x400a1e <.text+0x75e>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	jne	0x4009bf <.text+0x6ff>
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
               	je	0x400a93 <.text+0x7d3>
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
               	jne	0x400aea <.text+0x82a>
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
               	jne	0x400b3e <.text+0x87e>
               	movl	$0x17, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x400b43 <.text+0x883>
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
               	jmp	0x400b89 <.text+0x8c9>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x400b43 <.text+0x883>
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
               	jne	0x400bef <.text+0x92f>
               	movl	$0x18, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	0x400bf4 <.text+0x934>
               	leaq	-0x80(%rbp), %r8
               	movq	%r8, -0xd8(%rbp)
               	xorq	%r11, %r11
               	movl	%r11d, -0xe0(%rbp)
               	jmp	0x400c63 <.text+0x9a3>
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	jne	0x400bf4 <.text+0x934>
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
               	je	0x400cce <.text+0xa0e>
               	jmp	0x400cb6 <.text+0x9f6>
               	movslq	-0xe0(%rbp), %r11
               	cmpq	$0x80, %r11
               	jge	0x400cb1 <.text+0x9f1>
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
               	jmp	0x400c63 <.text+0x9a3>
               	jmp	0x400c0e <.text+0x94e>
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
               	je	0x400d2f <.text+0xa6f>
               	movl	$0x1a, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	leaq	0xf41a(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400e9d <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
