
recursion_factorial.x64:	file format elf64-x86-64

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

<fact>:
               	movl	$0x1, %eax
               	cmpl	$0x2, %edi
               	jl	<addr>
               	leaq	-0x1(%rdi), %rcx
               	imulq	%rdi, %rax
               	movq	%rcx, %rdi
               	cmpl	$0x2, %edi
               	jge	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	popq	%rbp
               	retq
