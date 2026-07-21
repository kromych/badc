
register_var_asm_operand_r11.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mark>:
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movl	$0x25, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%r11, -0x90(%rbp)
               	movq	%rax, -0x88(%rbp)
               	movq	-0x88(%rbp), %r10
               	movq	(%r10), %r11
               	addq	$0x5, %r11
               	movq	-0x88(%rbp), %r10
               	movq	%r11, (%r10)
               	movq	-0x90(%rbp), %r11
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	<rip>, %rcx
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rsi, -0x70(%rbp)
               	movq	%rdi, -0x68(%rbp)
               	movq	%r8, -0x60(%rbp)
               	movq	%r9, -0x58(%rbp)
               	movq	%r10, -0x50(%rbp)
               	movq	%r11, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	-0x40(%rbp), %rbx
               	movq	-0x38(%rbp), %r11
               	movq	%r11, (%rbx)
               	movq	-0x30(%rbp), %r10
               	callq	*%r10
               	movq	-0x90(%rbp), %rax
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rdx
               	movq	-0x78(%rbp), %rbx
               	movq	-0x70(%rbp), %rsi
               	movq	-0x68(%rbp), %rdi
               	movq	-0x60(%rbp), %r8
               	movq	-0x58(%rbp), %r9
               	movq	-0x50(%rbp), %r10
               	movq	-0x48(%rbp), %r11
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
