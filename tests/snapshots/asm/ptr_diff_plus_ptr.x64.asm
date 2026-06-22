
ptr_diff_plus_ptr.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	movq	%r13, (%rsp)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	popq	%r11
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	addq	$0x20, %rdx
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	movq	%rsi, %rdi
               	sarq	$0x3f, %rdi
               	shrq	$0x3c, %rdi
               	addq	%rdi, %rsi
               	sarq	$0x4, %rsi
               	shlq	$0x4, %rsi
               	addq	%rcx, %rsi
               	leaq	-0x30(%rbp), %rdi
               	addq	$0x20, %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3c, %rdx
               	addq	%rdx, %rax
               	sarq	$0x4, %rax
               	shlq	$0x4, %rax
               	movq	%rcx, %rdx
               	addq	$0x10, %rdx
               	addq	%rdx, %rax
               	leaq	-0x30(%rbp), %rdx
               	addq	$0x30, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x20, %rax
               	leaq	-0x30(%rbp), %rcx
               	addq	$0x20, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
