
atomic_op_fetch.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	$0xa, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	lock
               	xaddl	%eax, (%rcx)
               	addq	$0x5, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x3, %edx
               	movq	%rdx, %rax
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	subq	$0x3, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0xf, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	andq	%rdi, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	orq	%rdi, %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	%rdx, %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movq	%rsi, %rax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	$0x64, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x7, %eax
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%rcx)
               	addq	$0x7, %rdx
               	cmpq	$0x6b, %rdx
               	je	<addr>
               	leave
               	retq
               	movl	$0xa, %eax
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	subq	$0xa, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
