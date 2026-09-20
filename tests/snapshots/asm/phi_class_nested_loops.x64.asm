
phi_class_nested_loops.x64:	file format elf64-x86-64

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
               	movq	%rax, %r8
               	cmpl	%edi, %r8d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%edi, %edx
               	jge	<addr>
               	incq	%rcx
               	incq	%rdx
               	cmpl	%edi, %edx
               	jl	<addr>
               	addq	%rcx, %rax
               	incq	%r8
               	cmpl	%edi, %r8d
               	jl	<addr>
               	retq

<main>:
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	incq	%rcx
               	incq	%rdx
               	cmpl	$0x7, %edx
               	jl	<addr>
               	addq	%rcx, %rax
               	incq	%rdi
               	cmpl	$0x7, %edi
               	jl	<addr>
               	retq
