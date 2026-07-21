
inline_asm_x64_constraint_a.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<double_in_place>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %r11
               	movq	(%r11), %rax
               	addq	%rax, %rax
               	movq	-0x8(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x10(%rbp), %rax
               	movq	0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0x14, %eax
               	movl	$0x16, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rax, -0x60(%rbp)
               	movq	%rbx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	-0x40(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	-0x50(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rbx
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rbx, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	-0x40(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	-0x50(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rbx
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x15, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1234, %eax           # imm = 0x1234
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	andq	$0xff, %rax
               	movq	-0x58(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x34, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %eax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	andq	$0xff, %rax
               	movq	-0x58(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x30(%rbp), %rax
               	cmpq	$0xff, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
