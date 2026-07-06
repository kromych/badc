
block_extern_shadows_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<forward_probe>:
               	movl	$0x9, %eax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<param_probe>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	movl	$0x5, %eax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x5, %eax
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	addq	%rsi, %rcx
               	movl	$0x7, %esi
               	movl	%esi, (%rdx)
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x69, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x9, %eax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x3, %eax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x50, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
