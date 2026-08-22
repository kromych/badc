
phi_class_for_loop_sum.x64:	file format elf64-x86-64

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

<test>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq
