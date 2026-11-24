
atomic_rmw_ops.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	movq	$0xa, 0x8(%rsp)
               	leaq	0x8(%rsp), %rcx
               	movl	$0x5, %eax
               	lock
               	xaddq	%rax, (%rcx)
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x3, %edx
               	movq	%rdx, %rax
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xf0, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	cmpq	$0xc, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x5, %edx
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x8(%rsp), %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x6, %edx
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x63, %esi
               	movq	%rsi, %rax
               	xchgq	%rax, (%rcx)
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x7, %edi
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x63, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	addq	$0x28, %rsp
               	retq
               	movq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x64, %ecx
               	leaq	0x8(%rsp), %rsi
               	xorl	%edi, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	$0x64, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	cmovneq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	(%rsi), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x4, 0x10(%rsp)
               	leaq	0x10(%rsp), %rcx
               	movl	$0x1, %eax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x5, %esi
               	movq	$-0x1, %rdi
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rcx), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xc, 0x18(%rsp)
               	leaq	0x18(%rsp), %rcx
               	movl	$0xf0, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	0x18(%rsp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
