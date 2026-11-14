
packed_int128_odd_offset.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	0x1(%rcx), %rax
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	movq	%rax, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	0x1(%rax), %rdx
               	cmpq	%rax, %rdx
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rcx, %rax
               	movq	%rdx, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	cmpl	$0xd, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	$0xa, <rip> # <addr>
               	movq	$0xe, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	retq
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
