
atomic_int128_operations.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x228, %rsp            # imm = 0x228
               	movl	$0x1, %edx
               	movq	<rip>, %rax # <addr>
               	leaq	(%rsp), %rsi
               	movq	$0x0, (%rsp)
               	movq	$0x0, 0x8(%rsp)
               	leaq	0xd0(%rsp), %r8
               	movq	$0x5, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	movq	%rsi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%r8, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rcx, -0x58(%rsp)
               	movq	%rdx, -0x60(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x60(%rsp), %rdx
               	movq	-0x58(%rsp), %rcx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	movq	(%rsp), %rdi
               	movq	0x8(%rsp), %r8
               	orq	%r8, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	$0x3, (%rsp)
               	movq	$0x0, 0x8(%rsp)
               	leaq	0xe0(%rsp), %r8
               	movq	$0x9, 0xe0(%rsp)
               	movq	$0x0, 0xe8(%rsp)
               	movq	%rsi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%r8, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rdx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rdx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rsi
               	xorq	$0x5, %rcx
               	xorq	$0x1, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	leaq	0xf0(%rsp), %rdi
               	movq	%rcx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	leaq	0x30(%rsp), %r8
               	movq	0xf0(%rsp), %rcx
               	movq	0xf8(%rsp), %rsi
               	cmpq	$0x6, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	subq	$0x6, %rcx
               	subq	%r9, %rsi
               	movq	%rcx, 0x30(%rsp)
               	movq	%rsi, 0x38(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%r8, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rdx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rdx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0xf0(%rsp), %rcx
               	movq	0xf8(%rsp), %rsi
               	xorq	$0x5, %rcx
               	xorq	$0x1, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x100(%rsp), %rsi
               	movq	$0x0, 0x100(%rsp)
               	movq	$0x0, 0x108(%rsp)
               	leaq	0x110(%rsp), %rdi
               	movq	$0x0, 0x110(%rsp)
               	movq	$0x0, 0x118(%rsp)
               	movq	%rsi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rdx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rdx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	0x100(%rsp), %rcx
               	movq	0x108(%rsp), %rsi
               	xorq	$-0x1, %rcx
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	leaq	0x120(%rsp), %rdi
               	movq	%rcx, 0x120(%rsp)
               	movq	%rsi, 0x128(%rsp)
               	leaq	0x40(%rsp), %r8
               	movq	0x120(%rsp), %rcx
               	movq	0x128(%rsp), %r9
               	leaq	0x1(%rcx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%r9, %rcx
               	movq	%rsi, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%r8, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rdx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rdx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	nopl	(%rax,%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x40(%rsp), %rsi
               	movq	0x48(%rsp), %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	(%rax), %r8
               	movq	0x8(%rax), %r9
               	leaq	0x130(%rsp), %rdi
               	movq	%r8, 0x130(%rsp)
               	movq	%r9, 0x138(%rsp)
               	leaq	0x50(%rsp), %r8
               	movq	%rcx, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%r8, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rcx, -0x58(%rsp)
               	movq	%rdx, -0x60(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x60(%rsp), %rdx
               	movq	-0x58(%rsp), %rcx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %r9
               	testq	%r9, %r9
               	je	<addr>
               	movq	0x130(%rsp), %rsi
               	movq	0x138(%rsp), %rcx
               	xorq	%rdx, %rcx
               	orq	%rcx, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	xorq	%rdi, %rcx
               	xorq	%r8, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	leaq	0x140(%rsp), %rdi
               	movq	%rcx, 0x140(%rsp)
               	movq	%rsi, 0x148(%rsp)
               	leaq	0x60(%rsp), %r8
               	movq	0x140(%rsp), %rcx
               	movq	0x148(%rsp), %rsi
               	andq	$0x7, %rcx
               	andq	%rdx, %rsi
               	movq	%rcx, 0x60(%rsp)
               	movq	%rsi, 0x68(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%r8, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rdx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rdx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	nopl	(%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x140(%rsp), %rcx
               	movq	0x148(%rsp), %rdx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	xorq	%rsi, %rcx
               	xorq	%rdi, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	xorq	$0x5, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	leaq	0x150(%rsp), %rdx
               	movq	%rcx, 0x150(%rsp)
               	movq	%rsi, 0x158(%rsp)
               	movabsq	$0x1800000000, %rsi     # imm = 0x1800000000
               	leaq	0x70(%rsp), %rdi
               	movq	0x150(%rsp), %r8
               	movq	0x158(%rsp), %rcx
               	orq	%rsi, %rcx
               	movq	%r8, 0x70(%rsp)
               	movq	%rcx, 0x78(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rdx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rdx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	nop
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x70(%rsp), %rcx
               	movq	0x78(%rsp), %rdx
               	xorq	$0x5, %rcx
               	movabsq	$0x1800000000, %r11     # imm = 0x1800000000
               	xorq	%r11, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	leaq	0x160(%rsp), %rdx
               	movq	%rcx, 0x160(%rsp)
               	movq	%rsi, 0x168(%rsp)
               	movabsq	$0x800000000, %rsi      # imm = 0x800000000
               	leaq	0x80(%rsp), %rdi
               	movq	0x160(%rsp), %r8
               	movq	0x168(%rsp), %rcx
               	xorq	%rsi, %rcx
               	movq	%r8, 0x80(%rsp)
               	movq	%rcx, 0x88(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rdx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rdx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x80(%rsp), %rcx
               	movq	0x88(%rsp), %rdx
               	xorq	$0x5, %rcx
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	xorq	%r11, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %r8
               	leaq	0x170(%rsp), %rsi
               	movq	%rdi, 0x170(%rsp)
               	movq	%r8, 0x178(%rsp)
               	leaq	0x90(%rsp), %rdi
               	movq	$0x2a, 0x90(%rsp)
               	movq	$0x0, 0x98(%rsp)
               	movq	%rsi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rcx, -0x58(%rsp)
               	movq	%rdx, -0x60(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x60(%rsp), %rdx
               	movq	-0x58(%rsp), %rcx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x2a, %esi
               	leaq	0x180(%rsp), %rdx
               	movq	%rsi, 0x180(%rsp)
               	movq	$0x0, 0x188(%rsp)
               	leaq	0x190(%rsp), %r8
               	movq	$0x2b, 0x190(%rsp)
               	movq	$0x0, 0x198(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%r8, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rcx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rcx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	0x180(%rsp), %rdx
               	movq	0x188(%rsp), %rdi
               	xorq	%rsi, %rdx
               	orq	%rdi, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1a0(%rsp), %rsi
               	movq	$0x1, 0x1a0(%rsp)
               	movq	$0x0, 0x1a8(%rsp)
               	leaq	0x1b0(%rsp), %rdi
               	movq	$0x2, 0x1b0(%rsp)
               	movq	$0x0, 0x1b8(%rsp)
               	movq	%rsi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	xorq	$0x2b, %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	0x1c0(%rsp), %rdx
               	movq	%rsi, 0x1c0(%rsp)
               	movq	%rdi, 0x1c8(%rsp)
               	leaq	0xa0(%rsp), %rsi
               	movq	$-0x1, 0xa0(%rsp)
               	movq	$-0x1, 0xa8(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rsi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rcx, -0x58(%rsp)
               	movq	%rdx, -0x60(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x60(%rsp), %rdx
               	movq	-0x58(%rsp), %rcx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rdi
               	nopl	(%rax)
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	0x10(%rsp), %rdx
               	movq	$0x0, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	leaq	0x1d0(%rsp), %rsi
               	movq	$0x0, 0x1d0(%rsp)
               	movq	$0x0, 0x1d8(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rsi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	0x10(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	0x1e0(%rsp), %rsi
               	movq	%rcx, 0x1e0(%rsp)
               	movq	%rdx, 0x1e8(%rsp)
               	leaq	0xb0(%rsp), %rdi
               	movq	0x1e0(%rsp), %rcx
               	movq	0x1e8(%rsp), %r8
               	leaq	0x1(%rcx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%r8, %rcx
               	movq	%rdx, 0xb0(%rsp)
               	movq	%rcx, 0xb8(%rsp)
               	movq	%rsi, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rdi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x1e0(%rsp), %rcx
               	movq	0x1e8(%rsp), %rdx
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	leaq	0x20(%rsp), %rdx
               	movq	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	leaq	0x1f0(%rsp), %rcx
               	movq	%rsi, 0x1f0(%rsp)
               	movq	%rdi, 0x1f8(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rcx, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rdx, -0x58(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x58(%rsp), %rdx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %r8 # <addr>
               	movq	<rip>, %r9 # <addr>
               	movq	<rip>, %r10 # <addr>
               	xorq	%r9, %rcx
               	xorq	%r10, %r8
               	orq	%r8, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	leaq	0x200(%rsp), %rcx
               	movq	%rsi, 0x200(%rsp)
               	movq	%rdi, 0x208(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rcx, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	xorq	%rsi, %rcx
               	xorq	%rdi, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	0x210(%rsp), %rdx
               	movq	%rsi, 0x210(%rsp)
               	movq	%rdi, 0x218(%rsp)
               	leaq	0xc0(%rsp), %rsi
               	movq	$0x1, 0xc0(%rsp)
               	movq	$0x1, 0xc8(%rsp)
               	movq	%rdx, %r10
               	movq	%r10, -0x40(%rsp)
               	movq	%rsi, %r10
               	movq	%rax, %r11
               	movq	%rbx, -0x48(%rsp)
               	movq	%rax, -0x50(%rsp)
               	movq	%rcx, -0x58(%rsp)
               	movq	%rdx, -0x60(%rsp)
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	-0x40(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	movq	-0x60(%rsp), %rdx
               	movq	-0x58(%rsp), %rcx
               	movq	-0x50(%rsp), %rax
               	movq	-0x48(%rsp), %rbx
               	movq	%r10, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	0x210(%rsp), %rax
               	movq	0x218(%rsp), %rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	xorq	%rdx, %rax
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	xorq	$0x1, %rax
               	xorq	$0x1, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
               	xorl	%eax, %eax
               	addq	$0x228, %rsp            # imm = 0x228
               	retq
