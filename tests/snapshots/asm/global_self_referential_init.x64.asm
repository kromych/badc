
global_self_referential_init.x64:	file format elf64-x86-64

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

<drop>:
               	movq	%rdi, %rax
               	negq	%rax
               	retq

<main>:
               	pushq	%rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x10(%rcx), %rax
               	movq	(%rax), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	leaq	0x30(%rcx), %rax
               	movq	(%rax), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	0x50(%rcx), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	subq	%rcx, %rax
               	addq	%rcx, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x3, %edi
               	callq	*%rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
