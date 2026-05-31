
alloca_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400ba1 <.text+0x8a1>
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
               	callq	0x400ee7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400419 <.text+0x119>
               	leaq	0xfd07(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400419 <.text+0x119>
               	leaq	0xfce8(%rip), %r12      # 0x410108
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
               	callq	0x400eed <memset>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x4004b9 <.text+0x1b9>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x20, %rax
               	jge	0x40051f <.text+0x21f>
               	jmp	0x4004e8 <.text+0x1e8>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r14
               	movq	%r14, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rax)
               	jmp	0x4004b9 <.text+0x1b9>
               	movq	-0x8(%rbp), %r12
               	movslq	-0x10(%rbp), %r14
               	movq	%r12, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %r14
               	movq	%r14, %rax
               	xorq	$0x55, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	cmpq	$0x0, %r14
               	je	0x400562 <.text+0x262>
               	jmp	0x40053f <.text+0x23f>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
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
               	jmp	0x4004cf <.text+0x1cf>
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
               	jmp	0x4005cc <.text+0x2cc>
               	movslq	-0x10(%rbp), %r11
               	movslq	0x10(%rbp), %r9
               	cmpq	%r9, %r11
               	jge	0x400632 <.text+0x332>
               	jmp	0x4005fb <.text+0x2fb>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x4005cc <.text+0x2cc>
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
               	jmp	0x4005e2 <.text+0x2e2>
               	xorq	%r8, %r8
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x40063e <.text+0x33e>
               	movslq	-0x10(%rbp), %r8
               	movslq	0x10(%rbp), %r9
               	cmpq	%r9, %r8
               	jge	0x40069a <.text+0x39a>
               	jmp	0x40066d <.text+0x36d>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rdi
               	movq	%rdi, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	0x40063e <.text+0x33e>
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
               	jmp	0x400654 <.text+0x354>
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
               	jne	0x400757 <.text+0x457>
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
               	callq	0x400eed <memset>
               	movq	-0x10(%rbp), %r15
               	movl	$0x42, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x400eed <memset>
               	movq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rbx
               	movq	%rbx, %rax
               	xorq	$0x41, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2038(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40080c <.text+0x50c>
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0xf, %rax
               	movzbq	(%rax), %rbx
               	movq	%rbx, %rax
               	xorq	$0x41, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2038(%rbp)
               	jmp	0x40080c <.text+0x50c>
               	movq	-0x2038(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400847 <.text+0x547>
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
               	movq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rbx
               	movq	%rbx, %rax
               	xorq	$0x42, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4008c3 <.text+0x5c3>
               	movq	-0x10(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0xf, %rax
               	movzbq	(%rax), %rbx
               	movq	%rbx, %rax
               	xorq	$0x42, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	jmp	0x4008c3 <.text+0x5c3>
               	movq	-0x2040(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4008fe <.text+0x5fe>
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
               	xorq	%rax, %rax
               	movq	%rax, %rcx
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
               	jmp	0x40095b <.text+0x65b>
               	movslq	-0x10(%rbp), %r9
               	movslq	0x10(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	0x4009dc <.text+0x6dc>
               	jmp	0x40098a <.text+0x68a>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	0x40095b <.text+0x65b>
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
               	jmp	0x400971 <.text+0x671>
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
               	callq	0x400eed <memset>
               	movl	$0x14, %r15d
               	movq	%r15, %rdi
               	callq	0x400923 <.text+0x623>
               	movl	%eax, -0x10(%rbp)
               	xorq	%r15, %r15
               	movl	%r15d, -0x18(%rbp)
               	jmp	0x400a8b <.text+0x78b>
               	movslq	-0x18(%rbp), %r15
               	cmpq	$0x40, %r15
               	jge	0x400ae8 <.text+0x7e8>
               	jmp	0x400aba <.text+0x7ba>
               	leaq	-0x18(%rbp), %r15
               	movslq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%r15)
               	jmp	0x400a8b <.text+0x78b>
               	movq	-0x8(%rbp), %r12
               	movslq	-0x18(%rbp), %rax
               	movq	%r12, %r15
               	addq	%rax, %r15
               	movzbq	(%r15), %rax
               	movslq	0x10(%rbp), %r15
               	movq	%r15, %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %rax
               	je	0x400b35 <.text+0x835>
               	jmp	0x400afe <.text+0x7fe>
               	movslq	-0x10(%rbp), %r15
               	cmpq	$0xbe, %r15
               	je	0x400b71 <.text+0x871>
               	jmp	0x400b3a <.text+0x83a>
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
               	jmp	0x400aa1 <.text+0x7a1>
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
               	callq	0x40044d <.text+0x14d>
               	cmpq	$0x0, %rax
               	je	0x400c0c <.text+0x90c>
               	leaq	0xf580(%rip), %rbx      # 0x410158
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400ef3 <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
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
               	callq	0x400567 <.text+0x267>
               	cmpq	$0x11d, %rax            # imm = 0x11D
               	je	0x400c77 <.text+0x977>
               	leaq	0xf537(%rip), %rbx      # 0x410165
               	movl	$0xa, %r14d
               	movq	%r14, %rdi
               	callq	0x400567 <.text+0x267>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x400ef3 <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x4006b2 <.text+0x3b2>
               	cmpq	$0x0, %rax
               	je	0x400cc4 <.text+0x9c4>
               	leaq	0xf4e7(%rip), %r12      # 0x410177
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x400ef3 <printf>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x32, %r14d
               	movq	%r14, %rdi
               	callq	0x400923 <.text+0x623>
               	cmpq	$0x4c9, %rax            # imm = 0x4C9
               	je	0x400d2e <.text+0xa2e>
               	leaq	0xf4a0(%rip), %r12      # 0x410186
               	movl	$0x32, %r15d
               	movq	%r15, %rdi
               	callq	0x400923 <.text+0x623>
               	movq	%rax, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400ef3 <printf>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x33, %r15d
               	movq	%r15, %rdi
               	callq	0x4009f4 <.text+0x6f4>
               	cmpq	$0x0, %rax
               	je	0x400d84 <.text+0xa84>
               	leaq	0xf447(%rip), %r14      # 0x410197
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x400ef3 <printf>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
