
inline_asm_output_reg.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	xorq	%rax, %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rax, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movq	%rbx, (%rax)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rbx
               	movl	$0xa, %eax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rbx, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rbx
               	leaq	0x7(%rbx), %rax
               	movq	-0x40(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%rbx, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rbx
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x30(%rbp), %r10
               	movq	%rbx, (%r10)
               	movq	-0x50(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
