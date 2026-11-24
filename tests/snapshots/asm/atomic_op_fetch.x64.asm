
atomic_op_fetch.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0xa, 0x8(%rsp)
               	leaq	0x8(%rsp), %rcx
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	lock
               	xaddl	%eax, (%rcx)
               	addq	$0x5, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
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
               	addq	$0x18, %rsp
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
               	addq	$0x18, %rsp
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
               	addq	$0x18, %rsp
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
               	addq	$0x18, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$0x64, (%rsp)
               	leaq	(%rsp), %rcx
               	movl	$0x7, %eax
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%rcx)
               	addq	$0x7, %rdx
               	cmpq	$0x6b, %rdx
               	je	<addr>
               	addq	$0x18, %rsp
               	retq
               	movl	$0xa, %eax
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	subq	$0xa, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	(%rsp), %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
