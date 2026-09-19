
mem2reg_value_across_call.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	%rdx
               	incq	%rdx
               	addq	%rdx, %rcx
               	leaq	0x7(%rax), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	andq	$0x7f, %rax
               	retq
