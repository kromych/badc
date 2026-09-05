
many_args_host_stack_overflow.x64:	file format elf64-x86-64

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

<sum_eleven>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpl	$0x1, %edi
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	cmpl	$0x2, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	cmpl	$0x5, %r8d
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	cmpl	$0x6, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movslq	0x10(%rbp), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movslq	0x18(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movslq	0x20(%rbp), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movslq	0x28(%rbp), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movslq	0x30(%rbp), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq

<main>:
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
