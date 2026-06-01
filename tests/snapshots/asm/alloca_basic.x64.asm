
alloca_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
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
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
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
               	callq	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x20, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r14
               	movslq	(%r14), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r14)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	movslq	-0x10(%rbp), %r12
               	addq	%r12, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x55, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	jmp	<addr>
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
               	shlq	$0x2, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r11
               	subq	%r10, %r11
               	movq	%r11, (%rax)
               	movq	%r11, -0x8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x18(%rbp)
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	movslq	0x10(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r9
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %r11
               	shlq	$0x2, %r11
               	addq	%r11, %r9
               	movl	$0x7, %r11d
               	imulq	%r11, %r8
               	movslq	%r8d, %r8
               	subq	$0x3, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	movslq	0x10(%rbp), %r11
               	cmpq	%r11, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	-0x8(%rbp), %r11
               	movslq	-0x10(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r11
               	movslq	(%r11), %r11
               	addq	%r11, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
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
               	jne	<addr>
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
               	callq	<addr>
               	movq	-0x10(%rbp), %r15
               	movl	$0x42, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x41, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2038(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rbx
               	addq	$0xf, %rbx
               	movzbq	(%rbx), %rbx
               	xorq	$0x41, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x2038(%rbp)
               	jmp	<addr>
               	movq	-0x2038(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	$0x42, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x2040(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	addq	$0xf, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x42, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	jmp	<addr>
               	movq	-0x2040(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
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
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	movslq	0x10(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
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
               	movq	(%r9), %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
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
               	callq	<addr>
               	movl	$0x14, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	xorq	%r15, %r15
               	movl	%r15d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r15
               	cmpq	$0x40, %r15
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %r15
               	addq	$0x1, %r15
               	movl	%r15d, (%rax)
               	jmp	<addr>
               	movq	-0x8(%rbp), %r15
               	movslq	-0x18(%rbp), %r12
               	addq	%r12, %r15
               	movzbq	(%r15), %r15
               	movslq	0x10(%rbp), %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %r15
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r15
               	cmpq	$0xbe, %r15
               	je	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
               	movabsq	$-0x2, %r12
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
               	xorq	%r15, %r15
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
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
               	callq	<addr>
               	cmpq	$0x11d, %rax            # imm = 0x11D
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xa, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	<addr>
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
               	movl	$0x32, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x4c9, %rax            # imm = 0x4C9
               	je	<addr>
               	leaq	<rip>, %r14
               	movl	$0x32, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
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
               	movl	$0x33, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	<addr>
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
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
