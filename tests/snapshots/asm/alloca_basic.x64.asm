
alloca_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400bb8 <.text+0x8b8>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100f8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfdce(%rip), %r9       # 0x410108
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40038b <.text+0x8b>
               	leaq	0xfdaa(%rip), %rdi      # 0x410108
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
               	leaq	0xfd87(%rip), %rdi      # 0x410120
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd75(%rip), %rsi      # 0x410126
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd64(%rip), %r9       # 0x41012d
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
               	callq	0x400f27 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40041c <.text+0x11c>
               	leaq	0xfd04(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40041c <.text+0x11c>
               	leaq	0xfce5(%rip), %r12      # 0x410108
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
               	subq	$0x2050, %rsp           # imm = 0x2050
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x20, %ebx
               	movq	%rbx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x28(%rbp), %r10
               	movq	(%r10), %r9
               	subq	%r11, %r9
               	movq	%r9, (%r10)
               	movq	%r9, -0x8(%rbp)
               	movq	-0x8(%rbp), %r12
               	movl	$0x55, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400f2d <memset>
               	movq	%rax, %rdi
               	xorq	%rdi, %rdi
               	movl	%edi, -0x10(%rbp)
               	jmp	0x4004bf <.text+0x1bf>
               	movslq	-0x10(%rbp), %rdi
               	cmpq	$0x20, %rdi
               	jge	0x400525 <.text+0x225>
               	jmp	0x4004ee <.text+0x1ee>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r14
               	movq	%r14, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rdi)
               	jmp	0x4004bf <.text+0x1bf>
               	movq	-0x8(%rbp), %r12
               	movslq	-0x10(%rbp), %r14
               	movq	%r12, %rdi
               	addq	%r14, %rdi
               	movzbq	(%rdi), %r14
               	movq	%r14, %rdi
               	xorq	$0x55, %rdi
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r14
               	cmpq	$0x0, %r14
               	je	0x400568 <.text+0x268>
               	jmp	0x400545 <.text+0x245>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	jmp	0x4004d5 <.text+0x1d5>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2020, %rsp           # imm = 0x2020
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %r11
               	movl	%r11d, 0x10(%rbp)
               	movslq	0x10(%rbp), %r9
               	movq	%r9, %r11
               	shlq	$0x2, %r11
               	movslq	%r11d, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x20(%rbp), %r10
               	movq	(%r10), %r9
               	subq	%r11, %r9
               	movq	%r9, (%r10)
               	movq	%r9, -0x8(%rbp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x18(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x4005d2 <.text+0x2d2>
               	movslq	-0x10(%rbp), %r11
               	movslq	0x10(%rbp), %r9
               	cmpq	%r9, %r11
               	jge	0x400638 <.text+0x338>
               	jmp	0x400601 <.text+0x301>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x4005d2 <.text+0x2d2>
               	movq	-0x8(%rbp), %r11
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %r9
               	shlq	$0x2, %r9
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movl	$0x7, %r9d
               	imulq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %r8
               	subq	$0x3, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%rdi)
               	jmp	0x4005e8 <.text+0x2e8>
               	xorq	%r8, %r8
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x400644 <.text+0x344>
               	movslq	-0x10(%rbp), %r8
               	movslq	0x10(%rbp), %r9
               	cmpq	%r9, %r8
               	jge	0x4006a0 <.text+0x3a0>
               	jmp	0x400673 <.text+0x373>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rdi
               	movq	%rdi, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	0x400644 <.text+0x344>
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %rdi
               	movq	-0x8(%rbp), %r9
               	movslq	-0x10(%rbp), %r11
               	movq	%r11, %rsi
               	shlq	$0x2, %rsi
               	movq	%r9, %r11
               	addq	%rsi, %r11
               	movslq	(%r11), %rsi
               	movq	%rdi, %r11
               	addq	%rsi, %r11
               	movl	%r11d, (%r8)
               	jmp	0x40065a <.text+0x35a>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2020, %rsp           # imm = 0x2020
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2060, %rsp           # imm = 0x2060
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x10, %r11d
               	movq	%r11, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %r9
               	subq	%r10, %r9
               	movq	%r9, (%rax)
               	movq	%r9, -0x8(%rbp)
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x30(%rbp), %r10
               	movq	(%r10), %r8
               	subq	%r11, %r8
               	movq	%r8, (%r10)
               	movq	%r8, -0x10(%rbp)
               	movq	-0x8(%rbp), %r11
               	movq	-0x10(%rbp), %r8
               	cmpq	%r8, %r11
               	jne	0x40075d <.text+0x45d>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rbx
               	movl	$0x41, %r12d
               	movl	$0x10, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400f2d <memset>
               	movq	%rax, %rdi
               	movq	-0x10(%rbp), %r15
               	movl	$0x42, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x400f2d <memset>
               	movq	%rax, %r12
               	movq	-0x8(%rbp), %r12
               	movzbq	(%r12), %rbx
               	movq	%rbx, %r12
               	xorq	$0x41, %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x2038(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x40081a <.text+0x51a>
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0xf, %r12
               	movzbq	(%r12), %rbx
               	movq	%rbx, %r12
               	xorq	$0x41, %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x2038(%rbp)
               	jmp	0x40081a <.text+0x51a>
               	movq	-0x2038(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400855 <.text+0x555>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r12
               	movzbq	(%r12), %rbx
               	movq	%rbx, %r12
               	xorq	$0x42, %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x2040(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4008d3 <.text+0x5d3>
               	movq	-0x10(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0xf, %r12
               	movzbq	(%r12), %rbx
               	movq	%rbx, %r12
               	xorq	$0x42, %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x2040(%rbp)
               	jmp	0x4008d3 <.text+0x5d3>
               	movq	-0x2040(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x40090e <.text+0x60e>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2020, %rsp           # imm = 0x2020
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %r11
               	movl	%r11d, 0x10(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	movl	%r9d, -0x10(%rbp)
               	jmp	0x40096b <.text+0x66b>
               	movslq	-0x10(%rbp), %r9
               	movslq	0x10(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	0x4009ec <.text+0x6ec>
               	jmp	0x40099a <.text+0x69a>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	0x40096b <.text+0x66b>
               	movl	$0x8, %r9d
               	movq	%r9, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x20(%rbp), %r10
               	movq	(%r10), %r8
               	subq	%r11, %r8
               	movq	%r8, (%r10)
               	movq	%r8, -0x18(%rbp)
               	movq	-0x18(%rbp), %r9
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, (%r9)
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	movq	-0x18(%rbp), %r9
               	movq	(%r9), %rdi
               	movslq	%edi, %rdi
               	movq	%r8, %r9
               	addq	%rdi, %r9
               	movl	%r9d, (%r11)
               	jmp	0x400981 <.text+0x681>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2020, %rsp           # imm = 0x2020
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2050, %rsp           # imm = 0x2050
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %r11
               	movl	%r11d, 0x10(%rbp)
               	movl	$0x40, %ebx
               	movq	%rbx, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %r11
               	subq	%r10, %r11
               	movq	%r11, (%rax)
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r12
               	movslq	0x10(%rbp), %r14
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400f2d <memset>
               	movq	%rax, %rdi
               	movl	$0x14, %r15d
               	movq	%r15, %rdi
               	callq	0x400933 <.text+0x633>
               	movq	%rax, %r14
               	movl	%r14d, -0x10(%rbp)
               	xorq	%r15, %r15
               	movl	%r15d, -0x18(%rbp)
               	jmp	0x400aa2 <.text+0x7a2>
               	movslq	-0x18(%rbp), %r15
               	cmpq	$0x40, %r15
               	jge	0x400aff <.text+0x7ff>
               	jmp	0x400ad1 <.text+0x7d1>
               	leaq	-0x18(%rbp), %r15
               	movslq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%r15)
               	jmp	0x400aa2 <.text+0x7a2>
               	movq	-0x8(%rbp), %r12
               	movslq	-0x18(%rbp), %r14
               	movq	%r12, %r15
               	addq	%r14, %r15
               	movzbq	(%r15), %r14
               	movslq	0x10(%rbp), %r15
               	movq	%r15, %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %r14
               	je	0x400b4c <.text+0x84c>
               	jmp	0x400b15 <.text+0x815>
               	movslq	-0x10(%rbp), %r15
               	cmpq	$0xbe, %r15
               	je	0x400b88 <.text+0x888>
               	jmp	0x400b51 <.text+0x851>
               	movabsq	$-0x1, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	jmp	0x400ab8 <.text+0x7b8>
               	movabsq	$-0x2, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	callq	0x400450 <.text+0x150>
               	movq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x400c2a <.text+0x92a>
               	leaq	0xf566(%rip), %rbx      # 0x410158
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400f33 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r12d
               	movq	%r12, %rdi
               	callq	0x40056d <.text+0x26d>
               	movq	%rax, %r9
               	cmpq	$0x11d, %r9             # imm = 0x11D
               	je	0x400c9b <.text+0x99b>
               	leaq	0xf516(%rip), %rbx      # 0x410165
               	movl	$0xa, %r14d
               	movq	%r14, %rdi
               	callq	0x40056d <.text+0x26d>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f33 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x4006b8 <.text+0x3b8>
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	je	0x400cef <.text+0x9ef>
               	leaq	0xf4c0(%rip), %r14      # 0x410177
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x400f33 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x3, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x32, %r12d
               	movq	%r12, %rdi
               	callq	0x400933 <.text+0x633>
               	movq	%rax, %r15
               	cmpq	$0x4c9, %r15            # imm = 0x4C9
               	je	0x400d60 <.text+0xa60>
               	leaq	0xf472(%rip), %r14      # 0x410186
               	movl	$0x32, %r15d
               	movq	%r15, %rdi
               	callq	0x400933 <.text+0x633>
               	movq	%rax, %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400f33 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x4, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x33, %ebx
               	movq	%rbx, %rdi
               	callq	0x400a04 <.text+0x704>
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x400dbb <.text+0xabb>
               	leaq	0xf413(%rip), %r12      # 0x410197
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x400f33 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
