
struct_stack_arg_then_scalar.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sink>:
               	popq	%r10
               	subq	$0x70, %rsp
               	movq	0x90(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	%r8, -0x20(%rbp)
               	movq	%r9, -0x18(%rbp)
               	movq	0x80(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x88(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x90(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x98(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	%rcx, %rdx
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	imulq	$0xf4240, %rcx, %rax    # imm = 0xF4240
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	imulq	$0x2710, %rcx, %rcx     # imm = 0x2710
               	addq	%rcx, %rax
               	imulq	$0x3e8, %rdx, %rcx      # imm = 0x3E8
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x40(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x70, %rsp
               	pushq	%r11
               	retq

<dp>:
               	popq	%r10
               	subq	$0x50, %rsp
               	movq	0x50(%rsp), %rax
               	movq	%rax, 0x40(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	%r8, -0x20(%rbp)
               	movq	%r9, -0x18(%rbp)
               	movq	%rcx, %rdx
               	movslq	%edx, %rdx
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %r8
               	pushq	%rcx
               	movq	(%r8), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r8), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x58(%rbp), %r8
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %r9
               	pushq	%rcx
               	movq	(%r9), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%r9), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x70(%rbp), %r9
               	movslq	0x50(%rbp), %rax
               	subq	$0x30, %rsp
               	movq	%rax, 0x20(%rsp)
               	movq	%r8, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	movq	0x8(%r8), %r9
               	movq	(%r8), %r8
               	callq	<addr>
               	addq	$0x30, %rsp
               	addq	$0x80, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x7, %edx
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x5, %r8d
               	subq	$0x10, %rsp
               	movq	%r8, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	movq	0x8(%r8), %r9
               	movq	(%r8), %r8
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x127a9e, %rax         # imm = 0x127A9E
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
