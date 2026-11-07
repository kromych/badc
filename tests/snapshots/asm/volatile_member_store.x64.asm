
volatile_member_store.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx # <addr>
               	movq	$0x29, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	addq	$0x3, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	decq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2d, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	$0x7, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x7, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x5, %eax
               	addq	$0x10, %rcx
               	movq	%rax, 0x8(%rcx)
               	movq	0x8(%rcx), %rdx
               	addq	$0x5, %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x8(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	andq	$-0x20, %rcx
               	orq	$0x9, %rcx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x1f, %rcx
               	incq	%rcx
               	andq	$0x1f, %rcx
               	movl	<rip>, %edx # <addr>
               	andq	$-0x20, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0x1f, %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
