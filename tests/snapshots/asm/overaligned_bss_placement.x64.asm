
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
               	leaq	<rip>, %rcx
               	movq	%rcx, %rax
               	andq	$0x3f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0x7f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0xff, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movb	$0x1, (%rcx)
               	leaq	<rip>, %rdx
               	movb	$0x2, (%rdx)
               	leaq	<rip>, %rsi
               	movb	$0x3, (%rsi)
               	leaq	<rip>, %rdi
               	movl	$0x4, %eax
               	movl	%eax, (%rdi)
               	movzbq	(%rcx), %rcx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movzbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	addq	$0x4, %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
