
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
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	0x1(%rdx), %rsi
               	subq	%rdx, %rsi
               	cmpq	$0x1, %rsi
               	setne	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	%rsi, <rip> # <addr>
               	orq	%rdi, %rdx
               	leaq	0x2(%rcx), %rdi
               	subq	%rcx, %rdi
               	cmpq	$0x2, %rdi
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rdx
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	0x2(%rsi), %rax
               	subq	%rsi, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rsi # <addr>
               	movq	%rsi, <rip> # <addr>
               	orq	%rdx, %rax
               	leaq	(%rsp), %rcx
               	leaq	0x4(%rcx), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x4, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	orq	%rcx, %rax
               	xorl	%ecx, %ecx
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	0x4(%rsi), %rdx
               	subq	%rsi, %rdx
               	cmpq	$0x4, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rax, %rsi
               	leaq	(%rsp), %rax
               	leaq	0x8(%rax), %rdi
               	subq	%rax, %rdi
               	cmpq	$0x8, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	orq	%rdi, %rsi
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	0x8(%rdi), %rcx
               	subq	%rdi, %rcx
               	cmpq	$0x8, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rdx, <rip> # <addr>
               	orq	%rsi, %rcx
               	leaq	0x10(%rax), %rsi
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	cmpq	$0x10, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	leaq	(%rsp), %rdi
               	subq	%rdi, %rsi
               	cmpq	$0x10, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	orq	%rsi, %rax
               	orq	%rax, %rcx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	0x10(%rdx), %rax
               	subq	%rdx, %rax
               	cmpq	$0x10, %rax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	orq	%rcx, %rax
               	addq	$0x48, %rsp
               	retq
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
