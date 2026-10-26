
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
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rsi
               	orq	%rcx, %rsi
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rdi
               	xorl	%edx, %edx
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	subq	%rdx, %rdi
               	cmpq	$0x1, %rdi
               	setne	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdi, (%rcx)
               	orq	%rsi, %rdx
               	leaq	0x2(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x2, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rax
               	orq	%rax, %rdx
               	movq	(%rcx), %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	0x2(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x2, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rsi, (%rcx)
               	orq	%rax, %rdx
               	leaq	-0x40(%rbp), %rax
               	leaq	0x4(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x4, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rax
               	orq	%rax, %rdx
               	movq	(%rcx), %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	0x4(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x4, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rsi, (%rcx)
               	orq	%rax, %rdx
               	leaq	-0x40(%rbp), %rax
               	leaq	0x8(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x8, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rax
               	orq	%rax, %rdx
               	movq	(%rcx), %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	0x8(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rsi, (%rcx)
               	orq	%rax, %rdx
               	leaq	-0x40(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x10, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rax
               	orq	%rax, %rdx
               	movq	(%rcx), %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rsi, (%rcx)
               	orq	%rdx, %rax
               	leave
               	retq
