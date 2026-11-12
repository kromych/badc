
array_typedef_pointer_casts.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx # <addr>
               	leaq	0xc(%rdx), %rax
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	0x8(%rcx), %rdi
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	0x8(%rsi), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	0xc(%rax), %rcx
               	subq	%rax, %rcx
               	xorl	%eax, %eax
               	movl	$0x3, %edx
               	cmpq	$0xc, %rcx
               	cmovneq	%rdx, %rax
               	retq
