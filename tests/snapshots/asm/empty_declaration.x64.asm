
empty_declaration.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	movl	$0xb, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rsi
               	movl	$0xc, %edi
               	movl	%edi, (%rsi)
               	movslq	(%rcx), %rcx
               	addq	$0xc, %rcx
               	cmpl	$0x17, %ecx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	retq
