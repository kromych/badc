
inline_asm_x64_const_expr.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
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
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x58(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	0x10(%rbx), %rax
               	adcq	0x18(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movq	-0x30(%rbp), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x64, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x58(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	0x10(%rbx), %rax
               	adcq	0x18(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movq	-0x38(%rbp), %rax
               	cmpq	$0x6a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %rax
               	addq	$0x19, %rax
               	movq	-0x68(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
