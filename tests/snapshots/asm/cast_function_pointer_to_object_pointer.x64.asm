
cast_function_pointer_to_object_pointer.x64:	file format elf64-x86-64

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

<answer>:
               	movl	$0x2a, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, -0x8(%rbp)
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
