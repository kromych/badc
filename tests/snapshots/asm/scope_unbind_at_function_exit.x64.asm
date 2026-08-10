
scope_unbind_at_function_exit.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<by_param>:
               	movslq	%edi, %rax
               	retq

<by_local>:
               	movl	$0x1, %eax
               	retq

<by_block>:
               	movl	$0x2, %eax
               	retq

<by_static>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	retq

<by_typedef>:
               	movl	$0x4, %eax
               	retq

<by_extern_over_enum>:
               	movl	$0x5, %eax
               	retq

<use_m>:
               	movslq	%edi, %rax
               	retq

<use_n>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<use_n2>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x37, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x58, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x58, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x79, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	xorq	%rax, %rax
               	retq
