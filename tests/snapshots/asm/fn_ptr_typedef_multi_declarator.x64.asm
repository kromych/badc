
fn_ptr_typedef_multi_declarator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<wide>:
               	movabsq	$0x123456789, %rax      # imm = 0x123456789
               	retq

<ident>:
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	leaq	-<rip>, %r12       # <addr>
               	movq	%rbx, %rax
               	callq	*%rax
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	callq	*%rax
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-<rip>, %r12       # <addr>
               	leaq	-0x28(%rbp), %rdi
               	movq	%r12, %rax
               	callq	*%rax
               	leaq	-0x28(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movq	%r12, %rax
               	callq	*%rax
               	leaq	-0x28(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movq	%rbx, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	%rbx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
