
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
               	xorq	%rax, %rax
               	leaq	(%rdi), %rcx
               	movl	%eax, (%rcx)
               	leaq	0x28(%rdi), %rax
               	leaq	(%rax), %rdx
               	movl	$0x1, %ecx
               	movl	%ecx, (%rdx)
               	movl	%ecx, 0x4(%rdi)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rdi)
               	movl	$0x3, %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rdi)
               	movl	$0x4, %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	%ecx, 0x10(%rdi)
               	movl	$0x5, %ecx
               	movl	%ecx, 0x10(%rax)
               	movl	%ecx, 0x14(%rdi)
               	movl	$0x6, %ecx
               	movl	%ecx, 0x14(%rax)
               	movl	%ecx, 0x18(%rdi)
               	movl	$0x7, %ecx
               	movl	%ecx, 0x18(%rax)
               	movl	%ecx, 0x1c(%rdi)
               	leaq	0x28(%rdi), %rax
               	movl	$0x8, %ecx
               	movl	%ecx, 0x1c(%rax)
               	movl	%ecx, 0x20(%rdi)
               	movl	$0x9, %ecx
               	movl	%ecx, 0x20(%rax)
               	movl	%ecx, 0x24(%rdi)
               	movl	$0xa, %ecx
               	movl	%ecx, 0x24(%rax)
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
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movslq	0x3c(%rax), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movslq	0xa0(%rax), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
