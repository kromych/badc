
many_args_host_stack_overflow.x64:	file format elf64-x86-64

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

<sum_eleven>:
               	cmpl	$0x1, %edi
               	jne	<addr>
               	cmpl	$0x2, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpl	$0x5, %r8d
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0x6, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	0x8(%rsp), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	0x10(%rsp), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	0x18(%rsp), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movl	0x20(%rsp), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	0x28(%rsp), %eax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
