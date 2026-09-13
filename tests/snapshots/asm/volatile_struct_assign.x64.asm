
volatile_struct_assign.x64:	file format elf64-x86-64

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
               	leaq	-0x18(%rbp), %rdx
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, (%rdx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movl	(%rdx), %esi
               	movl	%esi, (%rax)
               	addq	$0x4, %rdx
               	movl	(%rdx), %edx
               	movl	%edx, 0x4(%rax)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movslq	0x4(%rax), %rdx
               	cmpl	$0x4, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movslq	(%rax), %rdx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	(%rcx), %edx
               	movl	%edx, (%rax)
               	movl	0x4(%rcx), %ecx
               	addq	$0x4, %rax
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movl	(%rax), %ecx
               	addq	$0x4, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
