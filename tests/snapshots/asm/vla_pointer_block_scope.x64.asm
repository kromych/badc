
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
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	<rip>, %rcx # <addr>
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x1(%rcx), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	orq	%rsi, %rdx
               	leaq	0x2(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x2, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rdx
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x2(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x2, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
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
