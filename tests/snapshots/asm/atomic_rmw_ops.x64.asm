
atomic_rmw_ops.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movq	$0xa, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x5, %edx
               	movq	%rdx, %rax
               	lock
               	xaddq	%rax, (%rcx)
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x3, %esi
               	movq	%rsi, %rax
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0xf0, %edi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	cmpq	$0xc, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x18(%rbp)
               	je	<addr>
               	movq	%rsi, %rax
               	leave
               	retq
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
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
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x63, %esi
               	movq	%rsi, %rax
               	xchgq	%rax, (%rcx)
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	leaq	-0x18(%rbp), %r8
               	movl	$0x7, %ecx
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rcx, (%r8)
               	cmpq	$0x63, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x64, %ecx
               	xorl	%esi, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%r8)
               	cmpq	$0x64, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x4, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x1, %eax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0x5, %r8d
               	movq	$-0x1, %r9
               	movl	%r8d, %eax
               	lock
               	cmpxchgl	%r9d, (%rcx)
               	cmpl	$0x5, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0xc, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%r8, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	%rsi, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
