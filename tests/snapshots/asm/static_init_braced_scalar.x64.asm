
static_init_braced_scalar.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xc0050000, %r11d      # imm = 0xC0050000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
