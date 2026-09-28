
typeof_row_bounds.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rax
               	movl	$0x0, (%rax)
               	movl	$0x1, 0x4(%rax)
               	movl	$0x2, 0x8(%rax)
               	movl	$0x3, 0xc(%rax)
               	addq	$0x10, %rax
               	movl	$0xa, (%rax)
               	movl	$0xb, 0x4(%rax)
               	movl	$0xc, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movl	$0xd, 0xc(%rcx)
               	addq	$0x20, %rax
               	movl	$0x14, (%rax)
               	movl	$0x15, 0x4(%rax)
               	movl	$0x16, 0x8(%rax)
               	movl	$0x17, 0xc(%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	0x2c(%rax), %rcx
               	cmpl	$0x17, %ecx
               	jne	<addr>
               	movslq	0x10(%rax), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
