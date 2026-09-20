
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

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

<zero_and_sum>:
               	movl	$0x0, (%rdi)
               	leaq	0x28(%rdi), %rax
               	movl	$0x1, (%rax)
               	movl	$0x1, 0x4(%rdi)
               	movl	$0x2, 0x4(%rax)
               	movl	$0x2, 0x8(%rdi)
               	movl	$0x3, 0x8(%rax)
               	movl	$0x3, 0xc(%rdi)
               	movl	$0x4, 0xc(%rax)
               	movl	$0x4, 0x10(%rdi)
               	movl	$0x5, 0x10(%rax)
               	movl	$0x5, 0x14(%rdi)
               	movl	$0x6, 0x14(%rax)
               	movl	$0x6, 0x18(%rdi)
               	movl	$0x7, 0x18(%rax)
               	movl	$0x7, 0x1c(%rdi)
               	leaq	0x28(%rdi), %rax
               	movl	$0x8, 0x1c(%rax)
               	movl	$0x8, 0x20(%rdi)
               	movl	$0x9, 0x20(%rax)
               	movl	$0x9, 0x24(%rdi)
               	movl	$0xa, 0x24(%rax)
               	movl	$0x64, %eax
               	movl	%eax, 0xa0(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0xa8(%rbp), %rdi
               	callq	<addr>
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	0x3c(%rax), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movslq	0xa0(%rax), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
