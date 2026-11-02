
vla_pointer_block_scope.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	0x1(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x1, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	<rip>, %rsi # <addr>
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x1, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rsi # <addr>
               	movq	%rsi, <rip> # <addr>
               	orq	%rdx, %rcx
               	leaq	0x2(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x2, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rcx
               	movq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x2(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x2, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	leaq	0x4(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x4, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rcx
               	movq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x4, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	leaq	0x8(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x8, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rcx
               	movq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x8, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	leaq	0x10(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x10, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rcx
               	movq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdx
               	subq	%rax, %rdx
               	cmpq	$0x10, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rcx, %rax
               	leave
               	retq
