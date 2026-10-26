
code_address_plus_offset_initializer.x64:	file format elf64-x86-64

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

<before>:
               	movl	$0x1, %eax
               	retq

<after>:
               	movl	$0x2, %eax
               	retq

<main>:
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	-<rip>, %rcx # <addr>
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rdx), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x8, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	0x8(%rcx), %rcx
               	leaq	-<rip>, %rdx # <addr>
               	subq	%rdx, %rcx
               	cmpq	$-0x2, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x3, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	0x8(%rcx), %rcx
               	leaq	-<rip>, %rdx # <addr>
               	subq	%rdx, %rcx
               	cmpq	$0x10, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
