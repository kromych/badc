
local_multidim_struct_array_designator.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	movslq	0x18(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x1c(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x9, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rdx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x14(%rcx), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	movq	0x20(%rdx), %rax
               	movq	%rax, 0x20(%rcx)
               	movq	0x28(%rdx), %rax
               	movq	%rax, 0x28(%rcx)
               	movq	0x30(%rdx), %rax
               	movq	%rax, 0x30(%rcx)
               	movq	0x38(%rdx), %rax
               	movq	%rax, 0x38(%rcx)
               	popq	%rax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rcx), %rax
               	movq	%rax, 0x18(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rcx), %rax
               	movq	%rax, 0x18(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movq	%rax, %rcx
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
