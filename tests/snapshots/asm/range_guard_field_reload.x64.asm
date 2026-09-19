
range_guard_field_reload.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<fill>:
               	movq	$0x1, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	%eax, 0x10(%rdi)
               	movl	$0x0, 0x14(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	<rip>, %rax
               	movq	$0x64, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x7, (%rax)
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	-0x18(%rbp), %rcx
               	movq	0x8(%rcx), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	movq	$-0x16, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movabsq	$0x7ffffffffffffffc, %rdx # imm = 0x7FFFFFFFFFFFFFFC
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rcx, %rdi
               	callq	*%rax
               	leaq	-0x18(%rbp), %rcx
               	movq	0x8(%rcx), %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jb	<addr>
               	movq	$-0x16, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movabsq	$-0x7ffffffffffffffc, %rdx # imm = 0x8000000000000004
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rcx, %rdi
               	callq	*%rax
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	jb	<addr>
               	movq	$-0x16, %rax
               	cmpl	$-0x16, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rdx
               	movl	0x10(%rax), %eax
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jb	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	0x8(%rcx), %rsi
               	movl	0x10(%rcx), %eax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rsi, %rdx
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	0x8(%rcx), %rsi
               	movl	0x10(%rcx), %eax
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	subq	%rsi, %rdx
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
