
address_constant_through_cast.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0xc(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rdx
               	cmpl	$0x63, %edx
               	jne	<addr>
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x64, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	addq	$0xc, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rcx # <addr>
               	addq	$0xa, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
