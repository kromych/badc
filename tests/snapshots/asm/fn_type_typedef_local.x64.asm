
fn_type_typedef_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	movq	%rdi, %rax
               	shlq	%rax
               	movslq	%eax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x7, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movq	%rbx, %rax
               	callq	*%rax
               	movq	%rax, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, -0x28(%rbp)
               	movl	$0x4, %edi
               	movq	-0x28(%rbp), %rax
               	callq	*%rax
               	movq	%rax, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	leaq	-0x78(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x5, %edi
               	callq	*%rax
               	movq	%rax, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
