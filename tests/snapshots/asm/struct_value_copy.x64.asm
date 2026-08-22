
struct_value_copy.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	movl	$0x2, %eax
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x63, %esi
               	movl	%esi, (%rax)
               	movl	%esi, 0x4(%rax)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movslq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movl	%ecx, (%rax)
               	movl	$0x7d0, %ecx            # imm = 0x7D0
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x32, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x3c, %ecx
               	movl	%ecx, 0x4(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rax, %rcx
               	movslq	(%rax), %rax
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
