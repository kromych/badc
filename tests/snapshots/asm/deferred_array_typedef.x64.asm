
deferred_array_typedef.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	movslq	0xc(%rsi), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x18, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
