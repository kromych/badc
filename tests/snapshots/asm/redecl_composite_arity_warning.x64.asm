
redecl_composite_arity_warning.x64:	file format elf64-x86-64

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

<take_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	leave
               	retq

<add2>:
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
