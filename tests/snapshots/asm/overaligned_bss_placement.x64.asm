
overaligned_bss_placement.x64:	file format elf64-x86-64

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
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$-0x1, %al
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movb	$0x1, <rip> # <addr>
               	movb	$0x2, <rip> # <addr>
               	movb	$0x3, <rip> # <addr>
               	movl	$0x4, %eax
               	movl	%eax, <rip> # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	movzbq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	movzbq	<rip>, %rdx # <addr>
               	addq	%rdx, %rcx
               	addq	$0x4, %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
