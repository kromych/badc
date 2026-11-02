
static_initializer_address_casts.x64:	file format elf64-x86-64

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

<f>:
               	movl	$0x1, %eax
               	retq

<main>:
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x4(%rdx), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	addq	$0x4, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x4, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	addq	$0x8, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	addq	$0x8, %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
