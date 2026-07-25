
inline_asm_x64_constraint_a.x64:	file format elf64-x86-64

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
               	movl	$0x14, %eax
               	movl	$0x16, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	movq	-0x58(%rbp), %rax
               	movq	-0x50(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	-0x60(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rcx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	-0x58(%rbp), %rax
               	movq	-0x50(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	-0x60(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x15, %eax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movq	%rax, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %rax
               	addq	%rax, %rax
               	movq	-0x68(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, -0x70(%rbp)
               	movq	%rax, -0x68(%rbp)
               	movq	-0x68(%rbp), %r10
               	movq	(%r10), %rax
               	addq	%rax, %rax
               	movq	-0x68(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x30(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	leaq	-0x38(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	andq	$0xff, %rax
               	movq	-0x68(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x38(%rbp), %rax
               	cmpq	$0x34, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %eax
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rax, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	andq	$0xff, %rax
               	movq	-0x68(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x40(%rbp), %rax
               	cmpq	$0xff, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
