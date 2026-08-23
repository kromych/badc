
libc_struct_return.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	movl	$0x11, %edi
               	movl	$0x5, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rbx
               	leaq	-0x10(%rbp), %rax
               	pushq	%rcx
               	movq	(%rbx), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rax, %rcx
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rax
               	imulq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	movl	$0x7, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	pushq	%rcx
               	movq	(%rbx), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rax, %rcx
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
