
inline_asm_named_operands.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<move_named>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movl	%ebx, %eax
               	movq	-0x20(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movslq	-0x8(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<add_mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rbx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %rcx
               	movq	%rbx, %rax
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rbx
               	movq	-0x8(%rbp), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<modifier_named>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movl	%ebx, %eax
               	addl	%ebx, %eax
               	movq	-0x20(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movslq	-0x8(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<rw_named>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	0x10(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %r11
               	movl	(%r11), %eax
               	addl	$0x5, %eax
               	movq	-0x8(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x10(%rbp), %rax
               	movslq	0x10(%rbp), %rax
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
               	movl	$0x7, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rbx, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x48(%rbp), %rbx
               	movl	%ebx, %eax
               	movq	-0x50(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rbx
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1e, %eax
               	movl	$0xc, %ecx
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rbx, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	-0x40(%rbp), %rbx
               	movq	-0x38(%rbp), %rcx
               	movq	%rbx, %rax
               	addq	%rcx, %rax
               	movq	-0x48(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rbx
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x15, %eax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rbx, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	-0x48(%rbp), %rbx
               	movl	%ebx, %eax
               	addl	%ebx, %eax
               	movq	-0x50(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rbx
               	movslq	-0x28(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x25, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
