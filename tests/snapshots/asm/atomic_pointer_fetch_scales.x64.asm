
atomic_pointer_fetch_scales.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movl	$0x5, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movl	$0x4, %edx
               	movq	%rdx, %rsi
               	lock
               	xaddq	%rsi, (%rcx)
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	(%rcx), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x4, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	lock
               	addq	$0x8, (%rcx)
               	movq	(%rcx), %rsi
               	addq	$0xc, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rdx, %rax
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	leaq	0xc(%rcx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movq	(%rax), %rdx
               	leaq	0x8(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	lock
               	subq	$0x8, (%rax)
               	movq	(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x8(%rsp), %rdx
               	lock
               	addq	$0x48, (%rdx)
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rsi # <addr>
               	addq	$0x48, %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x18(%rsp), %rdx
               	movl	$0x2, %esi
               	lock
               	xaddl	%esi, (%rdx)
               	cmpl	$0x5, %esi
               	jne	<addr>
               	movl	$0x1, %esi
               	negq	%rsi
               	lock
               	xaddl	%esi, (%rdx)
               	cmpl	$0x7, %esi
               	jne	<addr>
               	movl	(%rdx), %edx
               	cmpl	$0x6, %edx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x10(%rsp), %rdx
               	lock
               	addq	$0x4, (%rdx)
               	movq	0x10(%rsp), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x4, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	lock
               	addq	$0x4, (%rax)
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
