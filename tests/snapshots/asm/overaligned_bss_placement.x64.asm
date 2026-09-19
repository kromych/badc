
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
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	testb	$0x7f, %dl
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rsi
               	testb	$-0x1, %sil
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movb	$0x1, (%rcx)
               	movb	$0x2, (%rdx)
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
