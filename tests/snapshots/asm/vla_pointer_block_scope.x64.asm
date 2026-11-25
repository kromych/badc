
vla_pointer_block_scope.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rcx
               	leaq	0x1(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x1, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	0x1(%rdx), %rax
               	subq	%rdx, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rsi, %rax
               	leaq	0x2(%rcx), %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x2, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rax
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	0x2(%rcx), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x2, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rax, %rcx
               	leaq	(%rsp), %rax
               	leaq	0x4(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x4, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rcx
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
               	orq	%rcx, %rax
               	leaq	(%rsp), %rcx
               	leaq	0x8(%rcx), %rsi
               	subq	%rcx, %rsi
               	cmpq	$0x8, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rax
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	0x8(%rcx), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x8, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rax, %rcx
               	leaq	(%rsp), %rax
               	leaq	0x10(%rax), %rsi
               	subq	%rax, %rsi
               	cmpq	$0x10, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	orq	%rax, %rcx
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
               	addq	$0x48, %rsp
               	retq
