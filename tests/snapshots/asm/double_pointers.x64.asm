
double_pointers.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movl	$0xa, 0x10(%rsp)
               	leaq	0x10(%rsp), %rax
               	movq	%rax, 0x18(%rsp)
               	movl	$0x2a, (%rax)
               	movl	0x10(%rsp), %ecx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
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
               	addq	$0x28, %rsp
               	retq
               	movl	(%rax), %eax
               	cmpl	$0x7b, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
