
forward_fn_ptr_in_static_init.x64:	file format elf64-x86-64

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

<add_two>:
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<times_three>:
               	leaq	(%rdi,%rdi,2), %rax
               	movslq	%eax, %rax
               	retq

<minus_seven>:
               	leaq	-0x7(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %edi
               	leaq	<rip>, %rbx
               	leaq	(%rbx), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x5, %edi
               	movq	0x8(%rbx), %rax
               	callq	*%rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x64, %edi
               	movq	0x10(%rbx), %rax
               	callq	*%rax
               	cmpl	$0x5d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
