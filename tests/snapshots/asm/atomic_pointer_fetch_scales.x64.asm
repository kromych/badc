
atomic_pointer_fetch_scales.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x4, %edx
               	lock
               	xaddq	%rdx, (%rcx)
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	(%rcx), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x4, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x8, %edx
               	movq	%rdx, %r10
               	lock
               	xaddq	%r10, (%rcx)
               	movq	(%rcx), %rcx
               	addq	$0xc, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, %rsi
               	negq	%rsi
               	lock
               	xaddq	%rsi, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0xc(%rcx), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	(%rax), %rsi
               	leaq	0x8(%rcx), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	%rdx, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rax)
               	movq	(%rax), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	$0x48, %ecx
               	movq	%rcx, %r10
               	lock
               	xaddq	%r10, (%rax)
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x48, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x2, %ecx
               	lock
               	xaddl	%ecx, (%rax)
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x4, %eax
               	movq	%rax, %r10
               	lock
               	xaddq	%r10, (%rcx)
               	movq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rcx # <addr>
               	subq	%rcx, %rdx
               	cmpq	$0x4, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	(%rdx), %rax
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
