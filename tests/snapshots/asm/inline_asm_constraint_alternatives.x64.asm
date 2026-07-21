
inline_asm_constraint_alternatives.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	movl	$0x14, %eax
               	movl	$0x5, %ecx
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
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movl	$0x4, %ecx
               	leaq	-0x20(%rbp), %rdx
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
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0x28(%rbp), %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	addq	$0x7, %rax
               	movq	-0x58(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movl	$0x20, %ecx
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rbx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	-0x50(%rbp), %r11
               	movq	(%r11), %rax
               	movq	-0x48(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	-0x50(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rbx
               	movq	-0x30(%rbp), %rax
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
