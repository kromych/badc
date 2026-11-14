
double_pointers.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xa, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x2a, (%rax)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x8, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %edi
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movq	%rax, (%rcx)
               	movl	$0x7b, (%rax)
               	movq	(%rcx), %rax
               	movl	(%rax), %ecx
               	cmpl	$0x7b, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	(%rax), %eax
               	cmpl	$0x7b, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
