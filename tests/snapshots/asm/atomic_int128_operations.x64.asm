
atomic_int128_operations.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1d0, %rsp            # imm = 0x1D0
               	movl	$0x1, %esi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	-0x1d0(%rbp), %rdx
               	movq	$0x0, -0x1d0(%rbp)
               	movq	$0x0, -0x1c8(%rbp)
               	leaq	-0x120(%rbp), %rdi
               	movq	$0x5, -0x120(%rbp)
               	movq	%rsi, -0x118(%rbp)
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	-0x1d0(%rbp), %rcx
               	movq	-0x1c8(%rbp), %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	$0x3, -0x1d0(%rbp)
               	movq	$0x0, -0x1c8(%rbp)
               	leaq	-0x1d0(%rbp), %rdx
               	leaq	-0x110(%rbp), %r8
               	movq	$0x9, -0x110(%rbp)
               	movq	$0x0, -0x108(%rbp)
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x1d0(%rbp), %rcx
               	movq	-0x1c8(%rbp), %rdx
               	xorq	$0x5, %rcx
               	xorq	$0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdi
               	leaq	-0x100(%rbp), %rdx
               	movq	%rcx, -0x100(%rbp)
               	movq	%rdi, -0xf8(%rbp)
               	leaq	-0x1b0(%rbp), %rdi
               	movq	-0x100(%rbp), %rcx
               	movq	-0xf8(%rbp), %r8
               	cmpq	$0x6, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x6, %rcx
               	subq	%r9, %r8
               	movq	%rcx, -0x1b0(%rbp)
               	movq	%r8, -0x1a8(%rbp)
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x18(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x100(%rbp), %rcx
               	movq	-0xf8(%rbp), %rdx
               	xorq	$0x5, %rcx
               	xorq	$0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xf0(%rbp), %rdx
               	movq	$0x0, -0xf0(%rbp)
               	movq	$0x0, -0xe8(%rbp)
               	leaq	-0xe0(%rbp), %rdi
               	movq	$0x0, -0xe0(%rbp)
               	movq	$0x0, -0xd8(%rbp)
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	-0xf0(%rbp), %rcx
               	movq	-0xe8(%rbp), %rdx
               	xorq	$-0x1, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0xd0(%rbp), %rdi
               	movq	%rcx, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	leaq	-0x1a0(%rbp), %r8
               	movq	-0xd0(%rbp), %rcx
               	movq	-0xc8(%rbp), %r9
               	leaq	0x1(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%r9, %rcx
               	movq	%rdx, -0x1a0(%rbp)
               	movq	%rcx, -0x198(%rbp)
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x1a0(%rbp), %rcx
               	movq	-0x198(%rbp), %rdx
               	xorq	%rsi, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rdx), %rcx
               	movq	0x8(%rdx), %rdx
               	movq	(%rax), %r8
               	movq	0x8(%rax), %r9
               	leaq	-0xc0(%rbp), %rdi
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	leaq	-0x190(%rbp), %r8
               	movq	%rcx, -0x190(%rbp)
               	movq	%rdx, -0x188(%rbp)
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	-0xc0(%rbp), %rcx
               	movq	-0xb8(%rbp), %rdx
               	xorq	%rsi, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rdi
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r8
               	movq	0x8(%rcx), %rcx
               	xorq	%r8, %rdx
               	xorq	%rdi, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rdi
               	leaq	-0xb0(%rbp), %rcx
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rdi, -0xa8(%rbp)
               	leaq	-0x180(%rbp), %rdx
               	movq	-0xb0(%rbp), %rdi
               	movq	-0xa8(%rbp), %r8
               	andq	$0x7, %rdi
               	andq	%rsi, %r8
               	movq	%rdi, -0x180(%rbp)
               	movq	%r8, -0x178(%rbp)
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	-0xb0(%rbp), %rdx
               	movq	-0xa8(%rbp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rdi
               	movq	0x8(%rcx), %rcx
               	xorq	%rdi, %rdx
               	xorq	%rsi, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	xorq	$0x5, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rsi
               	leaq	-0xa0(%rbp), %rcx
               	movq	%rdx, -0xa0(%rbp)
               	movq	%rsi, -0x98(%rbp)
               	movabsq	$0x1800000000, %rdx     # imm = 0x1800000000
               	leaq	-0x170(%rbp), %rsi
               	movq	-0xa0(%rbp), %rdi
               	movq	-0x98(%rbp), %r8
               	orq	%rdx, %r8
               	movq	%rdi, -0x170(%rbp)
               	movq	%r8, -0x168(%rbp)
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	-0x170(%rbp), %rcx
               	movq	-0x168(%rbp), %rdx
               	xorq	$0x5, %rcx
               	movabsq	$0x1800000000, %r11     # imm = 0x1800000000
               	xorq	%r11, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rsi
               	leaq	-0x90(%rbp), %rcx
               	movq	%rdx, -0x90(%rbp)
               	movq	%rsi, -0x88(%rbp)
               	movabsq	$0x800000000, %rdx      # imm = 0x800000000
               	leaq	-0x160(%rbp), %rsi
               	movq	-0x90(%rbp), %rdi
               	movq	-0x88(%rbp), %r8
               	xorq	%rdx, %r8
               	movq	%rdi, -0x160(%rbp)
               	movq	%r8, -0x158(%rbp)
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	-0x160(%rbp), %rcx
               	movq	-0x158(%rbp), %rdx
               	xorq	$0x5, %rcx
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	xorq	%r11, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %r8
               	leaq	-0x80(%rbp), %rsi
               	movq	%rdi, -0x80(%rbp)
               	movq	%r8, -0x78(%rbp)
               	leaq	-0x150(%rbp), %rdi
               	movq	$0x2a, -0x150(%rbp)
               	movq	$0x0, -0x148(%rbp)
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x2a, %edx
               	leaq	-0x70(%rbp), %rsi
               	movq	%rdx, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	leaq	-0x60(%rbp), %r8
               	movq	$0x2b, -0x60(%rbp)
               	movq	$0x0, -0x58(%rbp)
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	-0x70(%rbp), %rsi
               	movq	-0x68(%rbp), %rdi
               	xorq	%rsi, %rdx
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rsi
               	movq	$0x1, -0x50(%rbp)
               	movq	$0x0, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	movq	$0x2, -0x40(%rbp)
               	movq	$0x0, -0x38(%rbp)
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	xorq	$0x2b, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x30(%rbp), %rdx
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdi, -0x28(%rbp)
               	leaq	-0x140(%rbp), %rsi
               	movq	$-0x1, -0x140(%rbp)
               	movq	$-0x1, -0x138(%rbp)
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-0x1c0(%rbp), %rdx
               	movq	$0x0, -0x1c0(%rbp)
               	movq	$0x0, -0x1b8(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movq	$0x0, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	-0x1c0(%rbp), %rcx
               	movq	-0x1b8(%rbp), %rdx
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x10(%rbp), %rsi
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x130(%rbp), %rdi
               	movq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %r8
               	leaq	0x1(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%r8, %rcx
               	movq	%rdx, -0x130(%rbp)
               	movq	%rcx, -0x128(%rbp)
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
