
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
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%edi, %ecx
               	jge	<addr>
               	addq	%rcx, %rax
               	incq	%rcx
               	cmpl	%edi, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq

<main>:
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	addq	%rax, %rcx
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq
