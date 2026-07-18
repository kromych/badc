
runtime_struct_array_member_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0xa8(%rbp), %rax
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
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	movq	0x50(%rcx), %rdx
               	movq	%rdx, 0x50(%rax)
               	movq	0x58(%rcx), %rdx
               	movq	%rdx, 0x58(%rax)
               	movq	0x60(%rcx), %rdx
               	movq	%rdx, 0x60(%rax)
               	movq	0x68(%rcx), %rdx
               	movq	%rdx, 0x68(%rax)
               	movq	0x70(%rcx), %rdx
               	movq	%rdx, 0x70(%rax)
               	movq	0x78(%rcx), %rdx
               	movq	%rdx, 0x78(%rax)
               	movq	0x80(%rcx), %rdx
               	movq	%rdx, 0x80(%rax)
               	movq	0x88(%rcx), %rdx
               	movq	%rdx, 0x88(%rax)
               	movq	0x90(%rcx), %rdx
               	movq	%rdx, 0x90(%rax)
               	movq	0x98(%rcx), %rdx
               	movq	%rdx, 0x98(%rax)
               	movq	0xa0(%rcx), %rdx
               	movq	%rdx, 0xa0(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	leaq	-0xa8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rcx
               	leaq	-0xa8(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rax
               	leaq	-0xa8(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	movl	$0x1000, %edx           # imm = 0x1000
               	leaq	-0xa8(%rbp), %rcx
               	movq	%rdx, 0x18(%rcx)
               	movl	$0x1, %edx
               	leaq	-0xa8(%rbp), %rcx
               	movl	%edx, 0x20(%rcx)
               	movl	$0x2, %edx
               	leaq	-0xa8(%rbp), %rcx
               	movl	%edx, 0x24(%rcx)
               	movl	$0x3, %edx
               	leaq	-0xa8(%rbp), %rcx
               	movl	%edx, 0x28(%rcx)
               	leaq	<rip>, %rdx
               	leaq	-0xa8(%rbp), %rcx
               	movq	%rdx, 0x30(%rcx)
               	leaq	0x8(%rax), %rdx
               	leaq	-0xa8(%rbp), %rcx
               	movq	%rdx, 0x38(%rcx)
               	movl	$0x2000, %edx           # imm = 0x2000
               	leaq	-0xa8(%rbp), %rcx
               	movq	%rdx, 0x40(%rcx)
               	leaq	-0xa8(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rcx
               	movq	0x18(%rcx), %rcx
               	cmpq	$0x1000, %rcx           # imm = 0x1000
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rcx
               	movslq	0x20(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rcx
               	movslq	0x28(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rcx
               	movq	0x38(%rcx), %rcx
               	addq	$0x8, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movq	0x38(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movq	0x40(%rax), %rax
               	cmpq	$0x2000, %rax           # imm = 0x2000
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movslq	0x48(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movq	0x30(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x70, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movq	0x58(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
