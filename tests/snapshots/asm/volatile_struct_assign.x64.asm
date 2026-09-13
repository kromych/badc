
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
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rcx
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movl	(%rcx), %edx
               	movl	%edx, (%rax)
               	addq	$0x4, %rcx
               	movl	(%rcx), %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x6, %edx
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, %rsi
               	cmpl	$0x5, %esi
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
               	movl	%ecx, (%rax)
               	addq	$0x4, %rax
               	movl	%edx, (%rax)
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
